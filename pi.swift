#! /usr/bin/env swift

import Foundation

typealias UIntType = UInt64

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

let start = DispatchTime.now()
var count = 0
let max = 100_000_000
for _ in (1 ... max) {
    let n1 = generator.randomWord()
    let n2 = generator.randomWord()
    if gcd(n1, n2) == 1 {
        count += 1
    }
    // print ("\(gcd(n1, n2))")
}
var p = Double(count)/Double(max)
var pi = sqrt(6.0/p)
let stop = DispatchTime.now()
print("my pi ~ \(pi)")
print("Double.pi = \(Double.pi)")
let nanoTime = stop.uptimeNanoseconds - start.uptimeNanoseconds
let timeInterval = Double(nanoTime) / 1_000_000_000
print("time: \(timeInterval) seconds")

