BloodySurvivors = RegisterMod("Survivors", 1)

BloodySurvivors.G = Game()

-- require "bloody-survivors.mini-mode"

local mod = BloodySurvivors

mod:AddCallback(
    ModCallbacks.MC_POST_GAME_STARTED,
    ---@param isContinue boolean
    function(_, isContinue)
        if mod.G.Difficulty == Difficulty.DIFFICULTY_GREEDIER then
            Isaac.ExecuteCommand("stage 7")
            Isaac.ExecuteCommand("goto x.default.1")
        end
    end
)

mod:AddCallback(
    ModCallbacks.MC_POST_NEW_ROOM,
    function(_)
        local room = Game():GetRoom()

        room:SetClear(true)
        room:RemoveDoor(DoorSlot.DOWN0)
        room:RemoveDoor(DoorSlot.DOWN1)
        room:RemoveDoor(DoorSlot.LEFT0)
        room:RemoveDoor(DoorSlot.LEFT1)
        room:RemoveDoor(DoorSlot.RIGHT0)
        room:RemoveDoor(DoorSlot.RIGHT1)
        room:RemoveDoor(DoorSlot.UP0)
        room:RemoveDoor(DoorSlot.UP1)
        room:SetClear (true);
    end
)

mod:AddCallback(
    ModCallbacks.MC_POST_UPDATE,
    function(_)
        if mod.G:GetFrameCount() % 30 == 0 then
            local player = Isaac.GetPlayer()
            local position = player.Position + Vector(160 + (math.random() - 0.5) * 2 * 80, 0):Rotated(math.random() * 360)

            if math.random() < 0.8 then
                Isaac.Spawn(EntityType.ENTITY_FLY, 1, 0, position, Vector(0, 0), nil)
            else
                Isaac.Spawn(EntityType.ENTITY_ATTACKFLY, 1, 0, position, Vector(0, 0), nil)
            end
        end
    end
)
