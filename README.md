### SuperWoW and SuperMacro helper

Depend on:

[SuperWoW](https://github.com/balakethelock/SuperWoW)  

### Example Beast Hunter solo one key macro
This example depend on:

[SuperMate](https://github.com/leenux/SuperMate)

[SuperMacro](https://github.com/Monteo/SuperMacro) 

[Quiver](https://github.com/SabineWren/Quiver) 

[Roid-Macros](https://github.com/DennisWG/Roid-Macros)

[MonkeySpeed](https://github.com/MarcelineVQ/MonkeySpeed)

[ShaguTweaks](https://github.com/shagu/ShaguTweaks)

```
/run c = CastSpellByName
/run u = UnitBuff
/run ud = UnitDebuff
/run tarh = UnitHealth("target")/UnitHealthMax("target");
/run m = UnitMana("player");
/run h = UnitHealth("target");
/run p = UnitHealth("player")/UnitHealthMax("player");
/run combat = UnitAffectingCombat("player");
/run petCombat = UnitAffectingCombat("pet");
/run cd = Roids.GetSpellCooldownByName;
/run moving = MonkeySpeed.m_fSpeed > 0
/run melee = CheckInteractDistance("target", 3) and not UnitIsDead("target");
/run tarType = UnitCreatureType("target")
/run function FreeShot(secs) local a, b = Quiver.GetSecondsRemainingShoot(); local m, n = Quiver.GetSecondsRemainingReload(); return (a and b < -0.25) or (m and n > secs) end
/run function hang() local a, b = Quiver.GetSecondsRemainingShoot(); return a and b < -0.25 end
/run function AutoAttack() for i=1,120 do if IsCurrentAction(i) then return end end c("Attack") end
/run function AutoShot() for i=1,120 do if IsAutoRepeatAction(i) then return end end c("Auto Shot") end
/run function HuntersMark() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Ability_Hunter_SniperShot" then x=1 end i=i+1 end if x==0 then c("Hunter's Mark")end end
/run function Serpent() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Ability_Hunter_Quickshot" then x=1 end i=i+1 end if x==0 then c("Serpent Sting")end end
/run function WingClip() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Ability_Rogue_Trip" then x=1 end i=i+1 end if x==0 then c("Wing Clip")end end
/run function HasQuickShot() local i,x=1,0 while u("player",i) do if u("player",i)=="Interface\\Icons\\Ability_Warrior_InnerRage" then x=1 end i=i+1 end if x==1 then return true end end
/run function ap() local base, posBuff, negBuff = UnitAttackPower("player");return base + posBuff + negBuff end
/run function casting(s) local spName, _, _, _, time1, time2, _ = ShaguTweaks.UnitCastingInfo("target");local ss = s or "";if spName and time2-time1>2500 and string.find(spName,ss) then return true; end end
/run local swinged = st_timer < 0.2
/run function hasCarve() local _,texture,_,_,rank,_,_,_=GetTalentInfo(3,9);if texture then return true; end end
/run function canTrap() local _,texture,_,_,rank,_,_,_=GetTalentInfo(3,19);if texture then return true; end end
/run function hasIntimidation() local _,texture,_,_,rank,_,_,_=GetTalentInfo(1,13);if texture then return true; end end
/run function hasBestial() local _,texture,_,_,rank,_,_,_=GetTalentInfo(1,17);if texture then return true; end end
/run function hasSteady() local _,texture,_,_,rank,_,_,_=GetTalentInfo(2,7);if texture then return true; end end

/run --casting depend on SuperWoW patch and this addons(SuperMate), FreeShot depond on Quiver, cd depond on Roid-Macros addons
/run --moving depend on MonkeySpeed
/run if UnitIsDead("target") then ClearTarget() end
/run if GetUnitName("target")==nil then TargetNearestEnemy() end
/run PetAttack()
/run if hang() then c("Attack") end
/run if melee then AutoAttack() else AutoShot() end

/run --Cast Intimidation if target casting name include Healing string and duration > 2.5s
/run if hasIntimidation() and cd("Intimidation") == 0 and casting("Healing") and petCombat then c("Intimidation") end
/run if not melee and casting("Healing") and FreeShot(0.5) and cd("Multi-Shot") == 0 and cd("Intimidation") ~= 0 then c("Multi-Shot") end

/run if not melee then HuntersMark() end
/run if not melee and tarType ~= "Elemental" and tarType ~= "Mechanical" then Serpent() end

/run --When solo, cast Bestial Wrath before target health > 80%
/run if hasBestial() and cd("Bestial Wrath") == 0 and petCombat and tarh>0.8 then c("Bestial Wrath") end

/run if melee and cd("Wing Clip") then WingClip() end
/run if melee and canTrap() and cd("Explosive Trap") then c("Explosive Trap") end
/run if melee and hasCarve() and cd("Carve") then c("Carve") end
/run if melee and cd("Mongoose Bite") then c("Mongoose Bite") end
/run if melee and swinged and cd("Raptor Strike") then c("Raptor Strike") end

/run --Detect auto shot hang and re-boot shot, when remaining time > 0.5s we can cast multi-shot
/run if not melee and FreeShot(0.5) and cd("Multi-Shot") == 0 then c("Multi-Shot") end
/run --Detect auto shot hang and re-boot shot, when remaining time > 1.2s we can cast Steady Shot
/run if not melee and hasSteady() and FreeShot(1.2) then c("Steady Shot") end

/run --Detect auto shot hang and re-boot shot, when remaining time > 1.5s and has Swift Aspects we can cast Aimed Shot
/run --if not melee and FreeShot(1.5) and HasQuickShot() and cd("Aimed Shot") == 0 then c("Aimed Shot") end
/run --Detect auto shot hang and re-boot shot, if has Swift Aspects we can cast Aimed Shot
/run --if not melee and HasQuickShot() and cd("Aimed Shot") == 0 then c("Aimed Shot") end

```

### SM_ItemCD

Get item cooldown state.

Usage:

#### Sample SM_ItemCD of Insignia of the Horde
```
/run if not SM_ItemCD("Insignia of the Horde") then RunLine("/use Insignia of the Horde");end
```
### SM_IsEquipped

Get item equipped state.

#### Sample SM_IsEquipped

```
/run if SM_IsEquipped("Insignia of the Horde") then UIErrorsFrame:AddMessage("Insignia of the Horde equipped");end
```
### Detect player movement
#### Sample moving
```
/run moving = MonkeySpeed.m_fSpeed > 0
/run if moving then CastSpellByName("Arcane Shot") end
```
or
```
/run if MonkeySpeed.m_fSpeed > 0 then CastSpellByName("Arcane Shot") end
```

### AttackPower current value
```
/run local m = UnitMana("player");
/run local melee = CheckInteractDistance("target", 3) and not UnitIsDead("target");
/run local swinged = st_timer < 0.2
/run local moving = MonkeySpeed.m_fSpeed > 0
/run function ap() local base, posBuff, negBuff = UnitAttackPower("player");return base + posBuff + negBuff end

/run if tarh < 0.21 then if ap() > 2000 then CastSpellByName("Mortal Strike") else CastSpellByName("Execute") end end
```

### Swinged
```
/run m = UnitMana("player");
/run local swinged = st_timer < 0.2
/run if swinged and m > 44 then CastSpellByName("Mortal Strike") end
```

### Warrior Decisive Strike

Depond on [MonkeySpeed](https://github.com/MarcelineVQ/MonkeySpeed)   [SP_SwingTimer](https://github.com/MarcelineVQ/SP_SwingTimer)
```
/run local m = UnitMana("player");
/run local melee = CheckInteractDistance("target", 3) and not UnitIsDead("target");
/run local swinged = st_timer < 0.2
/run local moving = MonkeySpeed.m_fSpeed > 0
/run if melee and m > 44 and swinged and moving then CastSpellByName("Decisive Strike") end
```

### Hunter melee
```
/run local m = UnitMana("player");
/run local melee = CheckInteractDistance("target", 3) and not UnitIsDead("target");
/run local swinged = st_timer < 0.2
/run local moving = MonkeySpeed.m_fSpeed > 0
/run function ap() local base, posBuff, negBuff = UnitAttackPower("player");return base + posBuff + negBuff end

/run if melee and ap() > 1800 and swinged and not moving then CastSpellByName("Raptor Strike") end
```

### Player buff and debuff
```
/script function m(s) DEFAULT_CHAT_FRAME:AddMessage(s); end for i=1,16 do s=UnitBuff("player", i); if(s) then m("B "..i..": "..s); end s=UnitDebuff("player", i); if(s) then m("D "..i..": "..s); end end
```