-- Original Horde zone route. Quest facts, sources and limits are recorded in SOURCES.md.
-- Keep guide names stable: RXP stores each character's progress under these names.
if UnitFactionGroup("player") ~= "Horde" then
    return
end

RXPGuides.RegisterGuide([=[
#forever
<< Horde
#group Riverglades Horde (Beta)
#subgroup Riverglades 36-46
#name RG - 01 Rog'mar and the River
#displayname 1. Rog'mar and the River (36-41)
#version 4
#next RG - 02 Sunnyglade and Bolder'ok

step
    +Riverglades is the new zone south of the Badlands. Rog'mar, in the middle of the zone, is the Horde hub.
    >>Beta guide: written from public quest data in the zone's first week, with no guarantee that every step, location or quest order is right. Skip any step that does not match the game.
    >>This chapter works the Rog'mar quests around the river, Turner's Logging Camp, Meadowsbrook, Sunnyglade and the Bristle Hills. Quests you cannot take yet are skipped automatically.
step
    .zone 2548 >>Travel to Riverglades. From the Badlands, ride the road south into the zone. If you already know the Rog'mar flight path, fly there from Kargath instead.
step
    .goto 2548,59.6,45.1,15
    .target Grakna
    >>Ride to Grakna, the wind rider master in Rog'mar, and get the Rog'mar flight path if you do not have it. It connects to Kargath, Stonard, Hammerfall and Flame Crest.
    >>This step finishes when you reach Grakna. RXP's flight database has no Rog'mar entry, so it cannot tell whether you already know this flight path.
step
    .isOnQuest 95141
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .turnin 95141 >>Turn in Report to Rog'mar to Krom'rosh.
step
    .xp <35,1
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .accept 93786 >>Accept A Message in Blood from Krom'rosh.
step
    .xp <36,1
    .goto 2548,59.8,46.0
    .target Kreza Darkthorn
    .accept 93788 >>Accept Borrowed Blades from Kreza Darkthorn.
step
    .xp <36,1
    .goto 2548,59.8,46.0
    .target Kreza Darkthorn
    .accept 94535 >>Accept Bristle Hills Bandits. If Kreza does not offer it yet, skip this step; it is checked again later.
step
    .xp <36,1
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .accept 96107 >>Accept Feathers for Fletching from Neza Bloodsnout.
step
    .isOnQuest 95143
    .goto 2548,58.2,45.2
    .target Tan'jani
    .turnin 95143 >>Turn in Finding Tan'jani to Tan'jani.
step
    .xp <36,1
    .goto 2548,58.2,45.2
    .target Tan'jani
    .accept 95951 >>Accept Fetch 'n' Fletch from Tan'jani.
step
    #optional
    .xp <38,1
    .goto 2548,59.5,47.0
    .accept 95992 >>Optional elite: take WANTED: Ghostmaw from the board by Neza. Ghostmaw, a level 42 crocolisk, patrols the river between Rog'mar and Sunnyglade.
step
    #optional
    #completewith SunnygladeDone
    .isOnQuest 95992
    >>Optional elite: Ghostmaw patrols the river from Rog'mar down past Sunnyglade. Kill it for Ghostmaw's Fang whenever you meet it.
    .complete 95992,1
    .unitscan Ghostmaw
step
    #optional
    .xp <38,1
    .goto 2548,59.6,46.9
    .accept 95882 >>Optional elite: take WANTED: Scoutmaster Vargas from the poster. Vargas is on the north-east coast and is routed in chapter 3.
step
    .xp <36,1
    .goto 2548,61.6,58.8
    .accept 96103 >>Ride south and search the Picked Carcass for the Gnawed Skull. This starts A Feast for Buzzards.
step
    .xp <36,1
    .goto 2548,68.2,48.6
    .target Sleebo Fizzlespout
    .accept 96063 >>East of Rog'mar among the buzzards, accept Gaseous Gold from Sleebo Fizzlespout. Its gas vents are by the ponds where you hunt vipers later.
step
    #loop
    .isOnQuest 96107
    .goto 2548,66.4,51.1,0
    .goto 2548,60.8,59.9,40,0
    .goto 2548,60.2,50.3,40,0
    .goto 2548,64.5,46.4,40,0
    .goto 2548,71.9,49.1,40,0
    .goto 2548,72.5,49.5,40,0
    >>Kill Low Plains Buzzards on the plains east of Rog'mar for 6 Plains Buzzard Feathers.
    .complete 96107,1
    .mob Low Plains Buzzard
step
    .isQuestComplete 96107
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .turnin 96107 >>Return to Neza and turn in Feathers for Fletching.
step
    .isOnQuest 96103
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .turnin 96103 >>Turn in A Feast for Buzzards.
step
    .isQuestTurnedIn 96107
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .accept 96108 >>Accept Poison Tips.
step
    .isQuestTurnedIn 96103
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .accept 96104 >>Accept Song of the Strider.
step
    .xp <36,1
    .goto 2548,68.2,48.6
    .target Sleebo Fizzlespout
    .accept 96063 >>If you do not have Gaseous Gold yet, accept it from Sleebo Fizzlespout east of Rog'mar before the vipers. Its gas vents are by the same ponds.
step
    #completewith ViperDone
    .isOnQuest 96104
    >>Kill Roving Tallstriders on the plains around Rog'mar until one drops an Intact Tallstrider Beak.
    .complete 96104,1
    .mob Roving Tallstrider
step
    #completewith ViperDone
    .isOnQuest 96063
    >>Loot Marsh Gas Vials from the gas vents by the marshy ponds while you hunt vipers.
    .complete 96063,1
step
    #loop
    #label ViperDone
    .isOnQuest 96108
    .goto 2548,62.9,58.5,0
    .goto 2548,66.5,58.5,40,0
    .goto 2548,64.7,63.3,40,0
    .goto 2548,61.1,63.3,40,0
    .goto 2548,59.3,58.5,40,0
    .goto 2548,61.1,53.7,40,0
    .goto 2548,64.7,53.7,40,0
    >>Kill Glade Vipers south-east of Rog'mar for 4 Glade Viper Venom.
    .complete 96108,1
    .mob Glade Viper
step
    #loop
    .isOnQuest 96063
    .goto 2548,61.7,58.4,0
    .goto 2548,57.3,55.9,40,0
    .goto 2548,62.4,53.7,40,0
    .goto 2548,64.3,53.6,40,0
    .goto 2548,64.4,54.8,40,0
    .goto 2548,62.9,64.6,40,0
    .goto 2548,59.5,62.7,40,0
    >>Finish the Marsh Gas Vials from the gas vents around the marshy ponds.
    .complete 96063,1
step
    #loop
    .isOnQuest 96104
    .goto 2548,64.0,49.4,0
    .goto 2548,58.2,47.4,40,0
    .goto 2548,64.0,45.5,40,0
    .goto 2548,66.4,46.8,40,0
    .goto 2548,70.1,56.5,40,0
    >>Finish the Intact Tallstrider Beak.
    .complete 96104,1
    .mob Roving Tallstrider
step
    .isQuestComplete 96063
    .goto 2548,68.2,48.6
    .target Sleebo Fizzlespout
    .turnin 96063 >>Ride east to Sleebo and turn in Gaseous Gold.
step
    .xp <36,1
    .isQuestTurnedIn 96063
    .goto 2548,68.2,48.6
    .target Sleebo Fizzlespout
    .accept 96067 >>Accept Rock 'em and Sock 'em.
step
    .isOnQuest 96067
    .goto 2548,68.3,49.0
    >>Fight G45-B4G beside Sleebo to stress test the engine.
    .complete 96067,1
step
    .isQuestComplete 96067
    .goto 2548,68.2,48.6
    .target Sleebo Fizzlespout
    .turnin 96067 >>Turn in Rock 'em and Sock 'em.
step
    .isQuestComplete 96108
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .turnin 96108 >>Turn in Poison Tips.
step
    .isQuestComplete 96104
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .turnin 96104 >>Turn in Song of the Strider.
step
    .isQuestTurnedIn 96108
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .accept 96109 >>Accept A Hunter's Quiver.
step
    #optional
    .isQuestTurnedIn 96104
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .accept 96105 >>Optional elite: accept King of the Wild Plains. Skip this step if you will not fight a level 41 elite lion.
step
    #loop
    .isOnQuest 96109
    .goto 2548,60.0,52.5,0
    .goto 2548,57.7,56.7,40,0
    .goto 2548,60.4,50.5,40,0
    .goto 2548,62.3,48.7,40,0
    >>Just south of Rog'mar, kill Wildplains Patriarchs and Huntresses for 6 Prized Lion Hides.
    .complete 96109,1
    .mob Wildplains Patriarch
    .mob Wildplains Huntress
step
    #optional
    .isOnQuest 96105
    .goto 2548,59.7,53.5
    >>Optional elite: on the hilltop where the lions live, use the Tallstrider Call. Kill Ombassa and take Ombassa's Hide.
    .complete 96105,1
    .use 271779
    .mob Ombassa
step
    .isQuestComplete 96109
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .turnin 96109 >>Turn in A Hunter's Quiver.
step
    .isQuestComplete 96105
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .turnin 96105 >>Turn in King of the Wild Plains.
step
    .xp <36,1
    .isQuestTurnedIn 96109
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .accept 94532 >>Accept Gnoll Infestation. The gnolls are in the Bristle Hills at the end of this chapter.
step
    #optional
    .xp <36,1
    .isQuestTurnedIn 96109
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .accept 94533 >>Optional elite: accept Snargl's Snout. Skip this step if you will not fight a level 40 elite gnoll.
step
    #completewith next
    .isOnQuest 93788
    >>West across the river at Turner's Logging Camp, kill lumberjacks for 10 Woodworker's Axes.
    .complete 93788,1
    .mob Turner's Mill Lumberjack
    .mob Woodworker
step
    #loop
    .isOnQuest 95951
    .goto 2548,41.6,60.0,0
    .goto 2548,44.2,60.0,40,0
    .goto 2548,42.9,63.5,40,0
    .goto 2548,40.3,63.5,40,0
    .goto 2548,39.0,60.0,40,0
    .goto 2548,40.3,56.5,40,0
    .goto 2548,42.9,56.5,40,0
    >>Collect Wood Bundles from the Peasant Woodpiles around Turner's Logging Camp, then fletch them into 20 Makeshift Stickin' Spears.
    .complete 95951,1
step
    #loop
    .isOnQuest 93788
    .goto 2548,42.0,59.6,0
    .goto 2548,44.9,59.6,40,0
    .goto 2548,43.4,63.6,40,0
    .goto 2548,40.5,63.6,40,0
    .goto 2548,39.0,59.6,40,0
    .goto 2548,40.5,55.7,40,0
    .goto 2548,43.4,55.7,40,0
    >>Finish the 10 Woodworker's Axes.
    .complete 93788,1
    .mob Turner's Mill Lumberjack
    .mob Woodworker
step
    #loop
    .isOnQuest 93786
    .goto 2548,45.6,80.5,0
    .goto 2548,44.4,77.6,40,0
    .goto 2548,45.2,76.5,40,0
    .goto 2548,47.3,84.8,40,0
    .goto 2548,45.0,82.9,40,0
    >>Ride south to the Meadowsbrook farm and kill 12 Meadowsbrook Farmhands. Watch for Farholde patrols.
    .complete 93786,1
    .mob Meadowsbrook Farmhand
step
    .isQuestComplete 93786
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .turnin 93786 >>Return to Rog'mar and turn in A Message in Blood.
step
    .isQuestTurnedIn 93786
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .accept 93787 >>Accept Food for the Taking.
step
    #optional
    .xp <36,1
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .accept 94483 >>If Krom'rosh offers Show Them How It's Done now, accept it. Otherwise skip this step; it is offered after Food for the Taking.
step
    .isQuestComplete 93788
    .goto 2548,59.8,46.0
    .target Kreza Darkthorn
    .turnin 93788 >>Turn in Borrowed Blades.
step
    .isQuestTurnedIn 93788
    .goto 2548,59.8,46.0
    .target Kreza Darkthorn
    .accept 93976 >>Accept The Goblin Trader. Keep the blade; it goes to Powderfuse Port in chapter 3.
step
    .xp <36,1
    .goto 2548,59.8,46.0
    .target Kreza Darkthorn
    .accept 94535 >>Accept Bristle Hills Bandits if you do not have it yet.
step
    .isQuestComplete 95951
    .goto 2548,58.2,45.2
    .target Tan'jani
    .turnin 95951 >>Turn in Fetch 'n' Fletch.
step
    .isQuestTurnedIn 95951
    .goto 2548,58.2,45.2
    .target Tan'jani
    .accept 95955 >>Accept Stick 'Em.
step
    #loop
    .isOnQuest 95955
    .goto 2548,48.8,53.8,0
    .goto 2548,41.8,54.8,40,0
    .goto 2548,42.9,53.8,40,0
    .goto 2548,57.1,47.1,40,0
    .goto 2548,55.9,53.3,40,0
    .goto 2548,47.5,58.2,40,0
    .goto 2548,42.2,57.2,40,0
    >>Impale 10 Freshwater Crocolisks along the river between Rog'mar and Sunnyglade.
    .complete 95955,1
    .mob Freshwater Crocolisk
step
    #completewith next
    .isOnQuest 94483
    >>Kill Farholde Priests and Scouts south of the river while you work.
    .complete 94483,1
    .complete 94483,2
    .mob Farholde Priest
    .mob Farholde Scout
step
    #loop
    .isOnQuest 93787
    .goto 2548,45.4,81.4,0
    .goto 2548,48.0,81.4,40,0
    .goto 2548,46.7,84.9,40,0
    .goto 2548,44.1,84.9,40,0
    .goto 2548,42.8,81.4,40,0
    .goto 2548,44.1,77.9,40,0
    .goto 2548,46.7,77.9,40,0
    >>Back at Meadowsbrook, steal 6 Feed Satchels from the farm.
    .complete 93787,1
step
    #loop
    .isOnQuest 94483
    .goto 2548,47.9,66.7,0
    .goto 2548,42.0,60.1,40,0
    .goto 2548,48.8,63.6,40,0
    .goto 2548,53.2,70.5,40,0
    .goto 2548,52.1,72.0,40,0
    .goto 2548,50.7,71.7,40,0
    .goto 2548,44.4,65.2,40,0
    .goto 2548,42.9,62.2,40,0
    >>Finish the Farholde Priests and Scouts between Meadowsbrook and the river.
    .complete 94483,1
    .complete 94483,2
    .mob Farholde Priest
    .mob Farholde Scout
step
    .isQuestComplete 95955
    .goto 2548,58.2,45.2
    .target Tan'jani
    .turnin 95955 >>Return to Rog'mar and turn in Stick 'Em.
step
    .isQuestComplete 95992
    .goto 2548,58.2,45.2
    .target Tan'jani
    .turnin 95992 >>Turn in WANTED: Ghostmaw.
step
    .isQuestComplete 93787
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .turnin 93787 >>Turn in Food for the Taking.
step
    .isQuestComplete 94483
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .turnin 94483 >>Turn in Show Them How It's Done.
step
    .isQuestTurnedIn 93787
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .accept 94480 >>Accept A Gift From Our Enemies.
step
    .xp <36,1
    .isQuestTurnedIn 93787
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .accept 94483 >>Accept Show Them How It's Done if you do not have it yet.
step
    .isOnQuest 94480
    .goto 2548,58.6,44.6
    .target Gorg
    .turnin 94480 >>Give the Stolen Feed to Gorg.
step
    .isQuestTurnedIn 94480
    .goto 2548,58.6,44.6
    .target Gorg
    .accept 94481 >>Accept A Serving of Strength.
step
    #loop
    .isOnQuest 94481
    .goto 2548,59.0,35.5,0
    .goto 2548,61.6,35.5,40,0
    .goto 2548,60.3,39.0,40,0
    .goto 2548,57.7,39.0,40,0
    .goto 2548,56.4,35.5,40,0
    .goto 2548,57.7,32.0,40,0
    .goto 2548,60.3,32.0,40,0
    >>North of Rog'mar at the training grounds, use the Hearty Stew to feed 8 Rog'mar Trainees.
    .complete 94481,1
    .use 265066
step
    .isQuestComplete 94481
    .goto 2548,58.6,44.6
    .target Gorg
    .turnin 94481 >>Turn in A Serving of Strength.
step
    #loop
    .isOnQuest 94483
    .goto 2548,47.9,66.7,0
    .goto 2548,42.0,60.1,40,0
    .goto 2548,48.8,63.6,40,0
    .goto 2548,53.2,70.5,40,0
    .goto 2548,52.1,72.0,40,0
    .goto 2548,50.7,71.7,40,0
    .goto 2548,44.4,65.2,40,0
    .goto 2548,42.9,62.2,40,0
    >>If Show Them How It's Done is still open, return south of the river and finish the Farholde Priests and Scouts.
    .complete 94483,1
    .complete 94483,2
    .mob Farholde Priest
    .mob Farholde Scout
step
    .isQuestComplete 94483
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .turnin 94483 >>Turn in Show Them How It's Done. Tran'gul's quests open after this.
step
    .xp <36,1
    .isQuestTurnedIn 94483
    .goto 2548,59.4,44.0
    .target Tran'gul
    .accept 94672 >>Accept Encroaching Twilight from Tran'gul, inside the house at the back of Rog'mar.
    .accept 94680 >>Accept Twilight Missives.
step
    .xp <36,1
    .goto 2548,44.4,47.3
    .target Fuzzle
    .accept 94961 >>West across the river in Sunnyglade, accept Biting the Hand from Fuzzle.
step
    #completewith SunnygladeDone
    .isOnQuest 94961
    >>Loot Twilight Finger Bones from Twilight's Hammer cultists while you work Sunnyglade.
    .complete 94961,1
    .mob Twilight Raider
    .mob Twilight Neophyte
    .mob Twilight Shadowmancer
step
    #completewith SunnygladeDone
    .isOnQuest 94672
    >>Kill Twilight Raiders, Neophytes and Shadowmancers while you work Sunnyglade.
    .complete 94672,1
    .complete 94672,2
    .complete 94672,3
    .mob Twilight Raider
    .mob Twilight Shadowmancer
    .mob Twilight Neophyte
step
    #loop
    .isOnQuest 94672
    .goto 2548,44.7,49.1,0
    .goto 2548,42.3,53.4,40,0
    .goto 2548,42.9,47.2,40,0
    .goto 2548,47.3,42.3,40,0
    .goto 2548,45.1,53.9,40,0
    >>Kill Twilight Neophytes on the west side of Sunnyglade.
    .complete 94672,3
    .mob Twilight Neophyte
step
    #loop
    .isOnQuest 94680
    .goto 2548,45.7,55.3,0
    .goto 2548,44.4,57.3,40,0
    .goto 2548,47.0,52.7,40,0
    .goto 2548,45.1,57.2,40,0
    >>Kill Twilight Shadowmancers in southern Sunnyglade for 3 Twilight Missives.
    .complete 94680,1
    .mob Twilight Shadowmancer
step
    #loop
    #label SunnygladeDone
    .isOnQuest 94672
    .goto 2548,47.5,49.9,0
    .goto 2548,40.8,43.6,40,0
    .goto 2548,51.3,40.0,40,0
    .goto 2548,56.1,46.0,40,0
    .goto 2548,53.3,55.5,40,0
    .goto 2548,44.7,57.4,40,0
    .goto 2548,41.6,52.8,40,0
    >>Finish the Twilight Raiders on the east side of Sunnyglade, and any Neophytes or Shadowmancers still needed.
    .complete 94672,1
    .complete 94672,2
    .complete 94672,3
    .mob Twilight Raider
    .mob Twilight Shadowmancer
    .mob Twilight Neophyte
step
    #loop
    .isOnQuest 94961
    .goto 2548,47.5,49.9,0
    .goto 2548,40.8,43.6,40,0
    .goto 2548,51.3,40.0,40,0
    .goto 2548,56.1,46.0,40,0
    .goto 2548,53.3,55.5,40,0
    .goto 2548,44.7,57.4,40,0
    .goto 2548,41.6,52.8,40,0
    >>Finish the 20 Twilight Finger Bones.
    .complete 94961,1
    .mob Twilight Raider
    .mob Twilight Neophyte
    .mob Twilight Shadowmancer
step
    .isQuestComplete 94961
    .goto 2548,44.4,47.3
    .target Fuzzle
    .turnin 94961 >>Turn in Biting the Hand to Fuzzle.
step
    .isQuestTurnedIn 94961
    .goto 2548,44.4,47.3
    .target Fuzzle
    .accept 94963 >>Accept the second Biting the Hand.
step
    .isOnQuest 94963
    .goto 2548,41.7,47.7
    .turnin 94963 >>Escort Fuzzle west out of Sunnyglade and fight off the cultists who try to stop you. Open Fuzzle's Treasure at the end to finish the quest.
    >>If Fuzzle dies, abandon the quest and take it again from Fuzzle.
step
    .isQuestComplete 94672
    .goto 2548,59.4,44.0
    .target Tran'gul
    .turnin 94672 >>Return to Tran'gul and turn in Encroaching Twilight.
step
    .isQuestComplete 94680
    .goto 2548,59.4,44.0
    .target Tran'gul
    .turnin 94680 >>Turn in Twilight Missives.
step
    .isQuestTurnedIn 94680
    .goto 2548,59.4,44.0
    .target Tran'gul
    .accept 94727 >>Accept Digging for Answers. It starts the next chapter.
step
    .isQuestComplete 95992
    .goto 2548,58.2,45.2
    .target Tan'jani
    .turnin 95992 >>Turn in WANTED: Ghostmaw to Tan'jani.
step
    .xp <36,1
    .goto 2548,30.2,69.0
    .target Gelinda Coppergleam
    .accept 95792 >>Ride far south-west to Gelinda Coppergleam by the dragon caves and accept Clear 'em Out.
    .accept 95934 >>Accept Proof of Profit.
step
    #completewith next
    .isOnQuest 95934
    >>Look for a piece of Cubic Draconia in the dragon caves while you clear them.
    .complete 95934,1
step
    #loop
    .isOnQuest 95792
    .goto 2548,29.7,73.3,0
    .goto 2548,28.5,71.1,40,0
    .goto 2548,29.6,69.4,40,0
    .goto 2548,31.0,76.3,40,0
    .goto 2548,30.2,77.0,40,0
    .goto 2548,29.3,76.3,40,0
    .goto 2548,28.0,72.1,40,0
    >>Kill Cinderscale Whelps and Warriors in the caves south of Gelinda.
    .complete 95792,1
    .complete 95792,2
    .mob Cinderscale Whelp
    .mob Cinderscale Warrior
step
    #loop
    .isOnQuest 95934
    .goto 2548,30.2,73.3,0
    .goto 2548,32.8,73.3,40,0
    .goto 2548,31.5,76.8,40,0
    .goto 2548,28.9,76.8,40,0
    .goto 2548,27.6,73.3,40,0
    .goto 2548,28.9,69.8,40,0
    .goto 2548,31.5,69.8,40,0
    >>Finish Proof of Profit: loot the Cubic Draconia crystal in the dragon caves.
    .complete 95934,1
step
    #optional
    .xp <36,1
    .isQuestAvailable 95936
    .goto 2548,31.0,72.8
    >>Optional elite: kill Scaldaron, the dragon at the back of the caves. Use the Head of Scaldaron it drops to start Hail the Dragonslayer.
    .collect 271613,1,95936
    .use 271613
    .accept 95936
    .mob Scaldaron
step
    .isQuestComplete 95792
    .goto 2548,30.2,69.0
    .target Gelinda Coppergleam
    .turnin 95792 >>Turn in Clear 'em Out.
step
    .isQuestComplete 95934
    .goto 2548,30.2,69.0
    .target Gelinda Coppergleam
    .turnin 95934 >>Turn in Proof of Profit.
step
    #completewith BristleDone
    .isOnQuest 94535
    >>Loot Stolen Ore from the gnolls in the Bristle Hills.
    .complete 94535,1
    .mob Redridge Brute
    .mob Redridge Mystic
    .mob Redridge Trapper
step
    #loop
    .isOnQuest 94532
    .goto 2548,18.6,68.2,0
    .goto 2548,15.1,67.8,40,0
    .goto 2548,16.6,66.2,40,0
    .goto 2548,19.0,65.4,40,0
    .goto 2548,23.1,66.9,40,0
    .goto 2548,16.9,73.2,40,0
    .goto 2548,15.9,73.7,40,0
    >>West of the dragon caves in the Bristle Hills, kill Redridge Mystics, Trappers and Brutes.
    .complete 94532,1
    .complete 94532,2
    .complete 94532,3
    .mob Redridge Mystic
    .mob Redridge Trapper
    .mob Redridge Brute
step
    #optional
    .isOnQuest 94533
    .goto 2548,16.0,73.2
    >>Optional elite: kill Snargl and take Snargl's Snout.
    .complete 94533,1
    .unitscan Snargl
step
    #loop
    #label BristleDone
    .isOnQuest 94535
    .goto 2548,18.6,68.2,0
    .goto 2548,15.1,67.8,40,0
    .goto 2548,16.6,66.2,40,0
    .goto 2548,19.0,65.4,40,0
    .goto 2548,23.1,66.9,40,0
    .goto 2548,16.9,73.2,40,0
    .goto 2548,15.9,73.7,40,0
    >>Finish the 40 Stolen Ore.
    .complete 94535,1
    .mob Redridge Brute
    .mob Redridge Mystic
    .mob Redridge Trapper
step
    .isQuestComplete 94532
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .turnin 94532 >>Return to Rog'mar and turn in Gnoll Infestation.
step
    .isQuestComplete 94533
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .turnin 94533 >>Turn in Snargl's Snout.
step
    .isQuestComplete 94535
    .goto 2548,59.8,46.0
    .target Kreza Darkthorn
    .turnin 94535 >>Turn in Bristle Hills Bandits.
step
    .isOnQuest 95936
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .turnin 95936 >>Turn in Hail the Dragonslayer.
step
    +Chapter 1 is finished. Continue with Sunnyglade and Bolder'ok.
]=])

RXPGuides.RegisterGuide([=[
#forever
<< Horde
#group Riverglades Horde (Beta)
#subgroup Riverglades 36-46
#name RG - 02 Sunnyglade and Bolder'ok
#displayname 2. Sunnyglade and Bolder'ok (40-45)
#version 2
#next RG - 03 Powderfuse Port

step
    +Turn the Sunnyglade ogres against the Twilight's Hammer, then win over the Bolder'ok clan in the north.
    >>Chogg'Zac and the Bloodmaster's Ring fights are elite or tough solo fights. Their steps say so.
    >>The ogre chain starts from Digging for Answers, Tran'gul's last quest in chapter 1. Without it, Clubtoe's steps are skipped.
step
    .isOnQuest 94727
    .goto 2548,49.8,47.0
    .target Clubtoe
    >>In Sunnyglade, go down into the basement under the house and the caves below it. Talk to Clubtoe, the ogre miner, and convince him to talk.
    .complete 94727,1
step
    .isOnQuest 94727
    .goto 2548,49.8,47.0
    .target Clubtoe
    .turnin 94727 >>Turn in Digging for Answers to Clubtoe.
step
    .xp <36,1
    .isQuestTurnedIn 94727
    .goto 2548,49.8,47.0
    .target Clubtoe
    .accept 95417 >>Accept The Purple Ones from Clubtoe.
step
    .xp <36,1
    .isQuestTurnedIn 94727
    .goto 2548,49.8,47.0
    .target Clubtoe
    .accept 95602 >>Accept Sickening Lights.
step
    .isOnQuest 95417
    .goto 2548,49.2,46.8
    .target Twilight Brute
    .turnin 95417 >>Find the dead Twilight Brute in the caves and turn in The Purple Ones.
step
    .isQuestTurnedIn 95417
    .goto 2548,49.2,46.8
    .target Twilight Brute
    .accept 95601 >>Accept the second The Purple Ones from the Twilight Brute.
step
    #completewith next
    .isOnQuest 95602
    >>Destroy Twilight Ritual Circles throughout the caves under Sunnyglade.
    .complete 95602,1
step
    .isOnQuest 95601
    .goto 2548,48.0,49.0
    >>Kill Empowered Brutes and Twilight Ritualists in the caves.
    .complete 95601,1
    .complete 95601,2
    .mob Empowered Brute
    .mob Twilight Ritualist
step
    .isOnQuest 95602
    .goto 2548,48.0,49.0
    >>Finish destroying the 5 Twilight Ritual Circles.
    .complete 95602,1
step
    .isQuestComplete 95601
    .goto 2548,49.8,47.0
    .target Clubtoe
    .turnin 95601 >>Return to Clubtoe and turn in The Purple Ones.
step
    .isQuestComplete 95602
    .goto 2548,49.8,47.0
    .target Clubtoe
    .turnin 95602 >>Turn in Sickening Lights.
step
    .xp <36,1
    .isQuestTurnedIn 95601
    .isQuestTurnedIn 95602
    .goto 2548,49.8,47.0
    .target Clubtoe
    .accept 95427 >>Accept Twilight No More! Chogg'Zac is a level 41 elite two-headed ogre; bring help if you need it.
step
    .isOnQuest 95427
    .goto 2548,44.8,51.2
    >>Kill Chogg'Zac deeper in the caves and take both heads.
    .complete 95427,1
    .complete 95427,2
    .mob Chogg'Zac
step
    .isQuestComplete 95427
    .goto 2548,49.8,47.0
    .target Clubtoe
    .turnin 95427 >>Turn in Twilight No More!
step
    .isQuestTurnedIn 95427
    .goto 2548,49.8,47.0
    .target Clubtoe
    .accept 95418 >>Accept Spread the Word.
step
    .isOnQuest 95418
    .goto 2548,59.4,44.0
    .target Tran'gul
    .turnin 95418 >>Return to Rog'mar and give Chogg's Head to Tran'gul.
step
    .isQuestTurnedIn 95418
    .goto 2548,59.4,44.0
    .target Tran'gul
    .accept 95420 >>Accept Land of Giants. The head goes to the ogres of Bolder'ok in the north.
step
    .xp <38,1
    .goto 2548,70.6,28.0
    .target Na'zok
    .accept 95162 >>Ride north-east to Na'zok's paletusk farm and accept Paletusk Harvesting.
    .accept 95163 >>Accept Drive Them Back.
step
    #completewith next
    .isOnQuest 95162
    >>Kill Mature Paletusks for Chunks of Boar Meat.
    .complete 95162,1
    .mob Mature Paletusk
step
    #loop
    .isOnQuest 95163
    .goto 2548,74.2,37.3,0
    .goto 2548,78.1,37.3,40,0
    .goto 2548,76.1,42.6,40,0
    .goto 2548,72.2,42.6,40,0
    .goto 2548,70.2,37.3,40,0
    .goto 2548,72.2,32.0,40,0
    .goto 2548,76.1,32.0,40,0
    >>South of the farm, swat 10 Young Paletusks with the Swineherd's Staff to send them back to their pens.
    .complete 95163,1
    .use 268521
    .mob Young Paletusk
step
    #loop
    .isOnQuest 95162
    .goto 2548,71.0,33.4,0
    .goto 2548,74.2,33.4,40,0
    .goto 2548,72.6,37.7,40,0
    .goto 2548,69.5,37.7,40,0
    .goto 2548,67.9,33.4,40,0
    .goto 2548,69.5,29.1,40,0
    .goto 2548,72.6,29.1,40,0
    >>Finish the 10 Chunks of Boar Meat from Mature Paletusks.
    .complete 95162,1
    .mob Mature Paletusk
step
    .isQuestComplete 95162
    .goto 2548,70.6,28.0
    .target Na'zok
    .turnin 95162 >>Turn in Paletusk Harvesting.
step
    .isQuestComplete 95163
    .goto 2548,70.6,28.0
    .target Na'zok
    .turnin 95163 >>Turn in Drive Them Back.
step
    .isOnQuest 95420
    .goto 2548,64.4,14.8
    .target Clugfist
    .turnin 95420 >>In Bolder'ok, give Chogg's Head to Clugfist.
step
    .xp <36,1
    .isQuestTurnedIn 95420
    .goto 2548,64.4,14.8
    .target Clugfist
    .accept 95424 >>Accept Might Makes Right.
    .accept 95425 >>Accept Unworthy Champion.
step
    .xp <38,1
    .goto 2548,67.2,21.6
    .target Hamur
    .accept 95183 >>Accept Step One: Rock from Hamur.
step
    #completewith next
    .isOnQuest 95183
    >>Loot Good Rocks from the Rock Piles along the river south-east of Bolder'ok.
    .complete 95183,1
step
    #loop
    .isOnQuest 95424
    .goto 2548,75.6,28.3,0
    .goto 2548,73.6,24.0,40,0
    .goto 2548,76.7,25.0,40,0
    .goto 2548,76.9,32.1,40,0
    .goto 2548,75.5,32.1,40,0
    >>East of Bolder'ok, kill Twilight Maulers and Twilight Firecallers.
    .complete 95424,1
    .complete 95424,2
    .mob Twilight Mauler
    .mob Twilight Firecaller
step
    .isOnQuest 95425
    .goto 2548,74.0,26.8
    >>Kill Klunk, Clugfist's old champion, and take back Skullbasher.
    .complete 95425,1
    .mob Klunk
step
    #loop
    #optional
    .isOnQuest 95882
    .goto 2548,75.1,34.0,0
    .goto 2548,75.0,30.1,40,0
    .goto 2548,75.6,35.5,40,0
    .goto 2548,75.1,37.8,40,0
    >>Optional elite: Scoutmaster Vargas stands just south of here, west of Windstead. Kill him and take the Scoutmaster's Eye.
    .complete 95882,1
    .mob Scoutmaster Vargas
step
    #optional
    .xp <36,1
    .isQuestAvailable 94556
    .goto 2548,76.0,27.0
    .target Jom-jom
    .accept 94556 >>If you find Jom-jom with the Twilight's Hammer here, accept Jom-jom's Escape. This location is an estimate; skip this step if Jom-jom is not here.
step
    .isOnQuest 94556
    .goto 2548,64.4,14.8
    .target Clugfist
    .turnin 94556 >>Escort Jom-jom back to Clugfist in Bolder'ok and turn in Jom-jom's Escape.
step
    #loop
    .isOnQuest 95183
    .goto 2548,68.7,29.6,0
    .goto 2548,64.3,23.8,40,0
    .goto 2548,65.7,24.2,40,0
    .goto 2548,74.2,35.9,40,0
    .goto 2548,72.7,35.2,40,0
    .goto 2548,65.7,28.5,40,0
    >>Finish the 10 Good Rocks from Rock Piles along the river.
    .complete 95183,1
step
    .isQuestComplete 95424
    .goto 2548,64.4,14.8
    .target Clugfist
    .turnin 95424 >>Return to Clugfist and turn in Might Makes Right.
step
    .isQuestComplete 95425
    .goto 2548,64.4,14.8
    .target Clugfist
    .turnin 95425 >>Turn in Unworthy Champion.
step
    .xp <36,1
    .isQuestTurnedIn 95424
    .goto 2548,64.4,14.8
    .target Clugfist
    .accept 94668 >>Accept Bloodmaster's Ring.
step
    .xp <36,1
    .isQuestTurnedIn 95424
    .goto 2548,64.4,14.8
    .target Clugfist
    .accept 95428 >>Accept Clugfist's Decree. It is turned in at Rog'mar in chapter 4.
step
    .isQuestComplete 95183
    .goto 2548,67.2,21.6
    .target Hamur
    .turnin 95183 >>Turn in Step One: Rock.
step
    #optional
    .isQuestTurnedIn 95183
    .goto 2548,67.2,21.6
    .target Hamur
    .accept 96026 >>Optional: accept Step Two: More Rock. It needs 10 Heavy Weightstones, crafted by blacksmiths or bought at the auction house. Skip it otherwise.
step
    #optional
    .isOnQuest 96026
    .goto 2548,67.2,21.6
    .target Hamur
    .turnin 96026 >>Turn in Step Two: More Rock once you have the 10 Heavy Weightstones. Skip this step if you are not doing it now.
step
    .isOnQuest 94668
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .turnin 94668 >>Report to Jezap Jinglesprocket at the Bloodmaster's Ring.
step
    .isQuestTurnedIn 94668
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .accept 94669 >>Accept Pay to Play.
step
    .isOnQuest 94669
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .turnin 94669 >>Pay Jezap the 1 gold entry fee to turn in Pay to Play.
step
    .isQuestTurnedIn 94669
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .accept 94670 >>Accept the first Bloodmaster's Ring fight.
step
    .isOnQuest 94670
    .goto 2548,65.6,21.4
    >>Step into the ring and defeat Buzzbeak.
    .complete 94670,1
step
    .isQuestComplete 94670
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .turnin 94670 >>Turn in the fight to Jezap.
step
    .isQuestTurnedIn 94670
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .accept 94739 >>Accept the next fight.
step
    .isOnQuest 94739
    .goto 2548,65.6,21.4
    >>Defeat Kronk in the ring.
    .complete 94739,1
step
    .isQuestComplete 94739
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .turnin 94739 >>Turn in the fight to Jezap.
step
    .isQuestTurnedIn 94739
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .accept 94962 >>Accept the next fight.
step
    .isOnQuest 94962
    .goto 2548,65.6,21.4
    >>Defeat Bonegnaw in the ring.
    .complete 94962,1
step
    .isQuestComplete 94962
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .turnin 94962 >>Turn in the fight to Jezap.
step
    .isQuestTurnedIn 94962
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .accept 94964 >>Accept the next fight.
step
    .isOnQuest 94964
    .goto 2548,65.6,21.4
    >>Defeat Mog'thar in the ring.
    .complete 94964,1
step
    .isQuestComplete 94964
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .turnin 94964 >>Turn in the fight to Jezap.
step
    .isQuestTurnedIn 94964
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .accept 94733 >>Accept Our Ogre Friend.
step
    .isOnQuest 94733
    .goto 2548,66.8,17.2
    .target Gobam
    .turnin 94733 >>Find Gobam east of Clugfist's clubhouse and turn in Our Ogre Friend.
step
    .isQuestTurnedIn 94733
    .goto 2548,66.8,17.2
    .target Gobam
    .accept 94734 >>Accept A Boar's Delight.
step
    .isOnQuest 94734
    >>Collect Sweetberries from the Freshly Picked Berries at the human farm near the ocean (no exact location is recorded yet; check the farms near the southern coast) and Riverweed along the river.
    .complete 94734,1
    .complete 94734,2
step
    .isQuestComplete 94734
    .goto 2548,66.8,17.2
    .target Gobam
    .turnin 94734 >>Return to Gobam and turn in A Boar's Delight.
step
    .isQuestTurnedIn 94734
    .goto 2548,66.8,17.2
    .target Gobam
    .accept 94737 >>Accept A Treat for a Friend.
step
    .isOnQuest 94737
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .turnin 94737 >>Give the treat to Jezap.
step
    .isQuestTurnedIn 94737
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .accept 94965 >>Accept the Snufflesnout fight.
step
    .isOnQuest 94965
    .goto 2548,65.6,21.4
    >>Defeat Snufflesnout in the ring.
    .complete 94965,1
step
    .isQuestComplete 94965
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .turnin 94965 >>Turn in the fight to Jezap.
step
    .isQuestTurnedIn 94965
    .goto 2548,65.6,21.2
    .target Jezap Jinglesprocket
    .accept 95063 >>Accept the final fight against Chub'chob, Bloodmaster of Bolder'ok.
step
    .isOnQuest 95063
    .goto 2548,65.6,21.4
    >>Defeat Chub'chob in the ring.
    .complete 95063,1
step
    .isQuestComplete 95063
    .goto 2548,64.4,14.8
    .target Clugfist
    .turnin 95063 >>Tell Clugfist you are the new champion of the Bloodmaster's Ring.
step
    +Chapter 2 is finished. Keep Clugfist's Decree for chapter 4 and continue with Powderfuse Port.
]=])

RXPGuides.RegisterGuide([=[
#forever
<< Horde
#group Riverglades Horde (Beta)
#subgroup Riverglades 36-46
#name RG - 03 Powderfuse Port
#displayname 3. Powderfuse Port and the Coast (40-45)
#version 2
#next RG - 04 Twilight's Shroud

step
    +Work the neutral goblin port on the east coast: Friz's smuggling, the Eastsea pirates, murlocs and the sea monster.
    >>Wharfmaster Whizzbuzz gives his pirate quests two at a time, so the pirate coast north of the port is visited three times.
    >>Quests that continue to Booty Bay or Tanaris are left out; this guide stays in Riverglades.
step
    .isOnQuest 93976
    .goto 2548,77.0,52.8
    .target Friz Frazzlespark
    .turnin 93976 >>At Powderfuse Port, give the blade to Friz Frazzlespark.
step
    .xp <36,1
    .goto 2548,77.0,52.8
    .target Friz Frazzlespark
    .accept 95062 >>Accept Frazzlespark's Crate for Krom'rosh.
step
    .xp <38,1
    .isQuestTurnedIn 93976
    .goto 2548,77.0,52.8
    .target Friz Frazzlespark
    .accept 95288 >>Accept Smuggler's Paradise.
step
    .xp <36,1
    .goto 2548,79.4,52.8
    .target Wharfmaster Whizzbuzz
    .accept 95118 >>Accept Saltwater Savages from Wharfmaster Whizzbuzz.
step
    .xp <38,1
    .goto 2548,79.4,52.8
    .target Wharfmaster Whizzbuzz
    .accept 95119 >>Accept Unfriendly Competition.
step
    .xp <36,1
    .goto 2548,79.0,54.2
    .target Fimbo Greasemitz
    .accept 95121 >>Accept A Taste of the Sea from Fimbo Greasemitz.
step
    .xp <36,1
    .goto 2548,78.5,53.9
    .accept 95254 >>Take WANTED: Trapclaw from the board.
step
    #optional
    .xp <36,1
    .goto 2548,78.5,53.9
    .accept 95120 >>Optional elite: take WANTED: Old Rot-Chum from the board.
step
    #completewith PortSouthDone
    .isOnQuest 95121
    >>Kill Sand Crawlers and Shore Crawlers for 6 Sand Crawler Meat.
    .complete 95121,2
    .mob Sand Crawler
    .mob Shore Crawler
step
    #loop
    .isOnQuest 95254
    .goto 2548,80.0,53.5,0
    .goto 2548,82.6,53.5,40,0
    .goto 2548,81.3,57.0,40,0
    .goto 2548,78.6,57.0,40,0
    .goto 2548,77.3,53.5,40,0
    .goto 2548,78.6,50.0,40,0
    .goto 2548,81.3,50.0,40,0
    >>Kill Trapclaw at the water's edge by the port and take Trapclaw's Pincer.
    .complete 95254,1
    .mob Trapclaw
step
    .isQuestComplete 95254
    .goto 2548,79.0,54.2
    .target Fimbo Greasemitz
    .turnin 95254 >>Turn in WANTED: Trapclaw to Fimbo.
step
    .xp <38,1
    .goto 2548,72.3,61.8
    .accept 95260 >>South-west of the port, take the Painted Hide to start Terrors From the Deep.
step
    #loop
    .isOnQuest 95118
    .goto 2548,69.5,72.8,0
    .goto 2548,64.0,74.3,40,0
    .goto 2548,75.2,66.1,40,0
    .goto 2548,67.1,79.5,40,0
    >>On the shore and islands south of the port, kill Murloc Warriors and Oracles.
    .complete 95118,1
    .complete 95118,2
    .mob Murloc Warrior
    .mob Murloc Oracle
step
    #loop
    .isOnQuest 95121
    .goto 2548,69.5,72.8,0
    .goto 2548,64.0,74.3,40,0
    .goto 2548,75.2,66.1,40,0
    .goto 2548,67.1,79.5,40,0
    >>Loot 12 Saltwater Murloc Eyes from the murlocs.
    .complete 95121,1
    .mob Murloc Warrior
    .mob Murloc Oracle
step
    #loop
    #optional
    .isOnQuest 95120
    .goto 2548,77.1,73.3,0
    .goto 2548,74.2,72.3,40,0
    .goto 2548,77.9,68.7,40,0
    .goto 2548,79.0,73.7,40,0
    .goto 2548,77.2,79.5,40,0
    >>Optional elite: kill Old Rot-Chum, a level 42 elite on the murloc islands, and take the Rot-Covered Harpoon.
    .complete 95120,1
    .unitscan Old Rot-Chum
step
    #loop
    #label PortSouthDone
    .isOnQuest 95121
    .goto 2548,74.1,64.5,0
    .goto 2548,73.7,58.9,40,0
    .goto 2548,74.7,67.4,40,0
    .goto 2548,74.2,68.7,40,0
    >>Finish the 6 Sand Crawler Meat.
    .complete 95121,2
    .mob Sand Crawler
    .mob Shore Crawler
step
    .isQuestComplete 95118
    .goto 2548,79.4,52.8
    .target Wharfmaster Whizzbuzz
    .turnin 95118 >>Return to the port and turn in Saltwater Savages.
step
    .isQuestComplete 95120
    .goto 2548,79.4,52.8
    .target Wharfmaster Whizzbuzz
    .turnin 95120 >>Turn in WANTED: Old Rot-Chum.
step
    .isQuestComplete 95121
    .goto 2548,79.0,54.2
    .target Fimbo Greasemitz
    .turnin 95121 >>Turn in A Taste of the Sea. It rewards the Briny Seafood Stew recipe (Cooking 200).
step
    #optional
    .xp <36,1
    .isQuestTurnedIn 95121
    .goto 2548,76.0,52.6
    .target Jasper Geartoggle
    .accept 95982 >>Optional: accept Not My Circus from Jasper Geartoggle. It needs 10 Briny Seafood Stew, which needs Cooking 200. Skip it if you will not cook them.
step
    #optional
    .isOnQuest 95982
    .goto 2548,76.0,52.6
    .target Jasper Geartoggle
    .turnin 95982 >>Turn in Not My Circus once you have cooked the 10 Briny Seafood Stew. Skip this step if you are not doing it now.
step
    .isOnQuest 95260
    .goto 2548,79.8,52.4
    .target Argo Brinewhistle
    .turnin 95260 >>Show the Painted Hide to Argo Brinewhistle.
step
    .xp <38,1
    .isQuestTurnedIn 95260
    .goto 2548,79.8,52.4
    .target Argo Brinewhistle
    .accept 95261 >>Accept It Takes Guts.
step
    #completewith ArgoReady
    .isOnQuest 95261
    >>Loot 15 Beast Entrails from beasts as you go; Shore Crawlers and Mature Paletusks near the port drop them.
    .complete 95261,1
    .mob Shore Crawler
    .mob Mature Paletusk
step
    #completewith PirateBeach
    .isOnQuest 95288
    >>Loot Smuggled Goods from Eastsea Buccaneers and Musketeers.
    .complete 95288,1
    .mob Eastsea Buccaneer
    .mob Eastsea Musketeer
step
    #loop
    .isOnQuest 95119
    .goto 2548,84.9,39.4,0
    .goto 2548,80.3,43.7,40,0
    .goto 2548,80.3,42.3,40,0
    .goto 2548,85.1,29.9,40,0
    .goto 2548,89.3,32.3,40,0
    .goto 2548,89.8,33.5,40,0
    .goto 2548,89.9,40.4,40,0
    .goto 2548,83.8,46.9,40,0
    .goto 2548,81.0,46.7,40,0
    >>On the beach north of the port, kill Eastsea Buccaneers and Musketeers.
    .complete 95119,1
    .complete 95119,2
    .mob Eastsea Buccaneer
    .mob Eastsea Musketeer
step
    #loop
    #label PirateBeach
    .isOnQuest 95288
    .goto 2548,84.9,39.4,0
    .goto 2548,80.3,43.7,40,0
    .goto 2548,80.3,42.3,40,0
    .goto 2548,85.1,29.9,40,0
    .goto 2548,89.3,32.3,40,0
    .goto 2548,89.8,33.5,40,0
    .goto 2548,89.9,40.4,40,0
    .goto 2548,83.8,46.9,40,0
    .goto 2548,81.0,46.7,40,0
    >>Finish the 8 Smuggled Goods.
    .complete 95288,1
    .mob Eastsea Buccaneer
    .mob Eastsea Musketeer
step
    .isQuestComplete 95119
    .goto 2548,79.4,52.8
    .target Wharfmaster Whizzbuzz
    .turnin 95119 >>Return to Whizzbuzz and turn in Unfriendly Competition.
step
    .xp <38,1
    .isQuestTurnedIn 95119
    .goto 2548,79.4,52.8
    .target Wharfmaster Whizzbuzz
    .accept 95122 >>Accept Unchecked Expansion.
    .accept 95123 >>Accept A Blast Ye Scurvy Dogs!
step
    .isQuestComplete 95288
    .goto 2548,77.0,52.8
    .target Friz Frazzlespark
    .turnin 95288 >>Turn in Smuggler's Paradise to Friz.
step
    .xp <38,1
    .isQuestTurnedIn 95288
    .goto 2548,77.0,52.8
    .target Friz Frazzlespark
    .accept 95293 >>Accept Smuggler's Special. Captain Bentcoin's ship is visited on the last pirate trip.
step
    #loop
    .isOnQuest 95122
    .goto 2548,77.1,33.0,0
    .goto 2548,74.9,29.9,40,0
    .goto 2548,76.8,28.9,40,0
    .goto 2548,79.1,34.8,40,0
    .goto 2548,79.1,37.0,40,0
    .goto 2548,75.9,35.3,40,0
    >>North of the port in the ruins of Windstead, kill Eastsea Raiders and Bombardiers.
    .complete 95122,1
    .complete 95122,2
    .mob Eastsea Raider
    .mob Eastsea Bombardier
step
    #loop
    .isOnQuest 95123
    .goto 2548,78.8,35.3,0
    .goto 2548,77.1,33.7,40,0
    .goto 2548,79.1,30.5,40,0
    .goto 2548,79.7,38.4,40,0
    .goto 2548,79.2,38.3,40,0
    .goto 2548,77.8,37.1,40,0
    >>Loot 5 Eastsea Powder Kegs from inside the Windstead buildings.
    .complete 95123,1
step
    .isOnQuest 95261
    .goto 2548,75.3,27.5
    >>North-west of Windstead, gather 8 Rotflesh Mushrooms in the Twilight Hollow cave.
    .complete 95261,2
step
    #loop
    #optional
    .isOnQuest 95882
    .goto 2548,75.1,34.0,0
    .goto 2548,75.0,30.1,40,0
    .goto 2548,75.6,35.5,40,0
    .goto 2548,75.1,37.8,40,0
    >>Optional elite: kill Scoutmaster Vargas just west of Windstead and take the Scoutmaster's Eye.
    .complete 95882,1
    .mob Scoutmaster Vargas
step
    #loop
    #label ArgoReady
    .isOnQuest 95261
    .goto 2548,78.1,50.9,0
    .goto 2548,69.5,50.1,40,0
    .goto 2548,83.2,43.8,40,0
    .goto 2548,85.2,45.2,40,0
    .goto 2548,80.3,58.5,40,0
    .goto 2548,78.0,58.1,40,0
    >>Finish the 15 Beast Entrails on the way back.
    .complete 95261,1
    .mob Shore Crawler
    .mob Mature Paletusk
step
    .isQuestComplete 95122
    .goto 2548,79.4,52.8
    .target Wharfmaster Whizzbuzz
    .turnin 95122 >>Turn in Unchecked Expansion.
step
    .isQuestComplete 95123
    .goto 2548,79.4,52.8
    .target Wharfmaster Whizzbuzz
    .turnin 95123 >>Turn in A Blast Ye Scurvy Dogs!
step
    .xp <38,1
    .isQuestTurnedIn 95122
    .isQuestTurnedIn 95123
    .goto 2548,79.4,52.8
    .target Wharfmaster Whizzbuzz
    .accept 95165 >>Accept See Ya, Scallywags!
    .accept 95124 >>Accept Admiral Lamora.
step
    .isQuestComplete 95261
    .goto 2548,79.8,52.4
    .target Argo Brinewhistle
    .turnin 95261 >>Turn in It Takes Guts.
step
    .xp <38,1
    .isQuestTurnedIn 95261
    .goto 2548,79.8,52.4
    .target Argo Brinewhistle
    .accept 95267 >>Accept The Monster Surfaces. The sea monster is fought after the pirates.
step
    .isOnQuest 95165
    .goto 2548,88.2,26.0
    >>Ride to the northern pirate ships. Plant a charge on the first Eastsea ship.
    .complete 95165,1
step
    .isOnQuest 95124
    .goto 2548,90.5,29.5
    >>On the second ship, kill Admiral Lamora. He drops Lamora's Key.
    .complete 95124,1
    .mob Admiral Lamora
step
    .isOnQuest 95124
    .goto 2548,90.5,29.1
    >>Open his stash on the ship's bottom deck and take Lamora's Loot.
    .complete 95124,2
step
    .isOnQuest 95165
    .goto 2548,90.5,30.0
    >>Plant a charge on the second ship.
    .complete 95165,2
step
    .isOnQuest 95165
    .goto 2548,90.9,39.5
    >>Plant a charge on the third ship, Captain Bentcoin's.
    .complete 95165,3
step
    .isOnQuest 95293
    .goto 2548,91.2,39.7
    .target Captain Bentcoin
    .turnin 95293 >>On the same ship, deliver The Friz Special to Captain Bentcoin.
step
    .xp <38,1
    .isQuestTurnedIn 95293
    .goto 2548,91.2,39.7
    .target Captain Haynes
    .accept 95294 >>Accept Smuggler's Bargain from Captain Haynes beside him.
step
    .isQuestComplete 95165
    .goto 2548,79.4,52.8
    .target Wharfmaster Whizzbuzz
    .turnin 95165 >>Return to Whizzbuzz and turn in See Ya, Scallywags!
step
    .isQuestComplete 95124
    .goto 2548,79.4,52.8
    .target Wharfmaster Whizzbuzz
    .turnin 95124 >>Turn in Admiral Lamora.
step
    .isOnQuest 95294
    .goto 2548,77.0,52.8
    .target Friz Frazzlespark
    .turnin 95294 >>Turn in Smuggler's Bargain to Friz. His next quest goes to Tanaris and is not part of this guide.
step
    .isOnQuest 95267
    .goto 2548,74.4,72.2
    >>On the southern shore, use the Big Ball o' Bait to lure out the Monstrous Threshadon. Kill it and take the Sea Monster's Head.
    .complete 95267,1
    .use 268647
    .mob Monstrous Threshadon
step
    .isQuestComplete 95267
    .goto 2548,79.8,52.4
    .target Argo Brinewhistle
    .turnin 95267 >>Turn in The Monster Surfaces.
step
    .isOnQuest 95062
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .turnin 95062 >>Return to Rog'mar and give Frazzlespark's Crate to Krom'rosh.
step
    .isQuestComplete 95882
    .goto 2548,60.4,47.8
    .target Neza Bloodsnout
    .turnin 95882 >>Turn in WANTED: Scoutmaster Vargas.
step
    +Chapter 3 is finished. Continue with the Twilight's Shroud.
]=])

RXPGuides.RegisterGuide([=[
#forever
<< Horde
#group Riverglades Horde (Beta)
#subgroup Riverglades 36-46
#name RG - 04 Twilight's Shroud
#displayname 4. Twilight's Shroud (42-46)
#version 3
#next RG - 05 Krol'dok Stronghold

step
    +Take the war to the Twilight's Hammer fortress in the west with Da'grosh, free the ogre miners, and bring the news back to Rog'mar.
    >>Executioner Morg and Overlord Kilgar are elite. Bring a group for them if you need one.
    >>This chapter starts from Clugfist's Decree, which Clugfist gives in chapter 2. Without it, Krom'rosh does not send you west.
step
    .isOnQuest 95428
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .turnin 95428 >>Turn in Clugfist's Decree to Krom'rosh.
step
    .xp <38,1
    .isQuestTurnedIn 95428
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .accept 94744 >>Accept The Wayward Warrior.
step
    .isOnQuest 94744
    .goto 2548,33.4,38.0
    .target Da'grosh
    .turnin 94744 >>Ride west into the hills and find Da'grosh, Krom'rosh's brother, east of the Twilight's Shroud.
step
    .xp <38,1
    .isQuestTurnedIn 94744
    .goto 2548,33.4,38.0
    .target Da'grosh
    .accept 94745 >>Accept Carving a Path.
    .accept 94748 >>Accept Break Their Chains.
step
    .xp <38,1
    .isQuestTurnedIn 94744
    .goto 2548,33.4,38.0
    .target Da'grosh
    .accept 95431 >>Accept Rumblings of Discontent.
step
    .isOnQuest 95431
    .goto 2548,27.4,37.0
    .target Crag'rog
    .turnin 95431 >>Find Crag'rog in the ogre miners' cave west of Da'grosh.
step
    .xp <36,1
    .isQuestTurnedIn 95431
    .goto 2548,27.4,37.0
    .target Crag'rog
    .accept 95432 >>Accept Rise Up!
step
    .isOnQuest 95432
    .goto 2548,27.0,35.6
    >>Recruit 5 Ogre Miners in the cave.
    .complete 95432,1
step
    .isQuestComplete 95432
    .goto 2548,27.4,37.0
    .target Crag'rog
    .turnin 95432 >>Turn in Rise Up!
step
    .xp <36,1
    .isQuestTurnedIn 95432
    .goto 2548,27.4,37.0
    .target Crag'rog
    .accept 95433 >>Accept Death to the Executioner. Executioner Morg is a level 46 elite.
step
    #completewith ShroudDone
    .isOnQuest 94748
    >>Kill Twilight Champions for Twilight Keys and use them to free Rog'mar Scouts from their cages.
    .complete 94748,1
    .mob Twilight Champion
step
    #completewith ShroudDone
    .isOnQuest 94745
    >>Kill Twilight Fanatics, Corrupters and Champions in the Twilight's Shroud.
    .complete 94745,1
    .complete 94745,2
    .complete 94745,3
    .mob Twilight Fanatic
    .mob Twilight Corrupter
    .mob Twilight Champion
step
    #loop
    .isOnQuest 94745
    .goto 2548,29.3,43.1,0
    .goto 2548,26.8,37.4,40,0
    .goto 2548,28.6,35.5,40,0
    .goto 2548,33.5,44.3,40,0
    .goto 2548,32.9,45.3,40,0
    .goto 2548,27.4,49.9,40,0
    >>Enter the Twilight's Shroud and kill 8 Twilight Champions.
    .complete 94745,3
    .mob Twilight Champion
step
    .isOnQuest 95433
    .goto 2548,29.8,41.2
    >>Kill Executioner Morg and take the Executioner's Mace.
    .complete 95433,1
    .mob Executioner Morg
step
    #loop
    .isOnQuest 94745
    .goto 2548,32.0,44.7,0
    .goto 2548,26.6,45.9,40,0
    .goto 2548,28.1,43.9,40,0
    .goto 2548,36.2,44.4,40,0
    .goto 2548,37.2,44.5,40,0
    >>Kill 8 Twilight Fanatics.
    .complete 94745,1
    .mob Twilight Fanatic
step
    #loop
    #label ShroudDone
    .isOnQuest 94745
    .goto 2548,28.0,43.7,0
    .goto 2548,25.4,45.7,40,0
    .goto 2548,29.0,35.2,40,0
    .goto 2548,28.9,51.2,40,0
    >>Kill 8 Twilight Corrupters.
    .complete 94745,2
    .mob Twilight Corrupter
step
    #loop
    .isOnQuest 94748
    .goto 2548,29.3,43.1,0
    .goto 2548,26.8,37.4,40,0
    .goto 2548,28.6,35.5,40,0
    .goto 2548,33.5,44.3,40,0
    .goto 2548,32.9,45.3,40,0
    .goto 2548,27.4,49.9,40,0
    >>Finish rescuing the 5 Rog'mar Scouts.
    .complete 94748,1
    .mob Twilight Champion
step
    .isQuestComplete 94745
    .goto 2548,33.4,38.0
    .target Da'grosh
    .turnin 94745 >>Return to Da'grosh and turn in Carving a Path.
step
    .isQuestComplete 94748
    .goto 2548,33.4,38.0
    .target Da'grosh
    .turnin 94748 >>Turn in Break Their Chains.
step
    .xp <38,1
    .isQuestTurnedIn 94745
    .isQuestTurnedIn 94748
    .goto 2548,33.4,38.0
    .target Da'grosh
    .accept 94768 >>Accept Bring Me His Head. Overlord Kilgar is a level 46 elite.
step
    .isOnQuest 94768
    .goto 2548,26.6,44.8
    >>Enter the stronghold inside the Twilight's Shroud. Kill Overlord Kilgar and take Kilgar's Head.
    .complete 94768,1
    .mob Overlord Kilgar
step
    .isQuestComplete 94768
    .goto 2548,33.4,38.0
    .target Da'grosh
    .turnin 94768 >>Turn in Bring Me His Head.
step
    .xp <38,1
    .isQuestTurnedIn 94768
    .goto 2548,33.4,38.0
    .target Da'grosh
    .accept 95278 >>Accept It Is Time, Brother...
step
    .xp <38,1
    .isQuestTurnedIn 94768
    .goto 2548,33.4,38.0
    .target Da'grosh
    .accept 94975 >>Accept A Token of Vengeance, a quest for the Krol'dok Stronghold dungeon in chapter 5. Skip this step if Da'grosh does not offer it or you will not run the dungeon.
step
    .isOnQuest 95278
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .turnin 95278 >>Ride straight back to Rog'mar and give the missive to Krom'rosh.
step
    .isOnQuest 93971
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .turnin 93971 >>If you looted a Farholde Scouting Report anywhere in the zone, turn it in to Krom'rosh now.
step
    .isQuestComplete 95433
    .goto 2548,64.4,14.8
    .target Clugfist
    .turnin 95433 >>Ride north to Bolder'ok and give the Executioner's Mace to Clugfist.
step
    .xp <40,1
    .isQuestTurnedIn 95278
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .accept 94968 >>Accept Eye of Mugg from Krom'rosh, a Krol'dok Stronghold dungeon quest. Skip this step if he does not offer it or you will not run the dungeon.
step
    .xp <39,1
    .goto 2548,59.4,44.0
    .target Tran'gul
    .accept 94972 >>Accept Tome of Twilight from Tran'gul, a Krol'dok Stronghold dungeon quest. Skip this step if he does not offer it or you will not run the dungeon.
step
    .xp <40,1
    .goto 2548,58.2,45.2
    .target Tan'jani
    .accept 95033 >>Accept On the Other Side from Tan'jani. It sends you to Witch Doctor Uzer'i at Camp Mojache in Feralas when you leave Riverglades.
step
    +The Riverglades zone story is finished. Chapter 5 is the Krol'dok Stronghold dungeon (group, 40-45); skip it if you are not running the dungeon.
    >>The quests that continue to Booty Bay and Tanaris are not part of this guide.
]=])

RXPGuides.RegisterGuide([=[
#forever
<< Horde
#group Riverglades Horde (Beta)
#subgroup Riverglades 36-46
#name RG - 05 Krol'dok Stronghold
#displayname 5. Krol'dok Stronghold (dungeon, 40-45)
#version 1

step
    +Krol'dok Stronghold is a five-player dungeon (levels 40-45) in the north of Riverglades, held by the Twilight's Hammer. Find a group before you go.
    >>Its Horde quests come from Da'grosh, Krom'rosh and Tran'gul at the end of chapter 4. Steps for quests you do not have are skipped.
step
    .xp <40,1
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .accept 94968 >>If you do not have Eye of Mugg yet, accept it from Krom'rosh.
step
    .xp <39,1
    .goto 2548,59.4,44.0
    .target Tran'gul
    .accept 94972 >>If you do not have Tome of Twilight yet, accept it from Tran'gul.
step
    .xp <38,1
    .isQuestTurnedIn 94768
    .goto 2548,33.4,38.0
    .target Da'grosh
    .accept 94975 >>If you do not have A Token of Vengeance yet, accept it from Da'grosh west of the Twilight's Shroud on the way.
step
    .goto 2548,39.0,39.0
    >>Meet your group at the meeting stone in front of the closed fortress gates. The dungeon portal is in a small cave just west of the gates.
step
    .goto 2548,37.5,37.2
    >>Enter the small cave west of the fortress gates and take the portal into Krol'dok Stronghold.
step
    #completewith KroldokDone
    .isOnQuest 94975
    >>Loot Cultist Ears from the Twilight's Hammer throughout the dungeon.
    .complete 94975,1
step
    #optional
    #completewith KroldokDone
    .isQuestAvailable 94973
    >>If a Krol'dok Moulding drops, take it and use it to start Krol'dok Moulding. Kreza Darkthorn in Rog'mar takes it after the run.
    .collect 267137,1,94973
    .use 267137
    .accept 94973
step
    #completewith KroldokDone
    .isOnQuest 94972
    >>Kill Nar'gurk and take the Tome of Twilight.
    .complete 94972,1
    .mob Nar'gurk
step
    .isOnQuest 94968
    >>Clear to the last boss, Overlord Mugg, and take the Eye of Mugg.
    .complete 94968,1
    .mob Overlord Mugg
step
    .isOnQuest 94975
    >>Finish the 15 Cultist Ears before you leave.
    .complete 94975,1
step
    #label KroldokDone
    +Check your quest log before leaving: the Tome of Twilight, the Eye of Mugg and the Cultist Ears should be done. Then leave the dungeon.
step
    .isQuestComplete 94975
    .goto 2548,33.4,38.0
    .target Da'grosh
    .turnin 94975 >>Turn in A Token of Vengeance to Da'grosh, west of the Twilight's Shroud.
step
    .isQuestComplete 94972
    .goto 2548,59.4,44.0
    .target Tran'gul
    .turnin 94972 >>Return to Rog'mar and turn in Tome of Twilight to Tran'gul.
step
    .isQuestComplete 94968
    .goto 2548,59.4,45.6
    .target Krom'rosh
    .turnin 94968 >>Turn in Eye of Mugg to Krom'rosh.
step
    .isOnQuest 94973
    .goto 2548,59.8,46.0
    .target Kreza Darkthorn
    .turnin 94973 >>Show the Krol'dok Moulding to Kreza Darkthorn.
step
    #optional
    .xp <38,1
    .isQuestTurnedIn 94973
    .goto 2548,59.8,46.0
    .target Kreza Darkthorn
    .accept 94974 >>Optional: accept Key Ingredients. Kreza needs 4 Thick Leather and 12 Iron Bars (crafted or bought) to make the Krol'dok Compound Key. Skip it otherwise.
step
    #optional
    .isQuestComplete 94974
    .goto 2548,59.8,46.0
    .target Kreza Darkthorn
    .turnin 94974 >>Turn in Key Ingredients once you have the leather and bars.
step
    +Krol'dok Stronghold is finished. On the Other Side sends you on to Camp Mojache in Feralas.
]=])
