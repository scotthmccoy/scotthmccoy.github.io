
From [here](https://medium.com/@jllnmercier/swift-unknown-and-frozen-attributes-8d4eea52d5ac):

* An enum marked as `@nonfrozen` may have new values added, and a default `@unknown` case must be added to switches to handle possible future values.
* An enum marked as `@frozen` will never have new values added even in future iOS versions.

Sadly these keywords can't really be used by a swift dev:
> Only the standard library, Swift overlays for Apple frameworks, and C and Objective-C code can declare nonfrozen enumerations.





