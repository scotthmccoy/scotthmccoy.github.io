---
title: 'Uplink - Grand Tour'
---

Uplink's final challenge for the ARC side is to infect 20 machines with the Revelation virus in 15 minutes. This already challenging task is made frantic by the remaining Arunmor-aligned Uplink Agents seemingly wiping away your progress with the Faith countervirus every time you make some headway. Many players complain the the mission is nearly impossible, with some suggesting that the final version of Revelation you receive from ARC is canonically a rush job with a bug in it that prevents it from actually spreading. Turns out, this is weirdly close to the truth, as the game's source code reveals. Skip to the bottom for the TLDR or dig into the details below...


## Running Revelation in the Command Line
Under the hood, running `run revelation` from a machine's command line causes the [ConsoleInterface class to grab the game state](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/interface/remoteinterface/consolescreen_interface.cpp?ref_type=heads#L615) and call [RunRevelation](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp?ref_type=heads#L841) in the PlotGenerator.

This func scores your hack, giving you a `success` value of 3 if all security is disabled or bypassed, 2 if some are, and 1 if none are.

This `success` value is reduced by 1 if there’s a trace in progress (and there almost always is when you’re running a command on the CLI) and reduced to 0 if your connection has been fully traced (very unlikely, given that you'd be kicked offline).

RunRevelation takes that `success` value and calls a [different function with the same name that takes 4 parameters instead of 3](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp?ref_type=heads#L941). This 4-param version of RunRevelation checks if the `success` value was greater than 0 and then infects the machine.

Interestingly, _it doesn't care what version of Revelation you're running_! Despite what ARC tells you in the [post-Darwin mission email](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp?ref_type=heads#L4164) about how they hope the final version of Revelation will be able to infect other machines without needing security systems bypassed or disabled, the success value if you have an active trace when you run it (and you almost always will), **you need to make sure that at least 1 security system is bypassed or disabled or else the machine will not get infected**.




## Faith
It turns out that the way the game simulates Arunmor-aligned agents working against you is really quite simple.

Once Grand Tour starts, the plot generator calls [RunFaith](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp?ref_type=heads#L899) and then calls it again [every couple of minutes](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp?ref_type=heads#L2861), picking a random infected machine and attempting to fix it with Faith.

The frequency is every `3 - (version_faith - version_revelation)` minutes with a minimum of 1 minute, and its chance of successfully fixing a system is `(1.0 - (comp->isinfected_revelation - version) / 2.0) )`, with a minimum of 33%.

If you do all the ARC missions perfectly, Revelation is at v3.0 and Faith is at v0.2, so you’re looking at Faith running once right when you get the email (typically doing nothing) and then only two more times during the 15 minute time limit for Grand tour: once at 5m48s in, and a second time at 11m36s, with a 33% chance each time to purge a single infected machine. So, you're looking at an average of 2/3 of one machine getting fixed by enemy agents.

**No other factors other than the software versions affect this**, including doing the Mole mission or manually sending all the Uplink Agents to jail!

So why does it seem like your infections keep getting purged? Well...


## Revelation’s Viral Spread Is Horribly Bugged
Every machine in the game updates itself on every tick of the game loop. If it's infected with Revelation version v1.0 or lower, [the machine crashes immediately](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/computer/computer.cpp?ref_type=heads#L154), stays offline for a long time (seeingly up to 8 hours) and Revelation does not reproduce. A lot of folks think that this makes the machine immune to being fixed by Arunmor-aligned enemy agents but this is not true. Even though the _player_ is unable to connect to a machine destroyed by Revelation v1.0 to try and run Faith on it, the simulated enemy agents in the final mission don't have this restriction. The game [just randomly picks an infected machine every so often and tries to run Faith on it](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp#L2854).

If the Revelation version being used is higher than 1.0, then the virus [takes 3 minutes to cook](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/computer/computer.cpp?ref_type=heads#L627), destroys the machine its on and then attempts to spread to 2 new random systems. However, many players have noticed the virus tends to not to spread, leading many to assume that enemy agents are aggressively cleaning up Revelation infections by installing Faith.

This is because the way the viral spread is simulated uses the [3-param version of RunRevelation](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/computer/computer.cpp?ref_type=heads#L641) instead of the [4-param version](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp#L941). **I'm certain this is a bug** because it effectively treats the _player_ as being the one uploading the virus instead of the virus itself! The code checks the player's current trace status, _no matter which machine they are currently connected to_ and if they are actively being traced by _that_ machine, the viral spread fails unless the machine the virus is spreading itself to somehow had at least 1 security system disabled.

This means if you are hacking as fast as possible, you're likely being actively traced most of the time which would mean that during those propagation events Revelation burns itself out instead of propagating. The harder you work, the worse it gets! 

I’m pretty sure this is why so many guides advocate for either using v1.0 of Revelation, hacking a bunch of machines before the mission gets started or my personal favorite, the “batch job then do jack shit” strategy: hack a bunch of machines and install v3.0 but _don't_ run it, then return to each machine about 5 minutes into the mission and run the virus as fast as possible "to overwhelm Arunmor agents" and crucially, sit back and watch it spread. The strategy actually works because sitting back and watching it spread means you're not actively being traced!

## TLDR for Beating Grand Tour
1. Don't fuck up the story missions - Revelation should be at 3.0 and Faith at only v0.2.
2. Use the best version of Revelation you can. Ignore advice to use v1.0.
3. Make sure you have at least 1 security system bypassed or disabled when running Revelation on the command line or the machine will 
not get infected.
4. Don't bother clearing logs from InterNIC afterwards - in the next 15 minutes you're either getting disavowed by Uplink or destroying the entire internet.
5. Keep an eye on your Revelation Tracker. Better yet, run a stopwatch. Exactly 3 minutes after you ran Revelation on the command line, make sure you're not being actively traced, and you should see an infection dissappear from the tracker and 2 new ones arrive. Just make sure you're not being traced at those 3-minute marks or the viral spread will fail due to the bug.
6. This should get you to about 6 machines by the 5-ish minute mark which is more than enough. It will [double to 12](https://www.youtube.com/watch?v=JBxkney44eg) at 8m, and then double again to 24 by 11m [so long as you just chill out and let the virus do the work for you](https://www.youtube.com/watch?v=H6viHHbIxt0).
