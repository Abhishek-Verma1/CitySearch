//
//  MapViewModelImp.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation

class MapViewModelImp: MapViewModel {
    var data: City
    var title: String {
        return data.name ?? ""
    }
    
    var showData: ((City) -> ())?
    
    init(data: City) {
        self.data = data
    }
    
    func viewDidLoad() {
        self.showData?(self.data)
    }
    
}
