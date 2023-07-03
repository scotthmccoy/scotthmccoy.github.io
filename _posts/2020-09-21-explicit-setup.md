
If possible, accessing a singleton for the first time shouldn't automatically trigger its setup routine. This allows the singleton to be much more easily partially-mocked.
