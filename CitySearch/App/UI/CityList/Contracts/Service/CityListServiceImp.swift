//
//  CityListServiceImp.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation

class CityListServiceImp: CityListService {
    
    var dataProvider: DataProvider

    init(dataProvider : DataProvider) {
        self.dataProvider = dataProvider
    }

    func getCityList(response: @escaping (_ result: [City]?, _ error : Error?) -> Void) {
        dataProvider.getCities(response: {  cities, error in
            response(cities, error)
        })
    }
    
}
