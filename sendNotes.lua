-- Services
local rStorage = game:GetService("ReplicatedStorage")
local tService = game:GetService("TweenService")


-- Instances
	-- Folders
local remoteFolder = rStorage:WaitForChild("Remotes")
local noteFolder = rStorage:WaitForChild("Notes")

local workspaceNotes = workspace:WaitForChild("Notes")
	-- Other
local sendNoteRemote = remoteFolder:WaitForChild("sendNote")

local notepref = noteFolder:WaitForChild("Note")
local noteEmitter = workspace:WaitForChild("NoteEmitter")







-- Functions
function track(plr, plrcframe)
	
	--print(plrcframe)

	for i = 1, 20 do
		local handpicked = math.random(1, 2)
		local hand = nil
		local notecolour = nil
		
		if handpicked == 1 then 
			hand = "LeftHand" 
			notecolour = Color3.fromRGB(255, 0, 191)
		else 
			hand = "RightHand" 
			notecolour = Color3.fromRGB(27, 113, 255)
		end
		
		sendnote(plr, plrcframe, hand, notecolour)
		wait(1.2)
	end


end



function sendnote(plr, plrcframe, hand, colour)

	local note = notepref:Clone()	
	note.Name = hand
	note.Color = colour
	note.Player.Value = plr.Name

	local variation = { -- 0-1 times increment *10 for 1 decimal, rounded, divided by 10 for 1 decimal, minus offset
		--x = math.round(math.random() * 70) / 10 - 3.5,
		--y = math.round(math.random() * 40) / 10 - 2.5
	}
	if hand == "LeftHand" then
		variation.x = math.round(math.random() * 40) / 10 - 3
		variation.y = math.round(math.random() * 40) / 10 - 2.5
	elseif hand == "RightHand" then
		variation.x = math.round(math.random() * 40) / 10 - 1
		variation.y = math.round(math.random() * 40) / 10 - 2.5
	end
	

	
	local newpos = noteEmitter.Position + Vector3.new(variation.x, variation.y, 0)
	note.Position = newpos
	
	local dest = Vector3.new(newpos.X, newpos.Y, 42)
	
	note.Parent = workspaceNotes

	local tInfo = TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)

	local tween = tService:Create(note, tInfo, {Position = dest})

	tween:Play()
	
	tween.Completed:Connect(function()
		
		print("completed note tween")
		--note:Destroy()		
		
	end)
	

end















-- Events
sendNoteRemote.OnServerEvent:Connect(track)



