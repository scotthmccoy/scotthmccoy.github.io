

From [this wiki page]():

Cardinality doesn't mean "the count of the result set", despite that being implied by the dictionary definition of the word. It means "the type of the relationship between two entities", which can be any of the usual:



|Relationship|Example|Left|Right|Narrative|
|------------|-------|----|-----|---------|
|One-to-one|person ←→ birth certificate|1|1|A person must have its own birth certificate|
|One-to-one (optional on one side)|person ←→ driving license|1|0..1 or ?|A person may have a driving license|
|Many-to-one|person ←→ birthplace|1..* or +|1|Many people can be born at the same place|
|Many-to-many (optional on both sides)|person ←→ book|0..* or *|0..* or *|A person may own books|
|One-to-many|order ←→ line item|1|1..* or +|An order contains at least one item|
|Many-to-many|course ←→ student|1..* or +|1..* or +|Students follow various courses|
