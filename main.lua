local mod = RegisterMod("Survivors", 1)
local g = Game()

mod:AddCallback(
    ModCallbacks.MC_POST_GAME_STARTED,
    ---@param isContinue boolean
    function(_, isContinue)
        if g.Difficulty == Difficulty.DIFFICULTY_GREEDIER then
            Isaac.ExecuteCommand("stage 7")
            Isaac.ExecuteCommand("goto x.default.1")

            for i = 1, Game():GetNumPlayers() do
                local player = Isaac.GetPlayer(i - 1)

                player:AddCacheFlags(CacheFlag.CACHE_ALL, true)
            end
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
        if g:GetFrameCount() % 30 == 0 then
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

mod:AddCallback(
    ModCallbacks.MC_EVALUATE_CACHE,
    ---@param player EntityPlayer
    ---@param cacheFlag CacheFlag
    function(_, player, cacheFlag)
        if cacheFlag == CacheFlag.CACHE_SIZE then
            -- player.Size = player.Size / 2
            player.SpriteScale = player.SpriteScale / 2
        elseif cacheFlag == CacheFlag.CACHE_RANGE then
            player.TearHeight = player.TearHeight / 2
        elseif cacheFlag == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed / 2
        end
    end
)

mod:AddCallback(
    ModCallbacks.MC_POST_NPC_INIT,
    ---@param npc EntityNPC
    function(_, npc)
        npc.Size = npc.Size / 2
        npc.Scale = npc.Scale / 2
    end
)

mod:AddCallback(
    ModCallbacks.MC_POST_NPC_DEATH,
    ---@param npc EntityNPC
    function(_, npc)
        local position = npc.Position

        local coin = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 1, position, Vector(0, 0), nil)
        coin.SpriteScale = coin.SpriteScale / 2
    end
)

mod:AddCallback(
    ModCallbacks.MC_POST_TEAR_UPDATE,
    ---@param tear EntityTear
    function(_, tear)
        if tear.FrameCount == 0 then
            tear.Size = tear.Size / 2
            tear.Scale = tear.Scale / 2
            tear.Velocity = tear.Velocity / 2
            tear.Height = tear.Height / 2
        end
    end
)

mod:AddCallback(
    ModCallbacks.MC_POST_PROJECTILE_UPDATE,
    ---@param projectile EntityProjectile
    function(_, projectile)
        if projectile.FrameCount == 1 then
            projectile.Size = projectile.Size / 2
            projectile.Scale = projectile.Scale / 2
            projectile.Velocity = projectile.Velocity / 2
            projectile.Height = projectile.Height / 2
        end
    end
)
