//
//  Order.swift
//  CupcakeCorner
//
//  Created by Mathias on 7/16/23.
//

// @TODO
/*
 * See if you can convert our data model from a class to a struct,
 * then create an ObservableObject class wrapper around it that gets passed around.
 * This will result in your class having one @Published property, which is the data struct inside it,
 * and should make supporting Codable on the struct much easier.
 */



import SwiftUI

//struct OrderStruct {
//    var type = 0
//    var quantity = 3
//    var extraFrosting = false
//    var addSprinkles = false
//    var name = ""
//    var streetAddress = ""
//    var city = ""
//    var zip = ""
//    var specialRequestEnabled = false {
//        didSet {
//            if specialRequestEnabled == false {
//                extraFrosting = false
//                addSprinkles = false
//            }
//        }
//    }
//}
//
//class OrderStructClass: ObservableObject  {
//    @Published var orderStruct: OrderStruct
//
//}

class Order: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    static let types = ["Vanilla", "Stawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        !(name.trimmingCharacters(in: .whitespaces).isEmpty
          || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty
          || city.trimmingCharacters(in: .whitespaces).isEmpty
          || zip.trimmingCharacters(in: .whitespaces).isEmpty)
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1 per cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50 per cake for sprinkles!
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    init() { }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
}
