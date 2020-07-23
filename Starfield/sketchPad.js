var stars = [];
let numOfStars = 800;
let speedInput, button, title, text, buttonPressed, backButton;
let speed;
function setup(){
	createCanvas(window.screen.width,window.screen.height);
	background(0);

	title = createElement('h1', 'Starfield');
	title.style('color', '#ffffff');
	title.position(title.center(),100);

	text = createElement('h4', 'Please input the speed for stars. Values 1-100');
	text.style('color', '#ffffff');
	text.position(text.center(),title.y + 200);

	speedInput = createInput();
	speedInput.position(speedInput.center(), title.y + 250);

	button = createButton('Generate');
	button.position(button.center(), speedInput.y + speedInput.height + 20);
	button.mousePressed(submit);


	for(var i = 0; i < numOfStars; i++){
		stars[i] = new Star();
	}
}

function submit(){

	speed = speedInput.value();

	title.hide();
	text.hide();
	speedInput.hide();
	button.hide();

	buttonPressed = true;
	loop();


}

function draw(){

	if(buttonPressed){

		title.attribute('disabled', '');
		background(0);
		translate(window.screen.width/2, window.screen.height/2);
		for(var i = 0; i < stars.length; i++){	
		stars[i].update();		
		stars[i].show(); 
		}
	}
	if(keyCode === 27){
		clear();
		background(0);
		setup();
		noLoop();

	}

}



