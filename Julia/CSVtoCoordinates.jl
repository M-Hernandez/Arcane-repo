module CSVtoVector

using DelimitedFiles
export getcoordinates

function getCoordinates(file)
    matrix = readdlm(file, ',',Float64)
    return [matrix[i, :] for i in 1:size(matrix,1)]
end
end
