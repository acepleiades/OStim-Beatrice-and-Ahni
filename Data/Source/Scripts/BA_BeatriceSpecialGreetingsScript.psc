Scriptname BA_BeatriceSpecialGreetingsScript extends Quest  

GlobalVariable Property GameDaysPassed  auto
GlobalVariable Property BA_CooldownToSet_BeatriceGreeting_Dragonborn  Auto  
GlobalVariable Property BA_CooldownToSet_BeatriceGreeting_Faction  Auto  
GlobalVariable Property BA_CooldownToSet_BeatriceGreeting_Follower  Auto  
GlobalVariable Property BA_CooldownToSet_BeatriceGreeting_Lover  Auto  
GlobalVariable Property BA_CooldownToSet_BeatriceGreeting_Vampire  Auto  

function DragonbornGreetingsCooldown()
    ;(GetOwningQuest() as BA_BeatriceSpecialGreetingsScript).DragonbornGreetingsCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 1
    BA_CooldownToSet_BeatriceGreeting_Dragonborn.setvalue(setcooldown)
endfunction

function FactionGreetingsCooldown()
    ;(GetOwningQuest() as BA_BeatriceSpecialGreetingsScript).FactionGreetingsCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 1
    BA_CooldownToSet_BeatriceGreeting_Faction.setvalue(setcooldown)
endfunction

function FollowerGreetingsCooldown()
    ;(GetOwningQuest() as BA_BeatriceSpecialGreetingsScript).FollowerGreetingsCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 0.0834
    BA_CooldownToSet_BeatriceGreeting_Follower.setvalue(setcooldown)
endfunction

function LoverGreetingsCooldown()
    ;(GetOwningQuest() as BA_BeatriceSpecialGreetingsScript).LoverGreetingsCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 0.0834
    BA_CooldownToSet_BeatriceGreeting_Lover.setvalue(setcooldown)
endfunction

function VampireGreetingsCooldown()
    ;(GetOwningQuest() as BA_BeatriceSpecialGreetingsScript).VampireGreetingsCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 0.5
    BA_CooldownToSet_BeatriceGreeting_Vampire.setvalue(setcooldown)
endfunction