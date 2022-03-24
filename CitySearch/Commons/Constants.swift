//
//  Constants.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation

struct Constants {
    // MARK: API Key
    struct API {
        static var citiesFileName: String {
            #if DEBUG
                return "cities"
            #elseif TEST
                return "cities-Test"
            #elseif RELEASE
                return "cities"
            #else
                return "config flag not found"
            #endif
        }
        static let cities = Bundle.main.url(forResource: citiesFileName, withExtension: "json")
    }
    
}
