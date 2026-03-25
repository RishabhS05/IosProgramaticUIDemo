//
//  readme.swift
//  ProjectWithStoryboard
//  Created by Rishabh Shrivastava on 21/07/24.
//
import Foundation
// struct vs class

/**
 Structures
 - struct is value type.
 - structures comfoms to protocol provides std  functionality.
 - Inheritance is not allowed with other structure, class and enum.
 */
protocol BaseUser {
    func firstName() -> String
}

struct User2 : BaseUser, Equatable {
    var name : String
    var age : Int
    var x : Character
    
    func firstName() -> String {
        return name
    }
}


func call1(){
    let rishabh = User2(name : "Rishabh", age : 32, x: "R")
    var anuj = rishabh
    anuj.age = 23
    print("rishabh \(rishabh.age) \(rishabh.x)")
    print("anuj \(anuj.age) \(anuj.x)")
    print("\(anuj == rishabh)")
}

/*
 Classes
 - classes are refrence type
 - Strong reference in heap memory by default.
 - inherit other class and protocols.
 */
class Base {
    let error : String?
    let message : String?
    init(error: String?, message: String?) {
        self.error = error
        self.message = message
    }
}

class Response : Base {
    override init(error: String?, message: String?) {
        super.init(error: error, message: message)
    }
}

/**
 Protocols
 - contains declarations of methods
 - also contains variable with getter/setters
 - can be inherited by class, structure and enums
 - extended by other protocols
 */
protocol PhonePro{
    var name : String { get set }
    var company : String  { get set }
    // init cannot have bodies
    init()
    init(name :String , company : String)
  
    func calculateChargingTime(batteryPower  : Int)-> Double
    
}
//if want to have the definition of the function use extension of it
extension PhonePro {
    func calculateProcessingThreads(coreCount : Int ) -> Double {
        return Double(coreCount) * 5.5
    }
}

class Micromax : PhonePro{
   
    var name: String
    
    var company: String
    required init() {
        self.name = "name"
        self.company = "company"
       }
    required init(name: String, company: String) {
        self.company = company
        self.name = name
    }
    
    func calculateChargingTime(batteryPower: Int) -> Double {
       return  Double(batteryPower) / 10
    }
    deinit{
        
    }
}

func call2(){
    var micromax = Micromax(name: "micromax v1", company: "micromax")
    print(micromax.company)
}


