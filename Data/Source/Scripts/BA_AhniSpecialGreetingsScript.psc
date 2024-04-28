Scriptname BA_AhniSpecialGreetingsScript extends Quest  

GlobalVariable Property GameDaysPassed  auto
GlobalVariable Property BA_CooldownToSet_AhniGreeting_Dragonborn  Auto  
GlobalVariable Property BA_CooldownToSet_AhniGreeting_Faction  Auto  
GlobalVariable Property BA_CooldownToSet_AhniGreeting_Follower  Auto  
GlobalVariable Property BA_CooldownToSet_AhniGreeting_Lover  Auto  
GlobalVariable Property BA_CooldownToSet_AhniGreeting_Vampire  Auto  

function DragonbornGreetingsCooldown()
    ;(GetOwningQuest() as BA_AhniSpecialGreetingsScript).DragonbornGreetingsCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 1
    BA_CooldownToSet_AhniGreeting_Dragonborn.setvalue(setcooldown)
endfunction

function FactionGreetingsCooldown()
    ;(GetOwningQuest() as BA_AhniSpecialGreetingsScript).FactionGreetingsCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 1
    BA_CooldownToSet_AhniGreeting_Faction.setvalue(setcooldown)
endfunction

function FollowerGreetingsCooldown()
    ;(GetOwningQuest() as BA_AhniSpecialGreetingsScript).FollowerGreetingsCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 0.0834
    BA_CooldownToSet_AhniGreeting_Follower.setvalue(setcooldown)
endfunction

function LoverGreetingsCooldown()
    ;(GetOwningQuest() as BA_AhniSpecialGreetingsScript).LoverGreetingsCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 0.0834
    BA_CooldownToSet_AhniGreeting_Lover.setvalue(setcooldown)
endfunction

function VampireGreetingsCooldown()
    ;(GetOwningQuest() as BA_AhniSpecialGreetingsScript).VampireGreetingsCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 0.5
    BA_CooldownToSet_AhniGreeting_Vampire.setvalue(setcooldown)
endfunction