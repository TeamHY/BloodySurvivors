---@class MonsterGenerator
local MonsterGenerator = {}

local mod = BloodySurvivors
mod.MonsterGenerator = MonsterGenerator

---@class MonsterData
---@field public type EntityType
---@field public variant integer
---@field public subtype integer
local MonsterData = {}


---@class MonsterGeneratorOptions
---@field public rng RNG
---@field public duration number
---@field public interval number
---@field public chance number
---@field public monster MonsterData

---@param options MonsterGeneratorOptions
---@return MonsterGenerator
function MonsterGenerator:New(options)
    local instance = setmetatable({}, self)
    self.__index = self

    self.rng = options.rng
    self.duration = options.duration
    self.interval = options.interval
    self.chance = options.chance
    self.monster = options.monster
    self.lastSpawnFrame = 0

    return instance
end

function MonsterGenerator:TrySpawn()
    if self.rng:RandomFloat() >= self.chance then
        return
    end

    Isaac.Spawn(
end

function MonsterGenerator:Update()
    local frameCount = mod.G:GetFrameCount()

    if frameCount > self.lastSpawnFrame then
        self:TrySpawn()
        self.lastSpawnFrame = frameCount + self.interval
    end
end
