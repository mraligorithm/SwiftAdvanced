//: Playground - noun: a place where people can play
import UIKit

// Built in Collections
"""
Arrays and Mutability
Arrays are the most common collections in Swift. An array is an ordered container of elements that
all have the same type, with random access to each element. As an example, to create an array of
numbers, we can write the following:
"""
// The Fibanacci numbers
let fibs = [0, 1, 1, 2, 3, 5]
"""
If we try to modify the array defined above (by using append(_:), for example), we get a compile
error. This is because the array is defined as a constant, using let. In many cases, this is exactly
the right thing to do; it prevents us from accidentally changing the array.
If we want the array to be a variable, we have to define it using var:
"""
var mutableFibs = [0, 1, 1, 2, 3, 5]
// Now with var declared we can append a single element or sequence of elements
mutableFibs.append(8)
mutableFibs.append(contentsOf: [13, 21])
print(mutableFibs)

"""
Arrays, like all collection types in the standard library,
have value semantics. When you assign an existing array to
another variable, the array contents are copied over.
"""
// For example, in the following code snippet, x is never modified:
var x = [1,2,3]
var y = x
y.append(4)
y // [1, 2, 3, 4]
x // [1, 2, 3]
"""
NSArray has no mutating methods — to mutate an array,
you need an NSMutableArray. But just because you have
a non-mutating NSArray reference does not mean the
array can’t be mutated underneath you:
"""
let a = NSMutableArray(array: [1,2,3]) // I don't want to be able to mutate b
let b: NSArray = a
// But it can still be mutated - via a
a.insert(4, at: 3)
b // ( 1, 2, 3, 4 )
"The correct way to write this is to manually create a copy upon assignment:"
let c = NSMutableArray(array: [1,2,3]) // I don't want to be able to mutate d
let d = c.copy() as! NSArray
c.insert(4, at: 3)
d // ( 1, 2, 3 )

"""
Making so many copies could be a performance problem,
but in practice, all collection types in the Swift standard
library are implemented using a technique called copy-on-write,
which makes sure the data is only copied when necessary.
"""
// Arrays and Optionals
"""
→ Want to iterate over the array?
    for x in array
→ Want to iterate overall but the first element of an array?
    for x in array.dropFirst()
→ Want to iterate overall but the last 5 elements?
    for x in array.dropLast(5)
→ Want to number all the elements in an array?
    for (num, element) in collection.enumerated()
→ Want to find the location of a specific element?
    if let idx = array.index { someMatchingLogic($0) }
→ Want to transform all the elements in anarray?
    array.map { someTransformation($0) }
→ Want to fetch only the elements match in g a specific criterion?
    array.filter { someCriteria($0) }
"""

// Array Types = Slices
"""
In addition to accessing a single element of an array by
subscript (e.g. fibs[0]), we can also access a range of elements by subscript.
For example, to get all but the first element of an array, we can do the following:
"""
let slice = fibs[1..<fibs.endIndex]
slice // [1, 1, 2, 3, 5]
type(of: slice) // ArraySlice<Int>
//: [Next](@next)









