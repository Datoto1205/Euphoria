
//  Advanced Practice of Swift.playground
//
//  Created by Li Cheng-En on 2018.
//  Copyright © 2018 Li Cheng-En. All rights reserved.
//
//  -------------------------------<Outline>-------------------------------
//  Practice of Declaration of Function & Parameter                <Row 22>
//  Practice of Declaration of Function & Return                   <Row 33>
//  Practice of Declaration of Function & Change of Type of Data   <Row 50>
//  Array & Function with Parameter of Array                       <Row 61>
//  For-loop                                                       <Row 79>
//  Class                                                         <Row 100>
//  Struct                                                        <Row 115>
//  Creation of Random Number                                     <Row 124>

import Foundation



// Practice of Declaration of Function & Parameter
func printString(theStringIWantToType a: String) {
    print("The first string I want to print is \"" + a + "\".")
}

printString(theStringIWantToType: "hello world")
// The external of parameter (here is "theStringIWantToType") is optional, but the internal name (here is "a") is essential.
// External name could help the user of the function know the definition of each parameter.



// Practice of Declaration of Function & Return
func multiplySeriesOfNumber(from a: Int, To b: Int) -> Int {
    var result = 1
    
    for i in a...b {
        result = result * i
    }
    
    return result
}

var resultNumber = multiplySeriesOfNumber(from: 1, To: 5)
print("If we multiply all the number from 1 to 5, we could get " + String(resultNumber) + ".")
// If I want to assign the data type with integer, I need to type "Int" instead of "int".



// Practice of Declaration of Function & Change of Type of Data
func changeTheType(Double a: Double, String b: String) {
    print(String(a) + " is my lucky number.")
    print(Int(b)!+5)
}

changeTheType(Double: 7, String: "20")
// I could use "idealType(theVariableIWantToChangeTheType)" function to change the type of variable. However, if I want to change a variable with char type, I need to add "!" to avoid the problem of null.



// Array & Function with Parameter of Array
var array = [1, 2, 3, 4, 5]
array[4] = 6
print("\n" + String(array.count + array[3]))

func multiplyElementsInTheArray(originalArray: [Int]) -> Int {
    var result = 1
    for i in 0..<originalArray.count {
        result = result * originalArray[i]
    }
    return result
}

print(multiplyElementsInTheArray(originalArray: array))
// I need to add "[]" to assign the property of array to a variable.



// For-loop
func ninetyNineMultiplicationTable(From a: Int, To b: Int) {
    print("\n\t\t\t\t\t   Ninety-nine Multiplication Table")
    
    for i in a...b {
        for j in (a + 1)...b {
            if j%9 == 0 {
                print(String(j) + " * " + String(i) + " = " + String(i*j))
            } else {
                print(String(j) + " * " + String(i) + " = " + String(i*j) + "\t", terminator: " ")
            }
            
        }
    }
}

ninetyNineMultiplicationTable(From: 1, To: 9)
// If I use print() function in swift, the system would add a "\n" to the end of our result. If we did not want to change the row each time, we need to assign a space terminator in the end of our code.



// Class
class specialValueClass {
    var amazingValue = 5
    func calculationOfSpecialValue(initialValue: Double) -> Double {
        return sin(initialValue + 5)
    }
}

var instantiateTheClass = specialValueClass()
print("\n" + String(instantiateTheClass.calculationOfSpecialValue(initialValue: 3.7)))
print(instantiateTheClass.amazingValue)
// If I want to extract a function or a variable in another class, I need to instantiate that class first. Afterward, I could use "." to extract what I want.

var anotherSpecialValueClass = instantiateTheClass
anotherSpecialValueClass.amazingValue += 5
print(instantiateTheClass.amazingValue)
print(anotherSpecialValueClass.amazingValue)
// Since class is reference type, change the value of "proxy" variable would influence the value of original variable.

class theOtherSpecialValueClass: specialValueClass {
    override func calculationOfSpecialValue(initialValue: Double) -> Double {
        let finalValue = initialValue + 5
        return finalValue
    }
}
let theOtherSpecialValueClassObj = theOtherSpecialValueClass()
print(theOtherSpecialValueClassObj.calculationOfSpecialValue(initialValue: 12))



// Struct
struct circle {
    var radius = 2
}

var instantiateTheStruct = circle()
print(instantiateTheStruct.radius)

var anotherCircleStruct = instantiateTheStruct
anotherCircleStruct.radius += 5
print(instantiateTheStruct.radius)
print(anotherCircleStruct.radius)
// Since struct is value type, change the value of "proxy" variable would not influence the value of original variable.



// Creation of Random Number
print("\n" + String(arc4random_uniform(100)))



// Closure
let firstClosure = {() -> () in
    print("Hello, closure!")
}

func equivalentFirstClosure() -> () {
    print("Hello, closure!")
}

print("\n\n")
firstClosure()
equivalentFirstClosure()
// Closure is just like a function without name, it could not be called alone, it only could be assign to a variable, or be used as a parameter of a function.
// The codes above shows how to use closure to do some works.


let secondClosure = {(herAge: Int) -> Int in
    return herAge + 5
}

secondClosure(8)
// The codes above shows how to use closure to return a variable.


func closureFunction(year: Int, closure: () -> String) {
    print("I have learned Swift for \(year) years, but I still did not knwo what is \(closure()). ")
}

closureFunction(year: 1, closure: {() -> String in
    return "closure"
})


func add(One: Int, twoAndThree: (Int, Int) -> Int) {
    print(One + twoAndThree(13, 18))
}

add(One: 1, twoAndThree: {(Two: Int, Three: Int) -> Int in
    return Two + Three
})
// The codes above shows how to use closure as a parameter of a function.

