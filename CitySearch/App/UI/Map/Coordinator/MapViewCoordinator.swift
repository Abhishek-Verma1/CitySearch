//
//  MapViewCoordinator.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation
import UIKit

class MapViewCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let data: City
    
    init(navigationController: UINavigationController, data: City) {
        self.navigationController = navigationController
        self.data = data
    }
    
    func start()-> UIViewController {
        if let mapVC = MapViewCoordinator.instantiateViewController() as? MapViewController {
            let viewModel = MapViewModelImp(data: self.data)
            mapVC.viewModel = viewModel
            return mapVC
        }
        return UIViewController()
    }
}

extension MapViewCoordinator: StoryboardInitializable {
    static var storyboardName: UIStoryboard.Storyboard {
        return .main
    }
}
