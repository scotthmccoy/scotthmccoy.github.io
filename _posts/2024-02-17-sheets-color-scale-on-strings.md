Google sheets does a nice job of applying color to ranges of numbers, but not such a great job with strings.

# A Number Code
This method involves simply adding a color name that conditional formatting can search for:
<img width="641" alt="image" src="https://github.com/scotthmccoy/scotthmccoy.github.io/assets/1480870/50d7700f-313f-422c-bd41-69e3f870833b">


# A Primitive Hash
On the alfheim Transaction History doc, I came up with this, which makes a primitive hash of the string and uses conditional formatting to apply a color:

![Transaction History](https://github.com/scotthmccoy/scotthmccoy.github.io/assets/1480870/c21ff91c-ad52-4b9f-aee8-3da7b70a4f70)

The way it works is by converting the first two letters to a numerical code, adding them up, and modding them by 8:

```
=1 = MOD(CODE($G2) + CODE(MID($G2,2,1)), 8)
```

# A Proper Hash

Sadly, **you can't use user-defined scripts in conditional formatting**, so using this method requires making an additional column that generates the hash. I suppose you could make a third that concatenates the source column to the hash and then do simply conditional formatting based on that.

Add this to Extensions, AppScript:

```
function numericHash (input, mod) {

  if (input == null || mod == null) {
    return 0
  }

  // MD5 the input to get a unique hash
  return Utilities.computeDigest(
    Utilities.DigestAlgorithm.MD5, 
    input
  )
  // Some of the bytes will have negative values, convert them all to positive
  .map(
    (byte) => (
      Math.abs(Number(byte))
    )
  )
  // Add them all up
  .reduce((a, b) => a + b)
  // Apply mod
  % mod
  // Add 1
  + 1;
}

console.log("Runing numericHash: " + numericHash("Fart", 100))
```
