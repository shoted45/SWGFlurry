local ObjectManager = require("managers.object.object_manager")
-------------------------------------------------------
--Mission States
-------------------------------------------------------
missionScreenplay = ScreenPlay:new {

    numberOfActs = 1,

    questString = "missionquest",

    states = {

        accepted = 1,

        fightingenemy = 2,

        enemydead = 4,

        complete = 8,

    },

    questdata = Object:new {

     activePlayerName = "initial",

    }

}
-------------------------------------------------------
--Spawn Mission Giver
-------------------------------------------------------
registerScreenPlay("missionScreenplay", true)

function missionScreenplay:start()

  local pNpc = spawnMobile("corellia", "mission_solo",0,-169.45,28,-4712.58,134,0)

  self:setMoodString(pNpc, "neutral")

  self:spawnMobiles()

end
-------------------------------------------------------
--Spawn Mission Target
-------------------------------------------------------
function missionScreenplay:spawnMobiles(pMobile)

    if (pMobile == nil) then

        pMobile = spawnMobile("corellia", "meatlump_buffoon",20,-164,28,-4754,88,0)

        self:setMoodString(pMobile, "npc_accusing")

	createObserver(OBJECTDESTRUCTION, "missionScreenplay", "enemyKilled", pMobile)

        return 0

    end

end
-------------------------------------------------------
--Set Enemy Dead state
-------------------------------------------------------
function missionScreenplay:enemyKilled(pMobile, pPlayer)

    local player = LuaCreatureObject(pPlayer)

    local enemy = LuaCreatureObject(pMobile)

    player:setScreenPlayState(missionScreenplay.states.enemydead, "missionquest")
-------------------------------------------------------
--Conditions Of Whether The Mission Is Accepted Or Not
-------------------------------------------------------
    local thisState = player:getScreenPlayState(missionScreenplay.questString)

    if player:hasScreenPlayState(missionScreenplay.states.complete, "missionquest") then

    player:sendSystemMessage("*** You have already completed this mission. Impossible to do it again ***")

    elseif player:hasScreenPlayState(missionScreenplay.states.accepted, "missionquest") then
-------------------------------------------------------
--Mission Target Killed Active Waypoint Removed
-------------------------------------------------------
           player:sendSystemMessage("COMPLETED MISSION: Test.")
           local pGhost = CreatureObject(pPlayer):getPlayerObject()
           local playerID = CreatureObject(pPlayer):getObjectID()
           local oldWaypointID = tonumber(getQuestStatus(playerID .. ":caedusWaypointID"))
           PlayerObject(pGhost):removeWaypoint(oldWaypointID, true)
    else
-------------------------------------------------------
--Promt To Go Back To Mission Giver
-------------------------------------------------------
       player:sendSystemMessage("You've finished with Darth Caedus! talk with mission Solo.")
end
    return 1

end
------------------------------------------------------
--Get Active Player Name
-------------------------------------------------------
function missionScreenplay:getActivePlayerName()

    return self.questdata.activePlayerName

end

function missionScreenplay:setActivePlayerName(playerName)
-------------------------------------------------------
--Changing Playername
-------------------------------------------------------
    self.questdata.activePlayerName = playerName

end
function missionScreenplay:DefenderAdded(pMobile, pPlayer)

    local player = LuaCreatureObject(pPlayer)

    local pName = player:getName()
-------------------------------------------------------
--Defender Added Fired
-------------------------------------------------------
end
function missionScreenplay:DefenderDropped(pMobile, pPlayer)

        local player = LuaCreatureObject(pPlayer)

        local pName = player:getName()

        local enemy = LuaCreatureObject(pMobile)

        if ( enemy ~= nil ) then
-------------------------------------------------------
--Check To See If Enemy Is Dead
-------------------------------------------------------
            local enemyHealth = enemy:getHAM(0)

            local enemyAction = enemy:getHAM(3)

            local enemyMind = enemy:getHAM(6)

            if ( enemyHealth < 0 or enemyAction < 0 or enemyMind < 0 ) then
-------------------------------------------------------
--Enemy Is Dead
--Check To See If The Defender Was On The Quest And Was In A State Of Enemy Combat
-------------------------------------------------------
                local questState = player:getScreenPlayState(missionScreenplay.questString)

                if ( player:hasScreenPlayState(missionScreenplay.states.fightingenemy) ) then
-------------------------------------------------------
--Setting The Quest Status To Enemydead
-------------------------------------------------------
                    player:setScreenPlayState(missionScreenplay.states.enemydead, missionScreenplay.questString)

                end

            else

                if ( player:hasScreenPlayState(missionScreenplay.states.fightingenemy) ) then
-------------------------------------------------------
--Enemy Isn't Dead.  Remove Fightingenemy Playerstate
-------------------------------------------------------
                    player:removeScreenPlayState(missionScreenplay.states.fightingenemy, missionScreenplay.questString)
                end

            end
            
        end
-------------------------------------------------------
--Defender Dropped fired
-------------------------------------------------------
end
-------------------------------------------------------
--NPC Convo Handler
-------------------------------------------------------
--Quest Conversation Handlers
-------------------------------------------------------
mission_quest_convo_handler = conv_handler:new {}

function mission_quest_convo_handler:getNextConversationScreen(conversationTemplate, conversingPlayer, selectedOption)
-------------------------------------------------------
--GetNextConversation Called NPC
-------------------------------------------------------
    local creature = LuaCreatureObject(conversingPlayer)

    local convosession = creature:getConversationSession()

    local lastConversationScreen = nil
-------------------------------------------------------
--GetNextConversation Called NPC
-------------------------------------------------------
    local conversation = LuaConversationTemplate(conversationTemplate)

    local nextConversationScreen

    if ( conversation ~= nil ) then
-------------------------------------------------------
--Checking To See If We Have A Next Screen
-------------------------------------------------------
        if ( convosession ~= nil ) then

             local session = LuaConversationSession(convosession)

             if ( session ~= nil ) then

                 lastConversationScreen = session:getLastConversationScreen()

             end

        end

        if ( lastConversationScreen == nil ) then
-------------------------------------------------------
--Last Conversation Is Null.  Let's Try To Get The First Screen
-------------------------------------------------------
            local creature = LuaCreatureObject(conversingPlayer)

            if creature:hasScreenPlayState(missionScreenplay.states.complete, "missionquest") then
-------------------------------------------------------
--Complete
-------------------------------------------------------
                   nextConversationScreen = conversation:getScreen("completed")

            elseif creature:hasScreenPlayState(missionScreenplay.states.enemydead, "missionquest") then
-------------------------------------------------------
--Full Inventory To Receive The Reward
-------------------------------------------------------
--Collecting Player Data
-------------------------------------------------------
		local pInventory = creature:getSlottedObject("inventory")

            	local inventory = LuaSceneObject(pInventory)
-------------------------------------------------------
--Full Container
-------------------------------------------------------
            if (SceneObject(pInventory):isContainerFullRecursive() == true) then

                 nextConversationScreen = conversation:getScreen("no_space")

                 creature:sendSystemMessage("You do not have enough space in your inventory")

                else              
-------------------------------------------------------
--End The Mission And Reward
-------------------------------------------------------
                creature:setScreenPlayState(missionScreenplay.states.complete, "missionquest") --- NEWLY COMPLETED

                creature:playMusicMessage("sound/music_combat_bfield_vict.snd")

                nextConversationScreen = conversation:getScreen("thank_you")

                creature:sendSystemMessage("FINALIZED mission: Family revenge You have received 25,000 credits and a special tunic of Luminous Jedi.")

                creature:addCashCredits(25000, true)

                local pItem = giveItem(pInventory, "robe_jedi_light_hood_down.iff", -1) -- Tunica Shatterpoint Cloak Hood Down
                end
-------------------------------------------------------
--Not yet
-------------------------------------------------------
            elseif creature:hasScreenPlayState(missionScreenplay.states.fightingenemy, "missionquest") then
-------------------------------------------------------
--Fighting Enemy State
-------------------------------------------------------
                nextConversationScreen = conversation:getScreen("not_yet")

            elseif creature:hasScreenPlayState(missionScreenplay.states.accepted, "missionquest") then
-------------------------------------------------------
--why are you coming back? You have a mission pending
-------------------------------------------------------
                nextConversationScreen = conversation:getScreen("not_yet")

            else
-------------------------------------------------------
--Start if the quest was not obtained yet
-------------------------------------------------------
                nextConversationScreen = conversation:getScreen("start")

            end

        else

            local luaLastConversationScreen = LuaConversationScreen(lastConversationScreen)

            local optionLink = luaLastConversationScreen:getOptionLink(selectedOption)
-------------------------------------------------------
--OptionLink From The Last Screen Is OptionLink
-------------------------------------------------------
        nextConversationScreen = conversation:getScreen(optionLink)

        end

    end
-------------------------------------------------------
--Returning Screen
-------------------------------------------------------
    return nextConversationScreen

end

function mission_quest_convo_handler:runScreenHandlers(conversationTemplate, conversingPlayer, conversingNPC, selectedOption, conversationScreen)
local pGhost = CreatureObject(conversingPlayer):getPlayerObject()

    local screen = LuaConversationScreen(conversationScreen)
    local screenID = screen:getScreenID()
    local playerID = CreatureObject(conversingPlayer):getObjectID()
    local player = LuaCreatureObject(conversingPlayer)
-------------------------------------------------------
    if (screenID == "thank_you") then
-------------------------------------------------------
--Completed The Quest
--Settings State For Quest
-------------------------------------------------------
        player:setScreenPlayState( missionScreenplay.states.complete , missionScreenplay.questString)
-------------------------------------------------------
    elseif (screenID == "accept_quest") then
    
      local oldWaypointID = tonumber(getQuestStatus(playerID .. ":caedusWaypointID"))
      if (oldWaypointID ~= 0) then
      PlayerObject(pGhost):removeWaypoint(oldWaypointID, true)
      removeQuestStatus(playerID .. ":caedusWaypointID")
      end
      local waypointID = PlayerObject(pGhost):addWaypoint("corellia", "Target", "", -164, -4754, WAYPOINT_COLOR_PURPLE, true, true, 0)
      setQuestStatus(playerID .. ":caedusWaypointID", waypointID)
-------------------------------------------------------
--Accepting The Quest
--Settings State For Quest
-------------------------------------------------------
      player:setScreenPlayState( missionScreenplay.states.accepted , missionScreenplay.questString)
      player:sendSystemMessage("ACCEPTED mission: Family Revenge")
      player:playMusicMessage("sound/music_themequest_victory_imperial.snd")

    	elseif (screenID == "quest_status") then

        conversationScreen = screen:cloneScreen()

        local clonedConversation = LuaConversationScreen(conversationScreen)

        local thisState = player:getScreenPlayState(missionScreenplay.questString)

        if ( thisState ~= 0 ) then

            clonedConversation:setCustomDialogText("You are in the ".. thisState .." part of this mission")

        else

            clonedConversation:setCustomDialogText("You have not yet registered information on this mission")

        end

    elseif (screenID == "quest_reset")  then
-------------------------------------------------------
--Removing State For Quest
-------------------------------------------------------
        conversationScreen = screen:cloneScreen()

        local clonedConversation = LuaConversationScreen(conversationScreen)

        local thisState = player:getScreenPlayState(missionScreenplay.questString)

        if ( thisState ~= 0 ) then

      	clonedConversation:setCustomDialogText("Come back if you change your mind ...")
-------------------------------------------------------
--All Data Removed
-------------------------------------------------------
            player:removeScreenPlayState(missionScreenplay.states.accepted,     missionScreenplay.questString)

            player:removeScreenPlayState(missionScreenplay.states.fightingenemy, missionScreenplay.questString)

            player:removeScreenPlayState(missionScreenplay.states.enemydead,     missionScreenplay.questString)

            player:removeScreenPlayState(missionScreenplay.states.complete,     missionScreenplay.questString)

            player:removeScreenPlayState(missionScreenplay.questString)
-------------------------------------------------------
--Play Music
-------------------------------------------------------
        player:playMusicMessage("sound/music_player_v_player_death.snd")
-------------------------------------------------------
--Remove Active Waypoint If There s One
-------------------------------------------------------
        player:sendSystemMessage("FAILED mission: Family revenge")
        local oldWaypointID = tonumber(getQuestStatus(playerID .. ":caedusWaypointID"))
        PlayerObject(pGhost):removeWaypoint(oldWaypointID, true)
        else

        clonedConversation:setCustomDialogText("You have not started or finished this mission")

        end
-------------------------------------------------------
--Final Message
-------------------------------------------------------
    elseif (screenID == "completed") then

            conversationScreen = screen:cloneScreen()

            local clonedConversation = LuaConversationScreen(conversationScreen)

            if (clonedConversation ~= nil) then

                self:addQuestOptions(clonedConversation)

                clonedConversation:setCustomDialogText("I feel that you managed to defeat Darth Caedus! You came to my brother")

            end

    end

    return conversationScreen

end
-------------------------------------------------------
--Reset Quest
-------------------------------------------------------
  function mission_quest_convo_handler:addQuestOptions(convoScreen)

        convoScreen:addOption("STATUS", "quest_status")

        convoScreen:addOption("RESET QUEST", "quest_reset")

    end
