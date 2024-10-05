### SuperWoW and SuperMacro helper
`ifCasting` is used to determine exactly what the target is casting
Other feature will add if requires.
Depend on:[SuperWoW](https://github.com/balakethelock/SuperWoW)  [SuperMacro](https://github.com/Monteo/SuperMacro) [Quiver](https://github.com/SabineWren/Quiver) [Roid-Macros](https://github.com/DennisWG/Roid-Macros)

### Example Beast Hunter solo one key macro
```/run c=CastSpellByName
/run ud=UnitDebuff
/run tarh =UnitHealth("target")/UnitHealthMax("target");
/run m =UnitMana("player");
/run h =UnitHealth("target");
/run p =UnitHealth("player")/UnitHealthMax("player");
/run combat =UnitAffectingCombat("player");
/run petCombat =UnitAffectingCombat("pet");
/run melee =CheckInteractDistance("target", 3);
/run function AutoAttack() for i=1,120 do if IsCurrentAction(i) then return end end c("Attack") end
/run function AutoShot() for i=1,120 do if IsAutoRepeatAction(i) then return end end c("Auto Shot") end
/run function HuntersMark() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Ability_Hunter_SniperShot" then x=1 end i=i+1 end if x==0 then c("Hunter's Mark")end end
/run function Serpent() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Ability_Hunter_Quickshot" then x=1 end i=i+1 end if x==0 then c("Serpent Sting")end end
/run function WingClip() local i,x=1,0 while ud("target",i) do if ud("target",i)=="Interface\\Icons\\Ability_Rogue_Trip" then x=1 end i=i+1 end if x==0 then c("Wing Clip")end end

/run --ifCasting depend on SuperWoW patch, Quiver.PredMidShot() and Roids.GetSpellCooldownByName need Quiver and Roid-Macros addons
/run if UnitIsDead("target") then ClearTarget() end
/run if GetUnitName("target")==nil then TargetNearestEnemy() end
/run PetAttack()
/run if melee then AutoAttack() else AutoShot() end
/run if Roids.GetSpellCooldownByName("Intimidation") == 0 and ifCasting and petCombat then c("Intimidation") end
/run if not melee then HuntersMark() end
/run if not melee then Serpent() end
/run if Roids.GetSpellCooldownByName("Bestial Wrath") == 0 and petCombat and tarh>0.8 then c("Bestial Wrath") end
/run if melee then WingClip() end
/run if melee then c("Mongoose Bite") end
/run if melee then c("Raptor Strike") end

/run if not melee and not Quiver.PredMidShot() and Roids.GetSpellCooldownByName("Multi-Shot") == 0 then c("Multi-Shot") end
/run if not melee and not Quiver.PredMidShot() then c("Trueshot") end

```