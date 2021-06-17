import GameplayKit
import UIKit

let int1 = Int.random(in: 0...10)
let int2 = Int.random(in: 0..<10)
let double1 = Double.random(in: 1000...10000)
let float1 = Float.random(in: -100...100)

// GKLinearCongruentialRandomSource: has high performance but the lowest randomness
print(GKRandomSource.sharedRandom().nextInt())
print(GKRandomSource.sharedRandom().nextInt(upperBound: 6))

// GKARC4RandomSource: has good performance and good randomness – in the words of Apple, "it's going to be your Goldilocks random source."
let arc4 = GKARC4RandomSource()
arc4.nextInt(upperBound: 20)
arc4.dropValues(1024)

// GKMersenneTwisterRandomSource: has high randomness but the lowest performance
let mersenne = GKMersenneTwisterRandomSource()
mersenne.nextInt(upperBound: 20)


let d6 = GKRandomDistribution.d6()
d6.nextInt()

let d20 = GKRandomDistribution.d20()
d20.nextInt()

let crazy = GKRandomDistribution(lowestValue: 1, highestValue: 11539)
crazy.nextInt()


let distribution = GKRandomDistribution(lowestValue: 10, highestValue: 20)
print(distribution)

let rand = GKMersenneTwisterRandomSource()
let distribution2 = GKRandomDistribution(randomSource: rand, lowestValue: 10, highestValue: 20)
print(distribution2.nextInt())


let shuffled = GKShuffledDistribution.d6()
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())
