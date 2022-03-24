//
//  CityListViewModelImp.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation

protocol CityView: NSObjectProtocol {
    func reload()
}

class CityListViewModelImp: CityListViewModel {
    var service: CityListService
    var title: String{
        return "Cities"
    }
    weak var coordinatorDelegate: CityListViewModelCoordinatorDelegate?
    
    weak var cityView: CityView?
    private var allCities = [City]() { didSet { citiesData = allCities } }
    private var citiesData = [City]() { didSet { cityView?.reload() } }
    
    var showData: (() -> ())?
    var showLoader: (() -> ())?
    var hideLoader: (() -> ())?
    var alertMessage: String?
    
    private var shouldShowLoader = false{
        didSet{
            (self.shouldShowLoader) ? self.showLoader?() : self.hideLoader?()
        }
    }
    
    init(service: CityListService) {
        self.service = service
        shouldShowLoader = true
        self.getData()
    }
    
    func didTapOnCity(of index: Int) {
        self.coordinatorDelegate?.didTapOnRow(with: self.citiesData[index])
    }
    
    func heightForRow(at index: Int, of section: Int) -> Int {
        return 70
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return citiesData.count
    }
    
    func viewDidLoad() {
        (shouldShowLoader) ? self.showLoader?() : self.hideLoader?()
    }
    
    func getTitle(at index: Int)->String {
         let dataValue = citiesData
            if let name = dataValue[index].name,
               let country = dataValue[index].country {
            return "\(name), \(country)"
        }
        return ""
    }
    
    func getSubTitle(at index: Int)-> String {
         let dataValue = citiesData
            if let name = dataValue[index].coord?.lat,
               let country = dataValue[index].coord?.lon {
                return "\(name), \(country)"
            }
        return ""
    }
    
    private func getData() {
        self.service.getCityList { [weak self] (cities, error) in
            guard let self = self else {
                return
            }
            guard error == nil,
                let cities = cities else {
                    self.shouldShowLoader = false
                    self.alertMessage = error?.localizedDescription
                    return
                }
            self.allCities = self.sort(cities)
            self.shouldShowLoader = false
            self.showData?()
        }
    }
    
    private func sort(_ cities: [City]) -> [City] {
        return cities.sorted(by: { $0.name ?? "" < $1.name ?? "" })
    }
    
    func filter(_ searchText: String) {
        if searchText.isEmpty {
            citiesData = allCities
        } else {
            citiesData = allCities.filter { ($0.name ?? "").uppercased().hasPrefix(searchText.uppercased()) }
        }
    }
    
}
