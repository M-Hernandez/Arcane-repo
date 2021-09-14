/*
Fractal code for CS 4380 / CS 5351

Copyright (c) 2020 Texas State University. All rights reserved.

Redistribution in source or binary form, with or without modification,
is *not* permitted. Use in source or binary form, with or without
modification, is only permitted for academic use in CS 4380 or CS 5351
at Texas State University.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Author: Martin Burtscher
*/

#include <cstdio>
#include <cmath>
#include <algorithm>
#include <sys/time.h>
#include "BMP43805351.h"
#include "mpi.h"

static void fractal(const int width, const int frames, unsigned char* const pic, int my_start, int my_end)
{
  const double Delta = 0.00304;
  const double xMid = -0.055846456;
  const double yMid = -0.668311119;

  // compute pixels of each frame
  double delta = Delta * pow(.975, my_start);
  for (int frame = 0; frame < (my_end - my_start); frame++) {  // frames
    const double xMin = xMid - delta;
    const double yMin = yMid - delta;
    const double dw = 2.0 * delta / width;
    for (int row = 0; row < width; row++) {  // rows
      const double cy = yMin + row * dw;
      for (int col = 0; col < width; col++) {  // columns
        const double cx = xMin + col * dw;
        double x = cx;
        double y = cy;
        double x2, y2;
        int count = 256;
        do {
          x2 = x * x;
          y2 = y * y;
          y = 2.0 * x * y + cy;
          x = x2 - y2 + cx;
          count--;
        } while ((count > 0) && ((x2 + y2) <= 5.0));
        pic[frame * width * width + row * width + col] = (unsigned char)count;
      }
    }
    delta *= .975;
  }
}

int main(int argc, char *argv[])
{

  // set up MPI
  int comm_sz, my_rank;
  MPI_Init(NULL, NULL);
  MPI_Comm_size(MPI_COMM_WORLD, &comm_sz);
  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);  

  // check command line
  if (argc != 3) {fprintf(stderr, "USAGE: %s frame_width number_of_frames\n", argv[0]); exit(-1);}
  const int width = atoi(argv[1]);
  if (width < 8) {fprintf(stderr, "ERROR: frame_width must be at least 8\n"); exit(-1);}
  const int frames = atoi(argv[2]);
  if (frames < 1) {fprintf(stderr, "ERROR: number_of_frames must be at least 1\n"); exit(-1);}

  if(my_rank == 0){
    printf("Fractal v2.1\n");
    printf("frames: %d\n", frames);
    printf("width: %d\n", width);
  }

  if(frames % comm_sz != 0) {fprintf(stderr, "ERROR: Frames is not a multiple of the number of processes\n"); exit(-1);}

  if(my_rank == 0){
    printf("Number of processes %d\n", comm_sz);
  }

  const int my_start = my_rank * (long)frames / comm_sz;
  const int my_end = (my_rank + 1) * (long)frames / comm_sz;
  // allocate picture array

  unsigned char* final_pic = NULL;
  if(my_rank == 0){
    final_pic = new unsigned char [frames * width * width];
  }
  unsigned char* pic = new unsigned char [(my_end - my_start) * width * width];

  // start time
  timeval start, end;
  MPI_Barrier(MPI_COMM_WORLD);
  gettimeofday(&start, NULL);

  // execute timed code
  fractal(width, frames, pic, my_start, my_end);

  MPI_Gather(pic, (my_end - my_start) * width * width, MPI_UNSIGNED_CHAR, final_pic, (my_end - my_start)* width * width, MPI_UNSIGNED_CHAR, 0, MPI_COMM_WORLD);

  // end time
  gettimeofday(&end, NULL);
  const double runtime = end.tv_sec - start.tv_sec + (end.tv_usec - start.tv_usec) / 1000000.0;
  if(my_rank == 0){
    printf("compute time: %.6f s\n", runtime);
  }

      // write result to BMP files
  if(my_rank == 0){
      if ((width <= 256) && (frames <= 64)) {
        for (int frame = 0; frame < frames; frame++) {
          BMP24 bmp(0, 0, width, width);
          for (int y = 0; y < width; y++) {
            for (int x = 0; x < width; x++) {
              bmp.dot(x, y, final_pic[frame * width * width + y * width + x] * 0x010101);
            }
          }
          char name[32];
          sprintf(name, "fractal%d.bmp", frame + 1000);
          bmp.save(name);
        }
      }
    }

  // clean up
  delete [] pic;
  delete [] final_pic;
  MPI_Finalize();
  return 0;
}
