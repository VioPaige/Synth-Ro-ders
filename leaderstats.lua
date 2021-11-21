-- Services
local Players = game:GetService("Players")
local rStorage = game:GetService("ReplicatedStorage")



-- Instances
	-- Folders
local remotesFolder = rStorage:WaitForChild("Remotes")
	-- Other
local addPointsRemote = remotesFolder:WaitForChild("Addpoints")
local serverPrintRemote = remotesFolder:WaitForChild("serverPrint")






-- Functions
function initPlr(plr)

	local ls = Instance.new("Folder")
	ls.Name = 'leaderstats'
	ls.Parent = plr

	local points = Instance.new("IntValue")
	points.Name = 'points'
	points.Value = 0
	points.Parent = ls
	
	local streak = Instance.new("IntValue")
	streak.Name = 'streak'
	streak.Value = 0
	streak.Parent = ls

end



function addPoints(plr, amount)
	
	print("Adding " .. amount .. " points to " .. plr.Name)
	
	plr.leaderstats.points.Value +=amount
	
end


function serverPrint(plr, message)
	
	print("(" .. plr.Name .. ") - " .. message)
	
end






-- Events
Players.PlayerAdded:Connect(initPlr)

addPointsRemote.OnServerEvent:Connect(addPoints)
serverPrintRemote.OnServerEvent:Connect(serverPrint)
