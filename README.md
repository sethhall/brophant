Phant.io for Bro
================

Phant is for consuming and storing data and Bro produces a lot of data.
Together they make a good pair.

Usage
-----

Create a stream at the public SparkFun phant server:
	https://data.sparkfun.com/streams/make

Take your public and private keys and use them in a script.  Refer
to the example in test/example.bro to see how to use this module.

This module is very early still and I'm not making any promises 
about the stability of the API.  In fact, I can almost promise
that I'll break it!

TODO
----

 - Support rate limiting through the metadata returned by the server.
   - X-Rate-Limit-Remaining
   - X-Rate-Limit-Limit
   - X-Rate-Limit-Reset
 - Add cluster support.  Decide ahead of time which node in a 
   cluster will actually be submitting data to Phant.
 - HTML encode data being submitted (this can cause failures!).