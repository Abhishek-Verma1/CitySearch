//
//  MapViewModel.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation

protocol MapViewModel {
    var data: City { get }
    var title: String { get }
    var showData: ((City)->())? { get set }
    func viewDidLoad()
}
