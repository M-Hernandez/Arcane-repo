module GetCoordinates

using CSV
using DataFrames

function convertToCoordinates(matrix)
    return [matrix[i, :] for i in 1:size(matrix,1)]
end

file = "src/data/Lift&Lowering_005_76_14_13_2-28-2020_NO_HEADERS.tsv"
data = CSV.read(file)

matrix = convert(Matrix,data)
matrix = [x/1000 for x in matrix]

HeadFrontXYZ = convertToCoordinates(matrix[:,1:3])
ChestXYZ = convertToCoordinates(matrix[:,4:6])
LShoulderTopXYZ = convertToCoordinates(matrix[:,7:9])
RShoulderTopXYZ = convertToCoordinates(matrix[:,10:12])
LElbowOutXYZ = convertToCoordinates(matrix[:,13:15])
RElbowOutXYZ = convertToCoordinates(matrix[:,16:18])
LWristInXYZ = convertToCoordinates(matrix[:,19:21])
RWristInXYZ = convertToCoordinates(matrix[:,22:24])
WaistLFrontXYZ = convertToCoordinates(matrix[:,25:27])
WaistRFrontXYZ = convertToCoordinates(matrix[:,28:30])
LThighXYZ = convertToCoordinates(matrix[:,31:33])
RThighXYZ = convertToCoordinates(matrix[:,34:36])
LKneeOutXYZ = convertToCoordinates(matrix[:,37:39])
RKneeOutXYZ = convertToCoordinates(matrix[:,40:42])
LShinXYZ = convertToCoordinates(matrix[:,43:45])
RShinXYZ = convertToCoordinates(matrix[:,46:48])
LAnkleOutXYZ = convertToCoordinates(matrix[:,49:51])
RAnkleOutXYZ = convertToCoordinates(matrix[:,52:54])
LForefootOutXYZ = convertToCoordinates(matrix[:,55:57])
RForefootOutXYZ = convertToCoordinates(matrix[:,58:60])
LToeTipXYZ = convertToCoordinates(matrix[:,61:63])
RToeTipXYZ = convertToCoordinates(matrix[:,64:66])
SpineTopXYZ = convertToCoordinates(matrix[:,67:69])
LShoulderBackXYZ = convertToCoordinates(matrix[:,70:72])
RShoulderBackXYZ = convertToCoordinates(matrix[:,73:75])
BackLXYZ = convertToCoordinates(matrix[:,76:78])
BackRXYZ = convertToCoordinates(matrix[:,79:81])
LArmXYZ = convertToCoordinates(matrix[:,82:84])
RArmXYZ = convertToCoordinates(matrix[:,85:87])
LWristOutXYZ = convertToCoordinates(matrix[:,88:90])
RWristOutXYZ = convertToCoordinates(matrix[:,91:93])
LHandOutXYZ = convertToCoordinates(matrix[:,94:96])
RHandOutXYZ = convertToCoordinates(matrix[:,97:99])
WaistLBackXYZ = convertToCoordinates(matrix[:,100:102])
WaistRBackXYZ = convertToCoordinates(matrix[:,103:105])
LHeelBackXYZ = convertToCoordinates(matrix[:,106:108])
RHeelBackXYZ = convertToCoordinates(matrix[:,109:111])
Hips_WaistLFrontXYZ = convertToCoordinates(matrix[:,112:114])
Hips_WaistRFrontXYZ = convertToCoordinates(matrix[:,115:117])
BackTopXYZ = convertToCoordinates(matrix[:,118:120])
BackMiddleXYZ = convertToCoordinates(matrix[:,121:123])
BackLowXYZ = convertToCoordinates(matrix[:,124:126])



end
