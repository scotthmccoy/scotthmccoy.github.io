# Uplink - Grand Tour
Uplink's final challenge for the ARC side is to infect 20 machines with the Revelation virus in 15 minutes. This already challenging task is made much more difficult by the remaining Arunmor-aligned Uplink Agents seemingly wiping away your progress with the Faith countervirus every time you make some headway. Many complain the the mission is nearly impossible, with many suggesting that the final version of Revelation you receive from ARC is a rush job with a bug in it that prevents it from actually spreading - so you may as well use Revelation v1.0 instead because it knocks a system offline for several hours and can't be fixed with Faith. Others suggest that killing or imprisoning all the other Uplink agents helps.

However, the game's source code is available, and it tells a very different story... 

## Running Revelation in the Command Line

[Running Revelation from the CLI](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/interface/remoteinterface/consolescreen_interface.cpp?ref_type=heads#L615) calls [A 3-param version of RunRevelation](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp?ref_type=heads#L841) in the plot generator.

This func scores your hack, giving you a success value of 3 if all security is disabled or bypassed, 2 if some are, and 1 if none are.

This is reduced by 1 if there’s a trace in progress (and there almost always is when you’re running a command on the CLI):

```
  ...

	// Work out how successful he was
	// Based on correct target and how much security was enabled on the target
	// and if he had been spotted when he released it

	int success = -1;				// 0 = total failure, 1 = local system only, 2 = medium success, 3 = total success

	int numsystems = comp->security.NumSystems ();
	int numrunningsystems = comp->security.NumRunningSystems ();

	if		( numrunningsystems == numsystems ) 		success = 1;
	else if ( numrunningsystems == 0 )					success = 3;
	else												success = 2;

	if ( game->GetWorld ()->GetPlayer ()->connection.Traced () ) {

		success = 0;

	}
	else if ( game->GetWorld ()->GetPlayer ()->connection.TraceInProgress () ) {

		success--;

	}

	++numuses_revelation;

	RunRevelation ( ip, version, playerresponsible, success );

  ...
```

This 3-param version of RunRevelation eventually calls a [4-param version](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp?ref_type=heads#L941) which is what actually tells the machine to become infected, but only if the success value of the hack was greater than 0:

```
void PlotGenerator::RunRevelation ( char *ip, float version, bool playerresponsible, int success )
{

#ifndef DEMOGAME

	//
	// Look up the system attacked
	//

	VLocation *vl = game->GetWorld ()->GetVLocation ( ip );
	UplinkAssert (vl);
	Computer *comp = vl->GetComputer ();
	UplinkAssert (comp);

    if ( comp->isinfected_revelation > 0.0 ) return;

    if ( success > 0 ) {

        comp->InfectWithRevelation ( version );
        Infected ( ip );

    }

    if ( version <= 1.0 )
       	NewsRevelationUsed ( ip, success );
}
```

Note that it _doesn't care about what version of Revelation you're running_! Despite what ARC tells you in the [post-Darwin mission email](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp?ref_type=heads#L4164), if you have an active trace when you run it (and you almost always will), **you need to make sure that at least 1 security system is bypassed or disabled or else the machine will not get infected**.




## Faith
It turns out that the way the game simulates Arunmor-aligned agents working against you is really quite simple.

Once the mission starts, [RunFaith](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp?ref_type=heads#L899) [gets called](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp?ref_type=heads#L2861) every `3 - (version_faith - version_revelation)` minutes with a minimum of 1 minute, and its chance of successfully fixing a system is `(1.0 - (comp->isinfected_revelation - version) / 2.0) )`, with a minimum of 33%.

If you do all the ARC missions perfectly, Revelation is at v3.0 and Faith is at v0.2, so you’re looking at Faith running twice during the 15 minute time limit for Grand tour: once at 5m48s into Grand tour and a second time at 11m36s, with a 33% chance each time to purge a single infected machine.

**No other factors other than the software versions affect this**, including doing the Mole mission or manually sending all the Uplink Agents to jail!

So why does it seem like your infections keep getting purged?


https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/computer/computer.cpp?ref_type=heads#L618


## Revelation’s Automatic Propagation Is Horribly Bugged
When a machine gets infected, if the Revelation version is v1.0 or lower, [the machine crashes immediately](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/computer/computer.cpp?ref_type=heads#L154), stays offline for a long time and Revelation does not reproduce. Even though the player is unable to connect to a machine destroyed by Revelation v1.0 to try and run Faith on it, the game's simulation of enemy agents don't have this restriction. The game [just randomly picks an infected machine every so often and tries to fix it](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp#L2854).

If the Revelation version being used is higher than 1.0, then the virus [takes 3 minutes to cook](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/computer/computer.cpp?ref_type=heads#L627) and then destroys the machine and then attempts to spread to 2 new random systems. However, the virus tends not to spread, leading many to assume that enemy agents are aggressively cleaning up Revelation infections by installing Faith.

This is because the way the viral spread is simulated uses the [3-param version of RunRevelation](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/computer/computer.cpp?ref_type=heads#L641) instead of the [4-param version](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp#L941). I'm certain this is a bug because it effectively treats the player as being the one uploading the virus instead of the virus itself! The code checks the player's current trace status, _no matter which other machine they are currently connected to_ and if they are actively being traced by that machine, the viral spread fails unless the machine the virus was spreading to somehow had at least 1 security system disabled.

No wonder so many people find the mission almost impossible! If you use the best version of Revelation you have available, the faster you work, the more likely it is to backfire and result in the virus disappearing rather than spreading.

I’m pretty sure this is why so many guides advocate for a “batch job then do jack shit” strategy: pre-hack a bunch of machines and install v3.0 but don't run it, then return to each later and run the virus program as fast as possible "to overwhelm Arunmor agents" and then crucially, sit back and watch it spread. The strategy actually works because sitting back and watching it spread means you're not actively being traced!

## TLDR for beating Grand Tour
1. Don't fuck up the story missions - Revelation should be at 3.0 and Arunmor should have Faith at only v0.2.
2. Use the best version of Revelation you can. Ignore advice to use v1.0.
3. Make sure you have at least 1 security system bypassed or disabled when running Revelation on the command line or the machine will 
not get infected.
4. Keep an eye on your Revelation Tracker or better yet, run a stopwatch. Exactly 3 minutes after you ran Revelation on the command line, make sure you're not being actively traced. You can be cracking a password, setting up programs to run, whatever, just make sure you're not being traced or the viral spread will fail due to the bug.
5. Get another 1-2 machines hacked after that and then [just stop and let the virus do the work for you](https://www.youtube.com/watch?v=JBxkney44eg). You only need about 6 infected machines and at least 6 minutes left to be guaranteed a [kill screen](https://www.youtube.com/watch?v=H6viHHbIxt0).
