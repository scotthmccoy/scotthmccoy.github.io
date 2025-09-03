
**Running Revelation**

[Running Revelation from the CLI](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/interface/remoteinterface/consolescreen_interface.cpp?ref_type=heads#L615) calls the [3-param version of RunRevelation](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp?ref_type=heads#L841) in the plot generator.

it scores your hack, giving you a success value is 3 if all security is disabled or bypassed, 2 if some are, and 1 if none are.

This is reduced by 1 if there’s a trace in progress (and there almost always is when you’re running stuff on the CLI):

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



The func then calls the [4-param version of RunRevelation](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp?ref_type=heads#L941) which will tell the machine to become infected, but only if the success value is greater than 0:
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

/*
	//
	// Now deploy the virus, based on that success value
	//

	if ( success == 0 ) {												// They manage to stop the virus from running

	}
	else if ( success == 1 ) {											// Infect this computer only before it is stopped

		comp->InfectWithRevelation ();

	}
	else if ( success == 2 ) {											// Infect a lot of related computers

		comp->InfectWithRevelation ();

		DArray <Computer *> *comps = game->GetWorld ()->computers.ConvertToDArray ();
		UplinkAssert (comps);

		for ( int i = 0; i < comps->Size (); ++i ) {
			if ( comps->ValidIndex (i) ) {

				Computer *remotecomp = comps->GetData (i);
				UplinkAssert (remotecomp);

				if ( strcmp ( remotecomp->companyname, comp->companyname ) == 0 )
					if ( NumberGenerator::RandomNumber ( 2 ) == 0 )
						remotecomp->InfectWithRevelation ();

			}
		}

		delete comps;

	}
	else if ( success == 3 ) {											// Infect all computers owned by this company

		comp->InfectWithRevelation ();

		DArray <Computer *> *comps = game->GetWorld ()->computers.ConvertToDArray ();
		UplinkAssert (comps);

		for ( int i = 0; i < comps->Size (); ++i ) {
			if ( comps->ValidIndex (i) ) {

				Computer *remotecomp = comps->GetData (i);
				UplinkAssert (remotecomp);

				if ( strcmp ( remotecomp->companyname, comp->companyname ) == 0 )
					remotecomp->InfectWithRevelation ();

			}
		}

		delete comps;

	}
*/

#endif			//DEMOGAME
}
```

This means that despite what ARC tells you about their hopes to improve Revelation to the point that it doesn't need security disabled in order to propagate in the [post-Darwin mission email](https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp?ref_type=heads#L4164), 


https://gitlab.com/matt81093/uplink-source-code/-/blob/master/uplink/src/world/generator/plotgenerator.cpp?ref_type=heads#L3779

Faith
The time between Faith launches is 3 - (version_faith - version_revelation) with a minimum of 1 minute, and its chance of successfully fixing a system is (1.0 - (comp->isinfected_revelation - version) / 2.0) ), with a minimum of 33%.

If you do all the ARC missions perfectly, Revelation is at version 3.0 and Faith is at 0.2, so you’re looking at Faith running every 5.8 minutes (or twice during the 15 minute time limit on Grand Tour), with a 33% chance each time to purge a single infected machine both times.

No other factors other than the software versions affect this including doing the Mole mission or manually sending all the Uplink Agents to jail.



Revelation’s Automatic Propagation
If the version is 1.0 or lower, the machine crashes immediately, stays offline for a long time and Revelation does not reproduce. 

If it’s higher than 1.0, then 3 minutes after successfully infecting a machine (TIME_REVELATIONREPRODUCE) it will reset the machine and then spread to 2 new random systems. I’m pretty sure this automatic doubling was the intended path to victory with the player meant to hack 4-5 systems which then repeatedly double by themselves to reach the goal of 20 systems.

However, these automatic propagations use the 3 param version of RunRevelation instead of directly calling the 4 param version. I think this is a bug as the 3 param version seems to have been intended for when the player does the infection given that it checks the player’s current trace status. 

Since the machines are randomly choses, all security systems on them are going to be active which gives you a base success value of 1, and given that in the middle of Grand Tour you’re probably like mad, you almost always suffer the -1 penalty for being actively traced which means that the automatic propagation effect always fails unless you aren’t doing any hacking!

I’m pretty sure this is why so many guides instruct you to hack about bunch of machines and pre-install the virus, then return to them later and batch-run the virus and then sit back and watch it spread. This strategy “batch job then do jack shit” strategy works because the virus is propagating itself while the player is not being actively traced!
