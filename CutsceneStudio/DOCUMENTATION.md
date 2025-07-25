# DOCUMENTATION.md
This is the documentation for *CutsceneStudio* v1.7 from 2025

## ABOUT

#### WHAT'S CUTSCENESTUDIO?
CutsceneStudio is a module for cutscenes
without using any plugins.
It contains only 6 methods and 3 packets
It works only on **client-side**, 
so you can place LocalScript into StarterGui and it will play a cutscene when you join or respawn.

#### WHY I NEED TRY THIS?
You can try this because it's very simple for beginners,
it's kinda powerful,
and for creating a cutscene with using CutsceneStudio takes around 10 minutes

#### PROBLEMS?
CutsceneStudio isn't perfect,
it has only 6 methods and 3 packets,
it works only on client-side,
and some methods may not optimized for very weak devices

***************************************************

## DISCLAIMER
CutsceneStudio isn't suitable for people who don't have any scripting knowledge,
and without reading the documentation CutsceneStudio becomes hard to use
***You have been warned!!!***

***************************************************
 
## INSTALLATION
To install and start using it, follow these steps:
1. Unzip the folder with **CutsceneStudio**
2. Open Roblox Studio
3. Open a random place you have
4. Find and open the MODEL tab
5. Find and click MODEL
6. Export CutsceneStudio
7. Place CutsceneStudio to ReplicatedStorage
8. Create a LocalScript in StarterGui
9. In a new script type:
```lua
task.wait()
local CutsceneStudio = require(game:GetService("ReplicatedStorage").CutsceneStudio) -- loads CutsceneStudio into your script
local Cutscene = CutsceneStudio.Cutscene()
```
10. Continue reading!

***************************************************

## METHODS
Those are all methods for your cutscene

*** All arguments with question mark are optional ***

#### CUTSCENE:FADEIN()
This method fades in camera's brightness and also sets camera's color, usable for scene transiction
**Arguments**:
	TintColor: Color3? -- Sets camera's color, example: Color3.fromRGB(100, 100, 100)
	Time: number? -- How long will camera fade in
**Returns**: nil(boolean)

#### CUTSCENE:FADEOUT()
This method fades out camera's brightness and also sets camera's color, usable for scene transictions
**Arguments**:
	TintColor: Color3? -- Sets camera's color
	Time: number? -- How long will camera fade out
**Returns**: nil(boolean)

#### CUTSCENE:POSE()
This method attaches the camera to part's position and sets field of view
**Arguments**:
	Part: CFrame -- CFrame on which camera will attach
	FieldOfView: number? -- FieldOfView
**Returns**: nil(boolean)

#### CUTSCENE:MOVE()
This method smooth moves camera to an another part, uses TweenService
**Arguments**:
	Part: CFrame -- CFrame on which camera will move
	TweenInformation: TweenInfo? -- Information for tween, EXAMPLE: TweenInfo.new(1, Enum.EasingStyle.Linear)
	FieldOfView: number? -- FieldOfView
**Returns**: tween(Tween)

#### CUTSCENE:STOP()
This method brings back your camera to a normal position
**Arguments**:
	CameraType: Enum.CameraType? -- CameraType, EXAMPLE: Enum.CameraType.Custom
	FieldOfView: number? -- FieldOfView
**Returns**: nil(boolean)

#### CUTSCENE:DIALOGUE()
This method makes a custom gui pop up with text,
but on very weak devices it may not be optimized
**Arguments**:
	GUI: ScreenGui? -- Your CUSTOM gui
	Text: string? -- Finds the first descendant and text appears in it
    SlowPrintDelayTime: number? -- Slow writing
	Time: number? -- time after that text will disappear
	Sound: Sound? -- Sound that will playback when letter appears
	SoundParent: any? -- Sound's parent
**Returns**: clone(ScreenGui)

#### EXAMPLE
```lua
task.wait() -- A script may load faster than the module
local CutsceneStudio = require(game:GetService('ReplicatedStorage').CutsceneStudio) -- Importing a module
local Cutscene = CutsceneStudio.Cutscene() -- Creating a new cutscene
local Folder = workspace:WaitForChild('CutsceneParts', math.huge)

Cutscene:Pose(Folder.Part.CFrame, 75) -- Fixing the part
Cutscene:Move(
	Folder.Part2.CFrame, 
	TweenInfo.new(
		2, 
		Enum.EasingStyle.Sine, 
		Enum.EasingDirection.InOut
	), 
	70
) -- Tween
task.wait(1) -- Waiting for 1 second
Cutscene:FadeIn(Color3.fromRGB(0, 0, 0), 1) -- Fading In
task.wait(0.98)
Cutscene:FadeOut(Color3.fromRGB(0, 0, 0), 1) -- Fading Out
Cutscene:Pose(Folder.Part3.CFrame) -- The second argument is optional
task.wait(2)
-- I'll play an animation here for a rig
local Animation = workspace.Rig.Humanoid:LoadAnimation(workspace.Rig.Animation)
Animation.Looped = false -- It may be looped
Animation:Play()
-- Now i'll make a little dialogue
Cutscene:Dialogue(
	game:GetService('ReplicatedStorage').DialogueGui,
	"Welcome to the shop!",
	0.05,
	3,
    game:GetService('SoundService').Talk
)
task.wait(3)
script.Parent.Shop.Enabled = true
script.Parent.Shop.TextButton.MouseButton1Click:Connect(function() -- Connects a function
	script.Parent.Shop.Enabled = false
	Cutscene:Stop(Enum.CameraType.Custom, 70) -- Stops the cutscene
end)                                                                
```
**************************************************

## PACKETS
Packets - are methods related on the same topic
That's gonna be a little harder for you, *ready*? **Go!**
	
*** Arguments with question mark are optional ***
	
#### FOLLOW
Follow - is a packet for part following, usable for first person cutscenes
**Arguments**:
	Part: BasePart -- The part which camera will follow
**Returns**: Follow({})


##### FOLLOW:FOLLOW()
This method starts make camera follow a part, uses RunService
**Arguments**:
	Offset: Vector3? -- The offset for camera
	AnglesOffset: CFrame? -- The rotation offset for camera
**Returns**: nil(boolean)

##### FOLLOW:DISCONNECTFOLLOW()
This method stops following a part
**Arguments**:
	CameraType: Enum.CameraType? -- The type of camera
**Returns**: nil(boolean)

##### EXAMPLE
 ```lua
task.wait(2) -- Scripts are loading fast, but models aren't
local CutsceneStudio = require(game:GetService("ReplicatedStorage").CutsceneStudio)
local Cutscene = CutsceneStudio.Cutscene()
local Follow = Cutscene:Follow(workspace.Rig.Head) -- Importing Follow packet
Follow:Follow(Vector3.new(0, 0, -0.1), CFrame.Angles(0, 0, 0))
task.wait(5)
Follow:DisconnectFollow(Enum.CameraType.Custom)
```


#### DYNAMICSHAKE
DynamicShake - is a packet for shakes - static, intense and increasing
**Returns**: Shake({})

##### DYNAMICSHAKE:STATIC()
This method makes camera shake clockwise or anti-clockwise,
Uses **math.sin(), math.cos(), time() and CFrame.fromEulerAnglesXYZ()**
**Arguments**:
	Speed: number? -- Speed of a shake
	Strength: number? -- Strength for a shake
	Xdisabled: boolean? -- Is X movement disabled
	Ydisabled: boolean? -- Is Y movement disabled
	Zdisabled: boolean? -- Is Z movement disabled
**Returns**: code(string)

##### DYNAMICSHAKE:DISCONNECT()
All shakes returns its "Code",
And this method stops shake
**Arguments**:
	code: string
**Returns**: nil(boolean)

##### DYNAMICSHAKE:INTENSE()
This method makes explosive shaking, from intense to nothing,
Also uses **math.sin(), math.cos(), time() and CFrame.fromEulerAnglesXYZ()**
**Arguments**:
	Power: number? -- Starter strength for the shake
	Amplitude: number? -- Speed of a shake
	EndSpeed: number? -- How long explosion duration is(NOT IN SECONDS), from 1(very long) to 100(very short)
	Xdisabled: boolean? -- Is X movement disabled
	Ydisabled: boolean? -- Is Y movement disabled
	Zdisabled: boolean? -- Is Z movement disabled
**Returns**: code(string)

##### DYNAMICSHAKE:STARTINTENSE()
This method increases shake, from nothing to intense
**Arguments**:
	Speed: number? -- Increasing speed
	While: number? -- Shake will increase until it reaches...
	Amplitude: number? -- Shake speed
	Xdisabled: boolean? -- Is X movement disabled
	Ydisabled: boolean? -- Is Y movement disabled
	Zdisabled: boolean? -- Is Z movement disabled
**Returns**: code(string)
	
###### EXAMPLE
```lua
task.wait(2) -- Scripts are loading fast, but models aren't
local CutsceneStudio = require(game:GetService("ReplicatedStorage").CutsceneStudio)
local Cutscene = CutsceneStudio.Cutscene()
local Follow = Cutscene:Follow(workspace.Rig.Head) -- Importing Follow packet
local DynamicShake = Cutscene:DynamicShake()

local static = DynamicShake:Static(5, 3) -- All arguments here are optional
Follow:Follow(Vector3.new(0, 0, -0.1), CFrame.Angles(0, 0, 0))
task.wait(9)
Follow:DisconnectFollow(Enum.CameraType.Custom)
DynamicShake:Disconnect(static) -- No arguments here
```

***************************************************************

## ERRORS AND WARNINGS

I won't list all errors in Luau, i'll tell only custom errors.
If something doesn't work then check the Output, appear the Output in VIEW > console with the arrow image. 
Click this picture and you'll get a console!
	
**Problem #1 and/or #2**: in Cutscene:FadeIn() or Cutscene:FadeOut() method instead of Color3.fromRGB() you maybe did type something else
*How to fix*: Change the first argument in Cutscene:FadeIn()/Cutscene:FadeOut() to Color3
e.g: Cutscene:FadeOut(Color3.fromRGB(0, 0, 0), 2) 
	
**Problem #3 and/or #4**: you didn't type #1 argument or you did type wrong data type in Cutscene:Pose() or in Cutscene:Move() method
*How to fix*: Just type part's CFrame or CFrame
e.g: Cutscene:Pose(workspace.Part001.CFrame, 60)
    Cutscene:Move(CFrame.new(5.5, 0.025, 20), TweenInfo.new(1), 75)
	
**Problem #7**: When Follow:Follow() did work, a part did destroy or it even wasn't exist
*How to fix*: Just type an existing part for Cutscene:Follow()
	
**Problem #8**: You didn't make a GUI in Cutscene:Dialogue(), Dialogue system hasn't default GUI
*How to fix*: Create a GUI and type it in #1 argument in Cutscene:Dialogue() method
	
**Problem #9**: In GUI you didn't create a TextLabel that should call "MainDialogue".
*How to fix*: place a label(there will the speech be) in your GUI and call it "MainDialogue"
	
**Problem without a number**: I don't know why this error appears. Read an error and try fix it by yourself
	
#### WRONG EXAMPLE
```lua
local CutsceneStudio = require(game:GetService('ReplicatedStorage').CutsceneStudio)
local Cutscene = CutsceneStudio.Cutscene("i didn't check hints, are they right?")
Cutscene:FadeOut('make it black', 'make it 2')
Cutscene:Pose('yea, theY right')
Cutscene:DynamicShake('static shake for 5 seconds.')
wait(2)
Cutscene:Stop('BRING MY CAMERA BACK ELSE I FqRT AND EVERYWHERE WILL BE GREEN SMOKE!!!!!')
```
#### RIGHT EXAMPLE
```lua
local CutsceneStudio = require(game:GetService('ReplicatedStorage').CutsceneStudio)
local Cutscene = CutsceneStudio.Cutscene()
Cutscene:FadeOut(Color3.fromRGB(0, 0, 0), 2)
Cutscene:Pose(workspace.PartFocus.CFrame)
local DynamicShake = Cutscene:DynamicShake()
local static = DynamicShake:Static()
task.wait(2)
Cutscene:Stop()
DynamicShake:Disconnect(static)
```

****************************************************************

Congratulations!!!!!!! You can use **CutsceneStudio** right NOW!!!
