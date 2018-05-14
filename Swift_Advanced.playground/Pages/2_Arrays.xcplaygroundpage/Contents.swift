//: [Previous](@previous)
import Foundation
// Transforming Arrays
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
→ filter — should an element be included?
→ reduce — how to fold an element in to an aggregate value
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

//: [Next](@next)
