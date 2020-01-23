import UIKit

//inout functions allows us to change variables outside the scope of the  function
//in place means or function should be a inout function
func swapTwoInts(int1: inout Int, int2: inout Int){
    let temp = int1 //we saved the value of int1 to avoid overriding
    int1 = int2
    int2 = temp
    
}
var num1 = 4
var num2 = 13

print ("values of ints before swap \(num1), \(num2)")

//& sign denotes that the function has a refrence of the two variables, and the ability to change the variable, it came because we marked it inout and has direct refrence in the function
//

swapTwoInts(int1: &num1, int2: &num2)

print ("values of ints after swap \(num1), \(num2)")

//With generics we can write a function that would take in any type


//generic function
//T- for type, it could be anything <Element>
//can have one be a generic and one can be specified
//two types need to be the same here
func swapTwoValues<T>(value1: inout T, value2: inout T){
   let temp = value1
    value1 = value2
    value2 = temp
}

var string1 = "Thdnkdk"
var string2 = "OK"
print ("values of ints before swap \(string1), \(string2)")

swapTwoValues(value1: &string1, value2: &string2)

print ("values of ints after swap \(string1), \(string2)")

//with type Any, it is not type safe, tyou can combine different types together,


// implement a generic stack using an array

struct IntStack{
    
    private var elements = [Int]()
        
    
}

//generic type
//class refrence type
//struct, have to mark mutating since changing the property
struct Stack<T> {
    
    private var elements = [T]()//works with any type
  
    public var peak: T?{
        return elements.last
    }
 
    
 public mutating func push(item: T){
        elements.append(item)
    }
    
    public mutating func pop() ->T?{
        guard !elements.isEmpty else {
            return nil
        }
        return elements.removeLast()
        
    }
}

var cohorts = Stack<Double>()
cohorts.push(item: 1.0)
cohorts.push(item: 2.0)
cohorts.push(item: 3.0)
cohorts.push(item: 4.0)
cohorts.push(item: 5.0)
cohorts.push(item: 6.3)

print (cohorts.peak as Any)

cohorts.pop()
cohorts.pop()

print(cohorts.peak as Any)

struct Fellow{
    let name: String
    let language: String
}

let ameni = Fellow(name: "Ameni", language: "English")
