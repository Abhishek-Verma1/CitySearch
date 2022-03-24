//
//  CityListService.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation

protocol CityListService {
    var dataProvider: DataProvider { get }
    func getCityList(response: @escaping (_ result: [City]?, _ error : Error?) -> Void)
}
