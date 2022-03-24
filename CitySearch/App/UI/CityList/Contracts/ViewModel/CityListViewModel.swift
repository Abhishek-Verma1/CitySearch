//
//  CityListViewModel.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation

protocol CityListViewModelCoordinatorDelegate: AnyObject{
    func didTapOnRow(with data : City)
}

protocol CityListViewModel: AnyObject {
    
    var service: CityListService { get }
    var coordinatorDelegate: CityListViewModelCoordinatorDelegate? {get set}
    var title: String { get }
    var alertMessage: String? { get set}
    var showData: (()->())? { get set}
    var showLoader: (()->())? {get set}
    var hideLoader: (()->())? {get set}
    var cityView: CityView? {get set}
    
    func viewDidLoad()
    func didTapOnCity(of index: Int)
    func heightForRow(at index: Int, of section: Int)-> Int
    func numberOfRowsInSection(section : Int)-> Int
    func getTitle(at index: Int)-> String
    func getSubTitle(at index: Int)-> String
    func filter(_ searchText: String)
    
}
