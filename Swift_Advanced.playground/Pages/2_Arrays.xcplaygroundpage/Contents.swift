//: [Previous](@previous)
import Foundation
// Transforming Arrays
"""
Using map, filter or reduce to operate on Swift collection types
such as Array or Dictionary is something that can take getting used to.
Unless you have experience with functional languages your instinct may be
to reach for the more familiar for-in loop. With that in mind
here is my guide to using map, filter, reduce (and flatMap and compactMap).
"""

// Map
"It’s common to need to perform a transformation on every value in an array"
// The Fibanacci numbers
let fibs = [0, 1, 1, 2, 3, 5]
var squared: [Int] = []
for f in fibs {
    squared.append(f)
}
print(squared) // [0, 1, 1, 4, 9, 25]
"Here’s the exact same operation, using map:"
let squares = fibs.map { fib in fib * fib }
print(squares) // [0, 1, 1, 4, 9, 25]

let milesToPoint = ["point1":120.0,"point2":50.0,"point3":70.0]
let kmToPoint = milesToPoint.map { name,miles in miles * 1.6093 }

"""
This version has three main advantages. It’s shorter, of course.
There’s also less room for error. But more importantly, it’s clearer.
All the clutter has been removed. Once you’re used to seeing and
using map everywhere, it acts as a signal — you see map, and you know
immediately what’s happening: a function is going to be applied
to every element, returning a new array of the transformed elements.
"""
// Creating the our own map method
"func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]"
extension Array {
    func ourMap<T>(_ transform: (Element) -> T) -> [T] { //Element is the generic placeholder for whatever type the array contains
        var back: [T] = [] // T is a new placeholder that can represent the result of the element transformation
        back.reserveCapacity(count)
        for i in self {
            back.append(transform(i)) // The concrete type T of the transformed elements is defined by the return type of the transform function the caller passes to map
        }
        return back
    }
}

"""
This pattern of parameterizing behavior is found throughout
the standard library. There are more than a dozen separate
functions that take a closure that allows the caller to customize the key step:

→ map and flatMap — how to transform an element
FlatMap on a sequence with a closure that returns a sequence:
Sequence.flatMap<S>(_ transform: (Element) -> S)
-> [S.Element] where S : Sequence
"""
let results = [[5,2,7], [4,8], [9,1,3]]
let allResults = results.flatMap { $0 }
// [5, 2, 7, 4, 8, 9, 1, 3]
let passMarks = results.flatMap { $0.filter { $0 > 5} }
// [7, 8, 9]

// FlatMap
let suits = ["♠", "♥", "♣", "♦"]
let ranks = ["J","Q","K","A"]
let result = suits.flatMap { suit in ranks.map { rank in
    (suit, rank) }
}
"""
→ filter — should an element be included?
    Filter
    Use filter to loop over a collection and return an Array containing
    only those elements that match an include condition.
"""
let digits = [1,4,10,15]
let even = digits.filter { $0 % 2 == 0 }
// [4, 10]
"""
→ reduce — how to fold an element in to an aggregate value
    Reduce
    Use reduce to combine all items in a collection to create a single new value.
"""
let items = [2.0,4.0,5.0,7.0]
let total = items.reduce(10.0, +)
// 28.0
// Flatmap on Optional
let input: Int? = Int("8")
let passMark: Int? = input.flatMap { $0 > 5 ? $0 : nil }
// 8
"""
-> Using CompactMap on a sequence with a closure that returns an optional
"""
let keys: [String?] = ["Tom", nil, "Peter", nil, "Harry"]
let validNames = keys.compactMap { $0 }
validNames
// ["Tom", "Peter", "Harry"]

let counts = keys.compactMap { $0?.count }
counts
// [3, 5, 5]
"""
Chaining
  - You can chain methods. For example to sum only those numbers
    greater than or equal to seven we can first filter and then reduce:
"""
let marks = [4,5,8,2,9,7]
let totalPass = marks.filter{$0 >= 7}.reduce(0, +)
// 24
"""
→ sequence — what should the next element of the sequence be?
→ forEach — what side effect to perform with an element
→ sort,lexicographicallyPrecedes, and partition — in what order should two elements come?
→ index, first, and contains — does this element match?
→ min and max — which is the min/max of two elements?
→ elementsEqual and starts — are two elements equivalent?
→ split — is this element as eparator?
→ accumulate — combine elements in to an array of running values (like reduce, but returning an array of each interim combination)
→ all(matching:) and none(matching:) — test if all or no elements in asequence match a criterion (can be built with contains, with some carefully placed negation)
→ count(where:) — count the number of elements that match (similar to filter, but without constructing an array)
→ indices(where:) — return a list of indices matching a criteria (similar to index(where:), but doesn’t stop on the first one)
→ prefix(while:) — filter elements while a predicate returns true, then drop the rest (similar to filter, but with an early exit, and useful for infinite or lazily computed sequences)
→ drop(while:) — drop elements until the predicate ceases to be true, and then return the rest (similar to prefix(while:), but this returns the inverse)
"""
// If you tend to write something like this all the time
let names = ["Paula", "Elena", "Zoe"]
var lastNameEndingInA: String?
for name in names.reversed() where name.hasSuffix("a") {
    lastNameEndingInA = name
    break
}
lastNameEndingInA // Optional("Elena")

// ---> Consider writing this
extension Sequence {
    func last(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in reversed() where predicate(element) { return element
        }
        return nil
    }
}
// This then allows you to replace your for loop with the following:
 let match = names.last { $0.hasSuffix("a") }
 match // Optional("Elena")
// we can also use -> guard let match = someSequence.last(where: { $0.passesTest() }) else { return }

//: [Next](@next)
