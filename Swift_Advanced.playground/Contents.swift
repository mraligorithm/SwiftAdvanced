//: Playground - noun: a place where people can play
import UIKit

// Built in Collections
"""
Arrays and Mutability
Arrays are the most common collections in Swift. An array is an ordered container of elements that
all have the same type, with random access to each element. As an example, to create an array of
numbers, we can write the following:
"""
let fibs = [0, 1, 1, 2, 3, 5]
"""
If we try to modify the array defined above (by using append(_:), for example), we get a compile
error. This is because the array is defined as a constant, using let. In many cases, this is exactly
the right thing to do; it prevents us from accidentally changing the array.
If we want the array to be a variable, we have to define it using var:
"""
var mutableFibs = [0, 1, 1, 2, 3, 5]



// Now we can easily append a single element or a qsequence of elelements:

