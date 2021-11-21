-- Services
local rStorage = game:GetService("ReplicatedStorage")

wait(.01)
-- Instances
	-- Folders
local remotesFolder = rStorage:WaitForChild("Remotes")
	-- Other
local addPointsRemote = remotesFolder:WaitForChild("Addpoints")
local addStreakRemote = remotesFolder:WaitForChild("Addstreak")

local summoningplayer = game.Players[script.Parent.Player.Value]
local touched = false


-- Functions
function addPoints(plr, amount)

	print("Adding " .. amount .. " points to " .. plr.Name)
	
	touched = true
	plr.leaderstats.points.Value +=amount
	plr.leaderstats.streak.Value +=1
	addPointsRemote:FireClient(plr, plr.leaderstats.points.Value)
	addStreakRemote:FireClient(plr, plr.leaderstats.streak.Value)
	script.Parent:Destroy()

end


function touched(otherpart)

	--print("Note has been touched (wow pedophile)")
	print("Touched by " .. otherpart.Name)
	print("and is " .. script.Parent.Name)

	if otherpart.Parent:FindFirstChild("Humanoid") and otherpart.Name == script.Parent.Name and otherpart.Parent.Name == summoningplayer.Name then

		noteDown(otherpart, script.Parent.Position, otherpart.Position)
		
	elseif otherpart == workspace.NoteDestructor then
		
		summoningplayer.leaderstats.points.Value = 0
		addStreakRemote:FireClient(summoningplayer, 0)
		
		script.Parent:Destroy()
		
	end

end




function noteDown(otherpart, notepos, otherpartpos)

	print("noteDown function entered")

	local mag = (notepos - otherpartpos).Magnitude
	
	print(mag)
	
	if mag < 4.2 then
		
		addPoints(game.Players[otherpart.Parent.Name], 1000)
		
	elseif mag < 5 then

		addPoints(game.Players[otherpart.Parent.Name], 500)
		
	elseif mag < 7 then
		
		addPoints(game.Players[otherpart.Parent.Name], 100)
	
	end

end



-- Events
script.Parent.Touched:Connect(touched)
--script.Parent.Destroying:Connect(onDestruction)

