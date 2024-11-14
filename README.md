### SuperWoW and SuperMacro helper

Depend on:

[SuperWoW](https://github.com/balakethelock/SuperWoW)  

### Example triple talents one key macro
This example depend on:

[SuperMate](https://github.com/leenux/SuperMate)

[SuperMacro](https://github.com/Monteo/SuperMacro) 

[Quiver](https://github.com/SabineWren/Quiver) 

[SP_SwingTimer](https://github.com/MarcelineVQ/SP_SwingTimer)

```
/run if UnitIsDead("target") then ClearTarget() end
/run if GetUnitName("target")==nil then TargetNearestEnemy() end

/run c = CastSpellByName
/run u = UnitBuff
/run ud = UnitDebuff
/run tarh = UnitHealth("target")/UnitHealthMax("target");
/run m = UnitMana("player");
/run pm = UnitMana("pet");
/run h = UnitHealth("target");
/run p = UnitHealth("player")/UnitHealthMax("player");
/run combat = UnitAffectingCombat("player");
/run petCombat = UnitAffectingCombat("pet");
/run function cd(s) return SuperMate.GetSpellCooldownByName(s) == 0; end
/run icd = GetItemCooldown;
/run moving = SuperMate.IsMoving;
/run melee = CheckInteractDistance("target", 3) and not UnitIsDead("target");
/run tarType = UnitCreatureType("target")
/run function FreeShot(secs) local a, b = Quiver.GetSecondsRemainingShoot(); local m, n = Quiver.GetSecondsRemainingReload(); return (a and b < -0.25) or (m and n > secs) end
/run function hang() local a, b = Quiver.GetSecondsRemainingShoot(); return a and b < -0.25 end
/run function AutoAttack() for i=1,120 do if IsCurrentAction(i) then return end end c("Attack") end
/run function AutoShot() for i=1,120 do if IsAutoRepeatAction(i) then return end end c("Auto Shot") end
/run function HuntersMark() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Ability_Hunter_SniperShot" then x=1 end i=i+1 end if x==0 then c("Hunter's Mark")end end
/run function Serpent() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Ability_Hunter_Quickshot" then x=1 end i=i+1 end if x==0 then c("Serpent Sting")end end
/run function WingClip() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Ability_Rogue_Trip" then x=1 end i=i+1 end if x==0 then c("Wing Clip")end end
/run function hasExplosive() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Spell_Fire_SelfDestruct" then x=1 end i=i+1 end if x==1 then return true;end end
/run function HasQuickShot() local i,x=1,0 while u("player",i) do if u("player",i)=="Interface\\Icons\\Ability_Warrior_InnerRage" then x=1 end i=i+1 end if x==1 then return true end end
/run function ap() local base, posBuff, negBuff = UnitAttackPower("player");return base + posBuff + negBuff end
/run casting = SuperMate.IsCastingIncludeName;
/run swinged = st_timer < 0.2;
/run imm = st_timer and ((st_timer + 1) > UnitAttackSpeed("player"));
/run t = GetTalentInfo;
/run function hasCarve() local _, _, _, _, has, _, _, _, _, _, _=t(3,9);if has then return true; end end
/run function canTrap() local _, _, _, _, has, _, _, _, _, _, _=t(3,19);if has then return true; end end
/run function hasIntimidation() local _, _, _, _, has, _, _, _, _, _, _=t(1,13);if has then return true; end end
/run function hasBestial() local _, _, _, _, has, _, _, _, _, _, _=t(1,17);if has then return true; end end
/run function hasSteady() local _, _, _, _, has, _, _, _, _, _, _=t(2,7);if has then return true; end end
/run inRaid = GetNumRaidMembers() > 0;

/run PetAttack()
/run if not melee and hang() then c("Attack") end
/run if melee then AutoAttack() else AutoShot() end
/run if not melee then HuntersMark() end

/run --Cast Intimidation if target casting name include Healing string and duration > 2.5s
/run if hasIntimidation() and cd("Intimidation") and casting("Healing") and petCombat then c("Intimidation") end
/run if not melee and casting("Healing") and FreeShot(0.5) and cd("Multi-Shot") and not cd("Intimidation") then c("Multi-Shot") end

/run --if not melee and tarType ~= "Elemental" and tarType ~= "Mechanical" then Serpent() end

/run --When solo, cast Bestial Wrath before target health > 80%
/run if hasBestial() and cd("Bestial Wrath") and petCombat and tarh>0.8 then c("Bestial Wrath") end

/run if melee and imm and cd("Mongoose Bite") then c("Mongoose Bite") end
/run if melee and hasCarve() and cd("Carve") then c("Carve") end
/run local canExplosive = inRaid or not hasExplosive(); if melee and canTrap() and cd("Explosive Trap") and canExplosive then c("Explosive Trap") end
/run if melee and cd("Wing Clip") then WingClip() end
/run if melee and swinged and cd("Raptor Strike") then c("Raptor Strike") end

/run --Detect auto shot hang and re-boot shot, when remaining time > 0.5s we can cast multi-shot
/run --if not melee and FreeShot(0.5) and cd("Multi-Shot") then c("Multi-Shot") end
/run --Detect auto shot hang and re-boot shot, when remaining time > 1.2s we can cast Steady Shot
/run if not melee and hasSteady() and FreeShot(1.2) then c("Steady Shot") end

/run --Detect auto shot hang and re-boot shot, when remaining time > 1.5s and has Swift Aspects we can cast Aimed Shot
/run --if not melee and FreeShot(1.5) and HasQuickShot() and cd("Aimed Shot") then c("Aimed Shot") end
/run --Detect auto shot hang and re-boot shot, if has Swift Aspects we can cast Aimed Shot
/run --if not melee and HasQuickShot() and cd("Aimed Shot") then c("Aimed Shot") end

```

### SuperMate.IsEquipped(itemName)

Get item equipped state.

#### Sample SuperMate.IsEquipped

```
/run if SuperMate.IsEquipped("Insignia of the Horde") then UIErrorsFrame:AddMessage("Insignia of the Horde equipped");end
```
### Detect player movement
#### Sample moving
```
/run moving = SuperMate.IsMoving
/run if moving then CastSpellByName("Arcane Shot") end
```
or
```
/run if SuperMate.IsMoving then CastSpellByName("Arcane Shot") end
```

### AttackPower current value
```
/run m = UnitMana("player");
/run melee = CheckInteractDistance("target", 3) and not UnitIsDead("target");
/run swinged = st_timer < 0.2;
/run moving = SuperMate.IsMoving
/run function ap() local base, posBuff, negBuff = UnitAttackPower("player");return base + posBuff + negBuff end

/run if tarh < 0.21 then if ap() > 2000 then CastSpellByName("Mortal Strike") else CastSpellByName("Execute") end end
```

### Swinged
```
/run m = UnitMana("player");
/run swinged = st_timer < 0.2;
/run if swinged and m > 44 then CastSpellByName("Mortal Strike") end
```

### Warrior Decisive Strike

```
/run m = UnitMana("player");
/run melee = CheckInteractDistance("target", 3) and not UnitIsDead("target");
/run swinged = st_timer < 0.2;
/run moving = SuperMate.IsMoving
/run if melee and m > 44 and swinged and moving then CastSpellByName("Decisive Strike") end
```

### Hunter melee
```
/run m = UnitMana("player");
/run melee = CheckInteractDistance("target", 3) and not UnitIsDead("target");
/run swinged = st_timer < 0.2;
/run moving = SuperMate.IsMoving
/run function ap() local base, posBuff, negBuff = UnitAttackPower("player");return base + posBuff + negBuff end

/run if melee and ap() > 1800 and swinged and not moving then CastSpellByName("Raptor Strike") end
```

### Player buff and debuff
```
/script function m(s) DEFAULT_CHAT_FRAME:AddMessage(s); end for i=1,16 do s=UnitBuff("player", i); if(s) then m("B "..i..": "..s); end s=UnitDebuff("player", i); if(s) then m("D "..i..": "..s); end end
```

### Cooldown example
```
/run pm = UnitMana("pet");
/run cd = SuperMate.GetSpellCooldownByName;
/run print("----g cd:"..tostring(cd("Growl")))
/run print("----m cd:"..tostring(cd("Multi-Shot")))
/run print("----mana:"..pm) 
```