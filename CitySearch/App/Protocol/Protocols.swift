//
//  Protocols.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation
import UIKit

protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
    static var storyboardName: UIStoryboard.Storyboard { get }
    static func instantiateViewController() -> UIViewController
}
