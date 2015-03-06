Credit card rainbow table
=========================

Simple example to demonstrate how relatively easy it is to create a
rainbow table for credit card hashes. This since only a few IIN/BINs
are relevant. Here we focus on a single IIN and setup an in-memory
table with a million SHA256 hashes of Luhn checked cards in 1.5 min on
a MacBook Pro.


Example
-------

    > M = rb:init(1000 * 1000 * 10).
    N = 4552620010000000
    N = 4552620009000000
    N = 4552620008000000
    N = 4552620007000000
    N = 4552620006000000
    N = 4552620005000000
    N = 4552620004000000
    N = 4552620003000000
    N = 4552620002000000
    N = 4552620001000000
    Time to setup lookup table: 91.567563s
    Size of table 1000000.

    > H = rb:hash("4552620009999995").
    <<84,25,124,160,66,168,253,169,138,158,159,240,254,108,72,
      161,68,124,27,248,202,42,213,85,54,66,53,180,34,...>>

    > rb:lookup(H, M).
    "4552620009999995"

Copyright (c) 2015 Ulf Leopold.
