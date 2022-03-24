//
//  AppCoordinator.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    private var window: UIWindow?
    
    lazy var dataProvider: DataProvider = {
         return DataProvider()
     }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    var listCoordinator: CityListCoordinator!
    
    @discardableResult
    func start()-> UIViewController {
        listCoordinator = CityListCoordinator(dataProvider: dataProvider)
        let mainVC = listCoordinator.start()
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
        return mainVC
    }
    
}
