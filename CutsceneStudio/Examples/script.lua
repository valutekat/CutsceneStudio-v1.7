task.wait(2) -- Waiting for 2 seconds
local CutsceneStudio = require(game:GetService("ReplicatedStorage").CutsceneStudio) -- Importing the module
local Cutscene = CutsceneStudio.Cutscene() -- Creating a new cutscene
local Follow = Cutscene:Follow(workspace.Rig.Head)
local DS = Cutscene:DynamicShake()

Follow:Follow() -- Starting following a part
local static = DS:Static(10, 5) -- Starting shake the camera

local track = workspace.Rig.Humanoid:LoadAnimation(workspace.Rig.Animation) -- Loading the animation
track.Looped = false -- Setting looped to false
track:Play() -- Playing the animation

track.Ended:Wait() -- Waiting until animation will end
Follow:DisconnectFollow(Enum.CameraType.Scriptable) -- Stopping following a part
Cutscene:Pose(workspace.CutsceneParts.Part.CFrame, 75) -- Fix camera to the part
Cutscene:Move(workspace.CutsceneParts.Part2.CFrame, TweenInfo.new(2), 80) -- Tweening
task.wait(1) -- Waiting for 1 second
Cutscene:FadeIn(Color3.fromRGB(0, 0, 0), 1)
task.wait(0.98)
Cutscene:FadeOut(Color3.fromRGB(0, 0, 30), 1)
Cutscene:Stop(Enum.CameraType.Custom, 70) -- Stopping the cutscene
DS:Disconnect(static) -- Stops the shake
task.wait(3)
script:Destroy() -- Destroying the script because it becomes unnecessary