--Functions
local function getMyTeam()
    if game.Players.LocalPlayer.PlayerGui.Leaderboard.Main.Phantoms.DataFrame.Data:FindFirstChild(tostring( game.Players.LocalPlayer.Name)) then
        myTeam = "Phantoms"
    end
    if game.Players.LocalPlayer.PlayerGui.Leaderboard.Main.Ghosts.DataFrame.Data:FindFirstChild(tostring( game.Players.LocalPlayer.Name)) then
        myTeam = "Ghosts"
    end
    --print(myTeam)
end

local function getCharacters()
    table.clear(playerChars)
    for _,teams in pairs(workspace.Players:GetChildren()) do
        for _,character in pairs(teams:GetChildren()) do
            local playerTeam = nil
            if character.Parent.Name == "Bright blue" then
                playerTeam = "Phantoms"
            end
            if character.Parent.Name == "Bright orange" then
                playerTeam = "Ghosts"
            end
            if playerTeam ~= myTeam then
                table.insert(playerChars, character)
            end
        end
    end
end

local function checkIfVisable(character)
    local rayDir = (character.Head.Position - workspace.CurrentCamera.CFrame.Position).Unit -- aims above player when at range, something with the angles are wrong
    local raycastResult = workspace:Raycast(workspace.CurrentCamera.CFrame.Position, rayDir*1000)
    if raycastResult then
        local hitPart = raycastResult.Instance
        if hitPart.Parent == character then
            return true
        else
           return false 
        end
    end
end

local function getClosestPlayer()
    ClosestChar = nil
    closestDist = 100000000
    if game.Players.LocalPlayer.Character then
        for _,character in pairs(playerChars) do
            local distance = (character.Head.Position - game.Players.LocalPlayer.Character.Head.Position).Magnitude
            
            if closestDist > distance and checkIfVisable(character) and MaxDistance > distance then
                
                --print(myTeam)
                closestDist = distance 
                ClosestChar = character
            end
        end
    end
    if ClosestChar then
       if ClosestChar:FindFirstChild("Head") then
            dirBetweenChars = (ClosestChar.Head.Position - game.Players.LocalPlayer.Character.Head.Position).Unit
            DirectionToCloseChar.Text = tostring(dirBetweenChars)
        end 
    end
    
end
-------------------------------
