I needed a solution to replace groups of four spaces with a tab, but only on the beginning of a line. This worked, but I'm not sure how:

Replace
`(\G|^) {4}`

With
`\t`

From https://regex101.com/r/fR3gF7/2, the `\G` Apparently means "asserts position at the end of the previous match or the start of the string for the first match".
