module Race
  KILOMETERS_TO_MILES = 0.621371192

  FIVE_K = 5 * KILOMETERS_TO_MILES
  TEN_K = 10 * KILOMETERS_TO_MILES

  HALF_MARATHON = 13.109375
  MARATHON = 26.21875

  RACE_TYPES = {
     FIVE_K => '5k',
     TEN_K => '10k',
     HALF_MARATHON => 'Half-Marathon',
     MARATHON => 'Marathon',
  }
end

module MileageLists
  FIVE_K = [
      [ 0, 3, 3, 2, 0, 5, 2, ],
      [ 0, 3, 3, 2, 0, 5, 2, ],
      [ 0, 3, 3, 3, 0, 5, 3, ],
      [ 0, 3, 3, 3, 3, 0, 6, ],

      [ 0, 3, 3, 3, 0, 6, 3, ],
      [ 0, 4, 4, 3, 0, 6, 3, ],
      [ 0, 4, 4, 3, 0, 6, 3, ],
      [ 0, 4, 3, 4, 3, 0, 4, ],

      [ 0, 3, 4, 3, 0, 5, 3, ],
      [ 0, 3, 3, 2, 3, 0, 4, ],
      [ 0, 3, 4, 2, 0, 4, 2, ],
      [ 0, 3, 3, 2, 2, 0, 3, ],
    ]

    TEN_K = [
      [ 0, 3, 4, 2, 0, 6, 3,  ],
      [ 0, 3, 4, 2, 0, 8, 3,  ],
      [ 0, 3, 4, 2, 2, 8, 2,  ],
      [ 0, 3, 4, 3, 2, 0, 10, ],

      [ 0, 4, 4, 4, 0, 8, 4, ],
      [ 0, 4, 4, 4, 4, 3, 5, ],
      [ 0, 4, 4, 4, 0, 8, 4, ],
      [ 0, 4, 4, 4, 3, 0, 7, ],

      [ 0, 4, 4, 3, 0, 8, 2, ],
      [ 0, 3, 5, 4, 3, 0, 5, ],
      [ 0, 4, 4, 3, 0, 6, 3, ],
      [ 0, 3, 4, 3, 2, 0, 6, ],
    ]

    HALF_MARATHON = [
      [ 0, 2, 4, 2, 0,  8, 2, ],
      [ 0, 2, 4, 2, 0, 10, 2, ],
      [ 0, 2, 5, 2, 0, 12, 3, ],
      [ 0, 4, 5, 4, 4, 0, 10, ],

      [ 0, 5, 5, 5, 0, 13, 2, ],
      [ 0, 5, 5, 5, 0, 13, 2, ],
      [ 0, 5, 5, 4, 4, 2,  6, ],
      [ 0, 5, 5, 5, 0, 13, 2, ],

      [ 0, 5, 5, 4, 4, 0,  8, ],
      [ 0, 4, 5, 4, 0, 10, 2, ],
      [ 0, 4, 5, 4, 0, 8,  2, ],
      [ 0, 3, 4, 2, 2, 0, 13, ],
    ]

    MARATHON = [
      [ 0, 3, 4, 4, 0, 8,  3, ],
      [ 0, 4, 4, 4, 0, 10, 3, ],
      [ 0, 3, 5, 3, 0, 13, 3, ],
      [ 0, 6, 5, 4, 4, 3,  8, ],

      [ 0, 4, 5, 5, 0, 15, 3, ],
      [ 0, 6, 5, 6, 0, 12, 6, ],
      [ 0, 5, 5, 4, 0, 18, 3, ],
      [ 0, 6, 6, 6, 4, 0, 13, ],

      [ 0, 5, 6, 6, 0, 20, 3, ],
      [ 0, 6, 5, 5, 5, 3,  6, ],
      [ 0, 6, 6, 5, 0, 20, 3, ],
      [ 0, 6, 6, 6, 4, 0, 13, ],

      [ 0, 5, 6, 6, 0, 20, 3, ],
      [ 0, 6, 6, 6, 6, 0,  8, ],
      [ 0, 5, 5, 4, 0, 8,  3, ],
      [ 0, 4, 4, 3, 0, 2, 26, ],
    ]
end

module SpeedTrainingLists
  FIVE_K = <<END.split("\n")
modified fartlek
3-4 x long-hill repeats
2-mile tempo run
3-4 x half-mile, 5k pace
4-5 x short-hill repeats
2-3 x mile, 5k fast pace
3-4 x half-mile, fast pace
4-5 x quarter-mile, fast pace
2-3 x mile, 5k-fast pace
4-5 x quarter-mile, fast pace
cut down: mile, 3/4, 1/2, 1/4; fast-hard pace
strides
END

  TEN_K = <<END.split("\n")
modified fartlek
3-4 x long-hill repeats
2-mile tempo run
4-6 x half-mile, 5k-10k pace
4-5 x short-hill repeats
3-mile tempo run
2-3 x mile, 5k-fast pace
4-5 x quarter-mile, fast pace
3-4 x half-mile, fast pace
tempo intervals, 2 x 1.5 miles
2-3 x mile, at 5k-fast pace
strides
END

  HALF_MARATHON = <<END.split("\n")
2-mile tempo run
3-4 x long-hill repeats
tempo intervals, 2 x 1.5 miles
2-4 x mile, 5k-10k pace
3-mile tempo run
4-6 x half-mile, 5k-10k pace
1-2 x 1.5 miles, 5k-10k pace
2-3 x mile, 5k-fast pace
tempo run, 4 miles, half-marathon pace
3-4 x half-mile, fast pace
2-3 x mile, 5k to fast pace
tempo intervals, 6 x 1/2 mile
END

  MARATHON = <<END.split("\n")
2-mile tempo run
3-4 x long-hill repeats
2-4 x mile, 5k-10k pace
3-4 x long-hill repeats
fartlek
4-6 x half-mile, 5k-10k pace
2-3 x mile, 5k-fast pace
tempo intervals, 2 x 1.5 miles

1-2 x 1.5 miles, 5k-10k pace
4-mile tempo run, half-marathon pace
tempo intervals, 2 x 2 miles

3-4 x half-mile, fast pace
2-3 x mile, 5k-fast pace
3 miles at marathon pace
END
end
