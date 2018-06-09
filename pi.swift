#! /usr/bin/env swift

import Foundation

typealias UIntType = UInt64

// Start a timer that returns seconds since start as Double
func startTimer() -> () -> Double {
    let start = DispatchTime.now()
    let secondsSinceStart: () -> Double = {
        let stop = DispatchTime.now()
        let interval = stop.uptimeNanoseconds - start.uptimeNanoseconds
        return Double(interval) / 1_000_000_000
    }
    return secondsSinceStart
}

// Xoroshiro number generator as seen on 'Cocoa with love' web site
struct RandomWordGenerator {
    
    var state: (UIntType, UIntType) = (0, 0)

    init() {
        state.0 = UIntType(arc4random())
        state.1 = UIntType(arc4random())
    }

    mutating func randomWord() -> UIntType {

        let (l, k0, k1, k2): (UIntType,UIntType,UIntType,UIntType) = (64, 55, 14, 36)

        let result = state.0 &+ state.1
        let x = state.0 ^ state.1
        state.0 = ((state.0 << k0) | (state.0 >> (l - k0))) ^ x ^ (x << k1)
        state.1 = (x << k2) | (x >> (l - k2))
        return result
    }
}

func gcd(_ a:UIntType, _ b: UIntType) -> UIntType {
    guard b != 0 else { return a }
    return gcd(b, a % b)
}

var generator = RandomWordGenerator()

let timer = startTimer()
var count = 0
let iterations = 10_000_000
for _ in (1 ... iterations) {
    let n1 = generator.randomWord()
    let n2 = generator.randomWord()
    if gcd(n1, n2) == 1 {
        count += 1
    }
    // print ("\(gcd(n1, n2))")
}
var p = Double(count)/Double(iterations)
var pi = sqrt(6.0/p)
let seconds = timer()
print("my pi ~ \(pi)")
print("Double.pi = \(Double.pi)")
print("time: \(seconds) seconds")

