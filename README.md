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

[MonkeySpeed](https://github.com/MarcelineVQ/MonkeySpeed)

```
/run c = CastSpellByName
/run ud = UnitDebuff
/run tarh = UnitHealth("target")/UnitHealthMax("target");
/run m = UnitMana("player");
/run h = UnitHealth("target");
/run p = UnitHealth("player")/UnitHealthMax("player");
/run combat = UnitAffectingCombat("player");
/run petCombat = UnitAffectingCombat("pet");
/run cd = Roids.GetSpellCooldownByName;
/run casting = SM_IsCastingIncludeName
/run moving = MonkeySpeed.m_fSpeed > 0
/run melee = CheckInteractDistance("target", 3) and not UnitIsDead("target");
/run tarType = UnitCreatureType("target")
/run function FreeShot(secs) local a, b = Quiver.GetSecondsRemainingShoot(); local m, n = Quiver.GetSecondsRemainingReload(); return (a and b < -0.25) or (m and n > secs) end
/run function AutoAttack() for i=1,120 do if IsCurrentAction(i) then return end end c("Attack") end
/run function AutoShot() for i=1,120 do if IsAutoRepeatAction(i) then return end end c("Auto Shot") end
/run function HuntersMark() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Ability_Hunter_SniperShot" then x=1 end i=i+1 end if x==0 then c("Hunter's Mark")end end
/run function Serpent() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Ability_Hunter_Quickshot" then x=1 end i=i+1 end if x==0 then c("Serpent Sting")end end
/run function WingClip() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Ability_Rogue_Trip" then x=1 end i=i+1 end if x==0 then c("Wing Clip")end end

/run --casting depend on SuperWoW patch and this addons(SuperMate), FreeShot depond on Quiver, cd depond on Roid-Macros addons
/run --moving depend on MonkeySpeed
/run if UnitIsDead("target") then ClearTarget() end
/run if GetUnitName("target")==nil then TargetNearestEnemy() end
/run PetAttack()
/run if melee then AutoAttack() else AutoShot() end

/run --Cast Intimidation if target casting name include Healing string and duration > 2.5s
/run if cd("Intimidation") == 0 and casting("Healing") and petCombat then c("Intimidation") end
/run if not melee and casting("Healing") and FreeShot(0.5) and cd("Multi-Shot") == 0 and cd("Intimidation") ~= 0 then c("Multi-Shot") end

/run if not melee then HuntersMark() end
/run if not melee and tarType ~= "Elemental" and tarType ~= "Mechanical" then Serpent() end

/run --When solo, cast Bestial Wrath before target health > 80%
/run --if cd("Bestial Wrath") == 0 and petCombat and tarh>0.8 then c("Bestial Wrath") end

/run if melee then WingClip() end
/run if melee then c("Mongoose Bite") end
/run if melee then c("Raptor Strike") end

/run --Detect auto shot hang and re-boot shot, when remaining time > 0.5s we can cast multi-shot
/run --if not melee and FreeShot(0.5) and cd("Multi-Shot") == 0 then c("Multi-Shot") end
/run --Detect auto shot hang and re-boot shot, when remaining time > 1.2s we can cast Steady Shot
/run --if not melee and FreeShot(1.2) then c("Steady Shot") end

```

### SM_ItemCD

Get item cooldown state.

Usage ref below sample

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
/run moving = MonkeySpeed.m_fSpeed
/run if moving then CastSpellByName("Arcane Shot") end
```
or
```
/run if MonkeySpeed.m_fSpeed > 0 then CastSpellByName("Arcane Shot") end
```
