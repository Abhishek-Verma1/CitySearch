//
//  City.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation

struct City: Codable {
    
    var id: Int?
    var country: String?
    var name: String?
    var coord: Coordinate?

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case country = "country"
        case name = "name"
        case coord = "coord"
    }

}
