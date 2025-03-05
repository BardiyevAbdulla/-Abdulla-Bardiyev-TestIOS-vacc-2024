//
//  BaseCoordinator.swift
//  Todos
//
//  Created by admin on 3/3/25.
//

import Foundation
import UIKit

protocol BaseCoordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: BaseCoordinator? { get set }
    
    func start()
    func start(coordinator: BaseCoordinator)
    func didFinish(coordinator: BaseCoordinator)
    func removeCoordinators()
}
