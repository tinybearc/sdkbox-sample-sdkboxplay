
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
    print("Sample Startup")

    local logo = cc.Sprite:create("Logo.png")
    local logoSize = logo:getContentSize()
    logo:setPosition(cc.p(logoSize.width / 2, display.top - logoSize.height / 2))
    self:addChild(logo)

    local label = cc.Label:createWithSystemFont("QUIT", "sans", 32)
    local quit = cc.MenuItemLabel:create(label)
    quit:onClicked(function()
        os.exit(0)
    end)
    local size = label:getContentSize()
    local menu = cc.Menu:create(quit)
    menu:setPosition(display.right - size.width / 2 - 16, display.bottom + size.height / 2 + 16)
    self:addChild(menu)

    self:setupTestMenu()
end

function MainScene:setupTestMenu()

    local info = cc.Label:createWithSystemFont("Not connected yet.", "sans", 32)
    info:setPosition(display.cx, 80)
    self:addChild(info);

    sdkbox.PluginSdkboxPlay:setListener(function(args)
        dump(args, 'listener trigger:')

        if 'onConnectionStatusChanged' == args.name then
            if 1000 == args.status then
                info:setString( "Status: " ..
                                args.status ..
                                " " ..
                                sdkbox.PluginSdkboxPlay:getPlayerId() ..
                                " " ..
                                sdkbox.PluginSdkboxPlay:getPlayerAccountField("name") ..
                                "(" ..
                                sdkbox.PluginSdkboxPlay:getPlayerAccountField("display_name") ..
                                ")" );
            else
                info:setString( "Not connected. Status: " .. args.status );
            end
        elseif 'onScoreSubmitted' == args.name then
            -- do something
        elseif 'onMyScore' == args.name then
            -- do something
        elseif 'onMyScoreError' == args.name then
            -- do something
        elseif 'onPlayerCenteredScores' == args.name then
            -- do something
        elseif 'onPlayerCenteredScoresError' == args.name then
            -- do something
        elseif 'onIncrementalAchievementUnlocked' == args.name then
            -- do something
        elseif 'onIncrementalAchievementStep' == args.name then
            -- do something
        elseif 'onIncrementalAchievementStepError' == args.name then
            -- do something
        elseif 'onAchievementUnlocked' == args.name then
            -- do something
        elseif 'onAchievementUnlockError' == args.name then
            -- do something
        elseif 'onAchievementsLoaded' == args.name then
            -- do something
        elseif 'onSetSteps' == args.name then
            -- do something
        elseif 'onSetStepsError' == args.name then
            -- do something
        elseif 'onReveal' == args.name then
            -- do something
        elseif 'onRevealError' == args.name then
            -- do something
        end
    end)
    sdkbox.PluginSdkboxPlay:init()

    cc.MenuItemFont:setFontName("Arial")
    cc.Menu:create(
                   cc.MenuItemFont:create("Connect/Disconnect"):onClicked(function()
                        if ( sdkbox.PluginSdkboxPlay:isConnected() ) then
                            sdkbox.PluginSdkboxPlay:signout()
                        else
                            sdkbox.PluginSdkboxPlay:signin()
                        end
                    end),
                   cc.MenuItemFont:create("Show Leaderboard ldb1"):onClicked(function()
                        sdkbox.PluginSdkboxPlay:showLeaderboard("ldb1")
                    end),
                   cc.MenuItemFont:create("Achievements"):onClicked(function()
                        sdkbox.PluginSdkboxPlay:showAchievements()
                    end),
                   cc.MenuItemFont:create("Unlock Craftsmen"):onClicked(function()
                        sdkbox.PluginSdkboxPlay:unlockAchievement("craftsman")
                    end),
                   cc.MenuItemFont:create("Unlock Hunter"):onClicked(function()
                        sdkbox.PluginSdkboxPlay:unlockAchievement("hunter")
                    end),
                   cc.MenuItemFont:create("Unlock Ten Games"):onClicked(function()
                        sdkbox.PluginSdkboxPlay:unlockAchievement("ten-games")
                    end),
                   cc.MenuItemFont:create("Unlock Incremental"):onClicked(function()
                        sdkbox.PluginSdkboxPlay:incrementAchievement("incremental", 1)
                    end),
                   cc.MenuItemFont:create("Send Score 1000"):onClicked(function()
                        sdkbox.PluginSdkboxPlay:submitScore("ldb1", 1000)
                    end)
                   )
        :move(display.cx, display.cy)
        :addTo(self)
        :alignItemsVerticallyWithPadding(20)


    -- require('cocos.cocos2d.json')
end

return MainScene
