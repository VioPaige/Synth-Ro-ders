-- Services
local rStorage = game:GetService("ReplicatedStorage")


-- Instances
	-- Folders
local remotesFolder = rStorage:WaitForChild("Remotes")
	-- Other
local addPointsRemote = remotesFolder:WaitForChild("Addpoints")





-- Functions
function addPoints(plr, amount)

	print("Adding " .. amount .. " points to " .. plr.Name)

	plr.leaderstats.points.Value +=amount

end


function touched(otherpart)

	print("Note has been touched (wow pedophile)")

	if otherpart.Parent:FindFirstChild("Humanoid") and (otherpart.Name == "RightHand" or otherpart.Name == "LeftHand") then

		noteDown(otherpart, script.Parent.Position, otherpart.Position)

	end

end




function noteDown(otherpart, notepos, otherpartpos)

	print("noteDown function entered")

	local mag = (notepos - otherpartpos).Magnitude
	
	print(mag)

	if mag < 5 then

		addPoints(game.Players[otherpart.Parent.Name], 500)
		wait(.05)
		script.Parent:Destroy()

	end

end



-- Events
script.Parent.Touched:Connect(touched)
