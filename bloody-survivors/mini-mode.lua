local mod = BloodySurvivors

mod:AddCallback(
    ModCallbacks.MC_POST_GAME_STARTED,
    ---@param isContinue boolean
    function(_, isContinue)
        for i = 1, Game():GetNumPlayers() do
            local player = Isaac.GetPlayer(i - 1)

            player:AddCacheFlags(CacheFlag.CACHE_ALL, true)
        end
    end
)

mod:AddCallback(
    ModCallbacks.MC_POST_UPDATE,
    function(_)
        local camera = Game():GetRoom():GetCamera()
        camera:SnapToPosition(Isaac.GetPlayer(0).Position)
    end
)

mod:AddCallback(
    ModCallbacks.MC_EVALUATE_CACHE,
    ---@param player EntityPlayer
    ---@param cacheFlag CacheFlag
    function(_, player, cacheFlag)
        if cacheFlag == CacheFlag.CACHE_SIZE then
            player.Size = player.Size / 2
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

mod:AddCallback(
    ModCallbacks.MC_POST_KNIFE_UPDATE,
    ---@param knife EntityKnife
    function(_, knife)
        if knife.FrameCount == 0 then
            knife.Size = knife.Size * 0.75
            knife.SpriteScale = knife.SpriteScale * 0.75
        end
    end
)
