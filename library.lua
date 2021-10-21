local game = game;
local workspace = workspace

local GetService = game.GetService

local RunService = GetService(game, "RunService")
local Players = GetService(game, "Players")
local HttpService = GetService(game, "HttpService")

local LocalPlayer = Players.LocalPlayer

local task = task
local wait = task.wait
local spawn = task.spawn

local BotLib = {}

BotLib.__index = BotLib;

function BotLib.new(Name)
    local self = {
        ['Name'] = Name;
    }
    
    return setmetatable(self, BotLib)
end;

function BotLib:Execute(Code)
    local response = syn.request({
        Url = "http://localhost:8080/executescript",  
        Method = "GET",  
        Headers = {
            ['botname'] = self.Name;
            ["script"] = Code
        }
    })
end

function BotLib:GetAllBots()
    local Response = syn.request({
        Url = "http://localhost:8080/getallbots",  
        Method = "GET",  
    })

    local Decoded = HttpService:JSONDecode(Response.Body)
    local NewTable = {}
    
    
    for Index, Bot in pairs(Decoded) do
        table.insert(NewTable, BotLib.new(Bot));
    end
    
    return NewTable
end

return BotLib;

