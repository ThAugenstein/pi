#! /usr/bin/env swift

import Foundation

func gcd(_ a:UInt32, _ b: UInt32) -> UInt32 {
    guard b != 0 else { return a }
    return gcd(b, a % b)
}

let start = DispatchTime.now()
var count = 0
let max = 1_000_000_000
for _ in (1 ... max) {
    let n1 = arc4random()
    let n2 = arc4random()
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

