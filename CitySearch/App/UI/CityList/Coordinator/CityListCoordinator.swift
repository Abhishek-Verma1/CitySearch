//
//  CityListCoordinator.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation
import UIKit

class CityListCoordinator: Coordinator {
    var rootViewController: UINavigationController!
    var dataProvider: DataProvider
    var mapViewCoordinator: MapViewCoordinator!
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func start()-> UIViewController{
        guard let listVC = CityListCoordinator.instantiateViewController() as? CityListViewController else {
            return UIViewController()
        }
        rootViewController = UINavigationController(rootViewController: listVC)
        let service = CityListServiceImp(dataProvider: self.dataProvider)
        let viewModel = CityListViewModelImp(service: service)
        viewModel.coordinatorDelegate = self
        listVC.viewModel = viewModel
        return rootViewController
    }
    
}

extension CityListCoordinator: CityListViewModelCoordinatorDelegate {
    func didTapOnRow(with data: City) {
        mapViewCoordinator = MapViewCoordinator(navigationController: self.rootViewController, data: data)
        let detailVC = mapViewCoordinator.start()
        self.rootViewController.pushViewController(detailVC, animated: true)
    }
}

extension CityListCoordinator: StoryboardInitializable {
    static var storyboardName: UIStoryboard.Storyboard {
        return .main
    }
}

