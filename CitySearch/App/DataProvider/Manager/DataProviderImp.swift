//
//  DataProviderImp.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation

extension DataProvider {
    
    // MARK: Cities (GET) Methods
    func getCities(response: @escaping (_ result: [City]?, _ error : Error?) -> Void) {
        guard let citiesAPI = Constants.API.cities else {
            response(nil, APIError.fileNotFound)
            return
        }
        
        let _ = taskForGETMethod(citiesAPI) { (data, error) in
            guard error == nil,
                  let data = data else {
                      response(nil, error)
                      return
                  }
            
            do {
                let cities: [City] = try JSONDecoder().decode([City].self, from: data)
                response(cities, nil)
            } catch(let error) {
                let userInfo = [NSLocalizedDescriptionKey : error.localizedDescription]
                response(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
        }
    }
    
}
