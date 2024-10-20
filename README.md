### SuperWoW and SuperMacro helper
`SM_IsCastingIncludeName()` is used to determine exactly what the target is casting
#### Parameter
- no have param: all casting duration > 2.5s return true
- string: casting name include the param string and duration > 2.5s return true,for example "Healing"
  
Other features will add if requires.

Depend on:

[SuperWoW](https://github.com/balakethelock/SuperWoW)  

### Example Beast Hunter solo one key macro
This example depend on:

[SuperMate](https://github.com/leenux/SuperMate)

[SuperMacro](https://github.com/Monteo/SuperMacro) 

[Quiver](https://github.com/SabineWren/Quiver) 

[Roid-Macros](https://github.com/DennisWG/Roid-Macros)

```
/run c=CastSpellByName
/run ud=UnitDebuff
/run tarh =UnitHealth("target")/UnitHealthMax("target");
/run m =UnitMana("player");
/run h =UnitHealth("target");
/run p =UnitHealth("player")/UnitHealthMax("player");
/run combat =UnitAffectingCombat("player");
/run petCombat =UnitAffectingCombat("pet");
/run melee =CheckInteractDistance("target", 3) and not UnitIsDead("target");
/run tarType =UnitCreatureType("target")
/run function FreeShot(secs) local a, b = Quiver.GetSecondsRemainingShoot(); local m, n = Quiver.GetSecondsRemainingReload(); return (a and b < -0.25) or (m and n > secs) end
/run function AutoAttack() for i=1,120 do if IsCurrentAction(i) then return end end c("Attack") end
/run function AutoShot() for i=1,120 do if IsAutoRepeatAction(i) then return end end c("Auto Shot") end
/run function HuntersMark() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Ability_Hunter_SniperShot" then x=1 end i=i+1 end if x==0 then c("Hunter's Mark")end end
/run function Serpent() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Ability_Hunter_Quickshot" then x=1 end i=i+1 end if x==0 then c("Serpent Sting")end end
/run function WingClip() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Ability_Rogue_Trip" then x=1 end i=i+1 end if x==0 then c("Wing Clip")end end

/run --SM_IsCastingIncludeName() depend on SuperWoW patch, Quiver.PredMidShot() and Roids.GetSpellCooldownByName need Quiver and Roid-Macros addons
/run if UnitIsDead("target") then ClearTarget() end
/run if GetUnitName("target")==nil then TargetNearestEnemy() end
/run PetAttack()
/run if melee then AutoAttack() else AutoShot() end

/run --Cast Intimidation if target casting name include Healing string and duration > 2.5s
/run if Roids.GetSpellCooldownByName("Intimidation") == 0 and SM_IsCastingIncludeName("Healing") and petCombat then c("Intimidation") end

/run if not melee then HuntersMark() end
/run if not melee and tarType ~= "Elemental" and tarType ~= "Mechanical" then Serpent() end

/run --When solo, cast Bestial Wrath before target health > 80%
/run if Roids.GetSpellCooldownByName("Bestial Wrath") == 0 and petCombat and tarh>0.8 then c("Bestial Wrath") end

/run if melee then WingClip() end
/run if melee then c("Mongoose Bite") end
/run if melee then c("Raptor Strike") end

/run --Detect auto shot hang and re-boot shot, when remaining time > 0.5s we can cast multi-shot
/run if not melee and FreeShot(0.5) and Roids.GetSpellCooldownByName("Multi-Shot") == 0 then c("Multi-Shot") end
/run --Detect auto shot hang and re-boot shot, when remaining time > 1.2s we can cast Trueshot
/run if not melee and FreeShot(1.2) then c("Trueshot") end

```

### SM_ItemCD

Get item cooldown state.

Usage ref below sample

#### Sample SM_ItemCD by cross-roads offhand
```
/run if not SM_ItemCD("Waters of Vision") then RunLine("/equip Skinning Knife");RunLine("/equipoh Waters of Vision");UIErrorsFrame:AddMessage("==BAT");RunLine("/use Waters of Vision");end
/run if SM_ItemCD("Waters of Vision") then RunLine("/equip Sturdy Quarterstaff of Power");UIErrorsFrame:AddMessage("--WEAPON");end
```
1h x2
```
/run if not SM_ItemCD("Waters of Vision") then RunLine("/equip Skinning Knife");RunLine("/equipoh Waters of Vision");UIErrorsFrame:AddMessage("==BAT");RunLine("/use Waters of Vision");end
/run if SM_ItemCD("Waters of Vision") then RunLine("/equip Deadly Bronze Poniard");RunLine("/equipoh Deadly Bronze Poniard");UIErrorsFrame:AddMessage("--WEAPON");end
```
### SM_IsEquipped

Get item equipped state.

#### Sample SM_IsEquipped

```
/run if SM_IsEquipped("Waters of Vision") then UIErrorsFrame:AddMessage("Waters of Vision equipped");end
```