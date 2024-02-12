jq can be used to pretty-print json:
```
scottmccoy@Scotts-MBP-M1 scootys-armor-swap % cat info.json | jq           
{
  "name": "scootys-armor-swap",
  "version": "1.2.1",
  "title": "Scooty's Armor Swap",
  "author": "Scooty McDaniels",
  "factorio_version": "1.1",
  "dependencies": [
    "base >= 1.1"
  ],
  "description": "Adds a key binding (default: the \"\\\" key) that equips the next armor in your inventory and sets your player color to the color that was last used with that armor. Rapidly cycle among color-coded armors specialized for different purposes!"
}
```


Or to fetch values:
```
scottmccoy@Scotts-MBP-M1 scootys-armor-swap % cat info.json | jq '.version'        
"1.2.1"
```

Or to change values:
```
scottmccoy@Scotts-MBP-M1 scootys-armor-swap % cat info.json | jq '.version = "foo"'
{
  "name": "scootys-armor-swap",
  "version": "foo",
  "title": "Scooty's Armor Swap",
  "author": "Scooty McDaniels",
  "factorio_version": "1.1",
  "dependencies": [
    "base >= 1.1"
  ],
  "description": "Adds a key binding (default: the \"\\\" key) that equips the next armor in your inventory and sets your player color to the color that was last used with that armor. Rapidly cycle among color-coded armors specialized for different purposes!"
}
```

While jq is *very powerful*, I'd place the readability of its syntax somewhere around perl-level. I reccommend using jq to fetch data and another language (for example, command-line swift) to walk arrays, transform data, and then, if neccessary use jq again to write it back to the json file.
