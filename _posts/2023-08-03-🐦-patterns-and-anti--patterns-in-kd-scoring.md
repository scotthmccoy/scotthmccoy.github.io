# APIClient
This was a Singleton with CRUD functions that return Publishers. 

Publishers seem to be primarily useful for meeting the needs of an asynchronous and/or stream-based environment - perhaps like a chat application or a Twitter-like feed of content. Since KD Scoring was neither async nor stream-based, my APIClient was awkward and way over-engineered.

SwiftUI sort of gently but firmly guides you towards Combine’s `@State` for data that doesn’t change without user input and `@ObservedObject`/`@Published` for data that can. 
 
# NavigationManager
This was a singleton that held the nav state of the app. This was made obsolete by `@Environment(\.presentationMode) var presentationMode`


# @EnvironmentObject
I quickly realized that this wasn’t a great solution because my model objects nest a lot of objects within each other, so simply `@EnvironmentObject`-ing a giant data structure would require each ViewModel to be able to track where in the object tree they were and be able to perform the necessary surgery on it.

I suppose you could use different `@EnvironmentObject`s in different areas of your app, effectively giving you a singleton per area, but why not just build a smarter singleton?


# Informal ViewModel
This was hard but ultimately a VERY good choice. It’s much more readable and there’s a lot less pointless boilerplate. https://scotthmccoy.github.io/2021/11/15/a-viewmodel-s-responsibility-is-to.html

I noticed that having `@State`’d structs means you get prodded to update them with fresh data in an onAppear, and only in an onAppear.


# AppState (Observable)
My goal was to have a universally observable singleton that could expose a single source of constant truth and have all the views in the app bind to it. 

However I eventually realized that the exposed structs would have to be Optional or else the singleton was effectively lying. Once I made them so, I had to come up with rules to nil out, say, selectedGame when selectedCampaign changed and I realized that I was effectively defining view logic inside the model, and that I was once again invalidating views that I wasn’t even interacting with.


# AppState With no Observable Structs 
Easy to test, elegant with SwiftUI’s @state bindings on views 


# @State Everything, then update on onAppear
```
    func campaignViewOnAppear(campaign:Campaign) {
        do {
            campaignView.campaign = try AppState.singleton.read(campaignId:campaign.id)
        } catch {
            //TODO: Handle Error
            AppLog("error reading campaign: \(error)")
        }
    }


    List() {
        ForEach(campaigns) { campaign in
            NavigationLink(destination: campaignView.onAppear() {
                campaignViewOnAppear(campaign: campaign)
            })
            {
                CampaignRowView(campaign:campaign)
            }
            .isDetailLink(false)
        }
```
The upshot of this is that you get to have a “single” CampaignView.



# Future: Split the Model
This project really highlighted that the cost in awkwardness from nesting Model structs is only worth it when there is a significant gain to be had in access times, particularly JOINs. With a simple data model and only a couple dozen records, a standard ER style is not only fine, it’s actually faster.   I learned this once before on LunchVote where I tried to use Mongo for a tiny project.

Model Objects being nested also meant that changing a leaf object (say, a `PlayerEndGameState`) effectively changed the top level object (an array of `Campaign` structs) which was invalidating views that the user might not even be looking at.

This is probably why the BP seems to be to split the Model into:
1. A Domain Model: a set of structs for views to interact with. For example, a `FooView` gets a `FooViewModel` which has a `FooDomainModel` struct that has *only* what it needs to support the View Model's purpose and nothing else. This struct can be re-requested or altered and it won't break other parts of the app.
2. A set of structs that makes up the Data Model; the actual state of the data in a format that makes it easy to talk to the API, or local database, or whatever. While these *can* be nested into one big giant huge struct tree, they don't *have* to be because the API operations can then be things like `delete(nodeId:UUID fromParentId: UUID)`
3. A Repository that handles all the interactions with the data source and is the only entity to interact with the Data Model structs. The Repository can have a singleton and be injected via a protocol tailored to the ViewModel's specific needs so that even though it has a bunch of funcs on it, the ViewModel only has access to the handful of funcs that it needs.


From [MongoDB Schema Design Best Practices](https://www.mongodb.com/developer/products/mongodb/mongodb-schema-design-best-practices/#:~:text=Rule%204%3A%20Arrays%20should%20not,compelling%20reason%20not%20to%20embed):

Rule 4: Arrays should not grow without bound. If there are more than a couple of hundred documents on the "many" side, don't embed them; if there are more than a few thousand documents on the "many" side, don't use an array of ObjectID references. High-cardinality arrays are a compelling reason not to embed.
