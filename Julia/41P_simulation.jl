using MeshCat
using GeometryTypes
using CoordinateTransformations
using StaticArrays

include("GetCoordinatesfromTSV.jl")
using .GetCoordinates


#Setting different configuration of frames for testing
FullFramesLength = 181172
HalfFramesLength = 90586
FourthFramesLength = 45293
EighthFramesLength = 22646
oneMinFramesLength = 6000

#Number of frames used to run simulation
NumofFrames = oneMinFramesLength


#Setting each marker of the body with array of coordinates
#Type: Array{Array{Float64,1},1}
Head = GetCoordinates.HeadFrontXYZ
Chest = GetCoordinates.ChestXYZ
Spine = GetCoordinates.SpineTopXYZ
BackTop = GetCoordinates.BackTopXYZ
BackMiddle = GetCoordinates.BackMiddleXYZ
BackLow = GetCoordinates.BackLowXYZ
LeftBack = GetCoordinates.BackLXYZ
RightBack = GetCoordinates.BackRXYZ

RightShoulder = GetCoordinates.RShoulderTopXYZ
RightElbow = GetCoordinates.RElbowOutXYZ
RightWrist = GetCoordinates.RWristInXYZ

LeftArm = GetCoordinates.LArmXYZ
RightArm = GetCoordinates.RArmXYZ

LeftHandOut = GetCoordinates.LHandOutXYZ
RightHandOut = GetCoordinates.RHandOutXYZ

LeftShoulder = GetCoordinates.LShoulderTopXYZ
LeftElbow = GetCoordinates.LElbowOutXYZ
LeftWrist = GetCoordinates.LWristInXYZ

LeftWaistFront = GetCoordinates.WaistLFrontXYZ
RightWaistFront = GetCoordinates.WaistRFrontXYZ

LeftHips_waist = GetCoordinates.Hips_WaistLFrontXYZ
RightHips_waist = GetCoordinates.Hips_WaistRFrontXYZ

LeftWaistBack = GetCoordinates.WaistLBackXYZ
RightWaistBack= GetCoordinates.WaistRBackXYZ

LeftThigh= GetCoordinates.LThighXYZ
RightThigh = GetCoordinates.RThighXYZ

LeftKnee = GetCoordinates.LKneeOutXYZ
RightKnee = GetCoordinates.RKneeOutXYZ

LeftShin = GetCoordinates.LShinXYZ
RightShin = GetCoordinates.RShinXYZ

LeftAnkle = GetCoordinates.LAnkleOutXYZ
RightAnkle = GetCoordinates.RAnkleOutXYZ

RightHeel = GetCoordinates.RHeelBackXYZ
LeftHeel = GetCoordinates.LHeelBackXYZ

LeftForefoot = GetCoordinates.LForefootOutXYZ
RightForefoot = GetCoordinates.RForefootOutXYZ

LeftToeTip = GetCoordinates.LToeTipXYZ
RightToeTip = GetCoordinates.RToeTipXYZ


#Creating visualizer for 3D simulation
vis = Visualizer()

#setting radius of each sphere representing marker
pointRadius = .025

#opening visualizer in a windo (Note: Opens visualizer before simulation is calculated)
open(vis)

#The following "setobject!" creates the sphere objects for use in viusalizer
setobject!(vis[:Head][:Head], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:Torso][:Chest], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:Torso][:Spine], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:Torso][:BackTop], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:Torso][:BackMiddle], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:Torso][:BackLow], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:Torso][:BackLeft], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:Torso][:BackRight], Sphere(Point(0.0,0.0,0.0),pointRadius))

setobject!(vis[:RightHand][:Shoulder], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:RightHand][:Elbow], Sphere(Point(0.,0,0),pointRadius))
setobject!(vis[:RightHand][:Wrist], Sphere(Point(0.,0,0),pointRadius))
setobject!(vis[:RightHand][:Arm], Sphere(Point(0.,0,0),pointRadius))
setobject!(vis[:RightHand][:OuterHand], Sphere(Point(0.,0,0),pointRadius))

setobject!(vis[:LeftHand][:Shoulder], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:LeftHand][:Elbow], Sphere(Point(0.,0,0),pointRadius))
setobject!(vis[:LeftHand][:Wrist], Sphere(Point(0.,0,0),pointRadius))
setobject!(vis[:LeftHand][:Arm], Sphere(Point(0.,0,0),pointRadius))
setobject!(vis[:LeftHand][:OuterHand], Sphere(Point(0.,0,0),pointRadius))

setobject!(vis[:RightLeg][:WaistFront], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:RightLeg][:WaistBack], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:RightLeg][:hips_waist], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:RightLeg][:Thigh], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:RightLeg][:Shin], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:RightLeg][:Knee], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:RightLeg][:Ankle], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:RightLeg][:Heel], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:RightLeg][:Forefoot], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:RightLeg][:ToeTip], Sphere(Point(0.0,0.0,0.0),pointRadius))

setobject!(vis[:LeftLeg][:WaistFront], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:LeftLeg][:WaistBack], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:LeftLeg][:hips_waist], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:LeftLeg][:Thigh], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:LeftLeg][:Shin], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:LeftLeg][:Knee], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:LeftLeg][:Ankle], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:LeftLeg][:Heel], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:LeftLeg][:Forefoot], Sphere(Point(0.0,0.0,0.0),pointRadius))
setobject!(vis[:LeftLeg][:ToeTip], Sphere(Point(0.0,0.0,0.0),pointRadius))


#Creating animation for 3D simulation
anim = Animation()


#Looping through each frame of length "NumofFrames"
for i in 1:NumofFrames
        atframe(anim, i) do

        #Changing position of each sphere every frame
        #settransform! is recorded in animation instead of visualizer
        settransform!(vis[:Head][:Head], Translation(Head[i]))
        settransform!(vis[:Torso][:Chest], Translation(Chest[i]))
        settransform!(vis[:Torso][:Spine], Translation(Spine[i]))
        settransform!(vis[:Torso][:BackTop], Translation(BackTop[i]))
        settransform!(vis[:Torso][:BackMiddle], Translation(BackMiddle[i]))
        settransform!(vis[:Torso][:BackLow], Translation(BackLow[i]))
        settransform!(vis[:Torso][:BackLeft], Translation(LeftBack[i]))
        settransform!(vis[:Torso][:BackRight], Translation(RightBack[i]))

        settransform!(vis[:RightHand][:Shoulder], Translation(RightShoulder[i]))
        settransform!(vis[:RightHand][:Elbow], Translation(RightElbow[i]))
        settransform!(vis[:RightHand][:Wrist], Translation(RightWrist[i]))
        settransform!(vis[:RightHand][:Arm], Translation(RightArm[i]))
        settransform!(vis[:RightHand][:OuterHand], Translation(RightHandOut[i]))

        settransform!(vis[:LeftHand][:Shoulder], Translation(LeftShoulder[i]))
        settransform!(vis[:LeftHand][:Elbow], Translation(LeftElbow[i]))
        settransform!(vis[:LeftHand][:Wrist], Translation(LeftWrist[i]))
        settransform!(vis[:LeftHand][:Arm], Translation(LeftArm[i]))
        settransform!(vis[:LeftHand][:OuterHand], Translation(LeftHandOut[i]))

        settransform!(vis[:RightLeg][:WaistFront], Translation(RightWaistFront[i]))
        settransform!(vis[:RightLeg][:WaistBack], Translation(RightWaistBack[i]))
        settransform!(vis[:RightLeg][:hips_waist], Translation(RightHips_waist[i]))
        settransform!(vis[:RightLeg][:Thigh], Translation(RightThigh[i]))
        settransform!(vis[:RightLeg][:Shin], Translation(RightShin[i]))
        settransform!(vis[:RightLeg][:Knee], Translation(RightKnee[i]))
        settransform!(vis[:RightLeg][:Ankle], Translation(RightAnkle[i]))
        settransform!(vis[:RightLeg][:Heel], Translation(RightHeel[i]))
        settransform!(vis[:RightLeg][:Forefoot], Translation(RightForefoot[i]))
        settransform!(vis[:RightLeg][:ToeTip], Translation(RightToeTip[i]))

        settransform!(vis[:LeftLeg][:WaistFront], Translation(LeftWaistFront[i]))
        settransform!(vis[:LeftLeg][:WaistBack], Translation(LeftWaistBack[i]))
        settransform!(vis[:LeftLeg][:hips_waist], Translation(LeftHips_waist[i]))
        settransform!(vis[:LeftLeg][:Thigh], Translation(LeftThigh[i]))
        settransform!(vis[:LeftLeg][:Shin], Translation(LeftShin[i]))
        settransform!(vis[:LeftLeg][:Knee], Translation(LeftKnee[i]))
        settransform!(vis[:LeftLeg][:Ankle], Translation(LeftAnkle[i]))
        settransform!(vis[:LeftLeg][:Heel], Translation(LeftHeel[i]))
        settransform!(vis[:LeftLeg][:Forefoot], Translation(LeftForefoot[i]))
        settransform!(vis[:LeftLeg][:ToeTip], Translation(LeftToeTip[i]))

    end
end

#Sending animation "anim" to visualizer "vis"
setanimation!(vis, anim)
