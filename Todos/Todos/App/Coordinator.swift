//
//  Coordinator.swift
//  Todos
//
//  Created by admin on 3/3/25.
//

import Foundation
import UIKit

class Coordinator: BaseCoordinator {
    var navigationController = UINavigationController()
    
    var parentCoordinator: BaseCoordinator?
    
    var childCoordinators: [BaseCoordinator] = []
    
    func start() {
        fatalError("this function shouldn't be implements")
    }
    
    func start(coordinator: BaseCoordinator) {
        
        coordinator.parentCoordinator = self
        childCoordinators += [coordinator]
        coordinator.start()
    }
    
    func didFinish(coordinator: BaseCoordinator) {
        if let index = childCoordinators.firstIndex(where: {$0 === coordinator}) {
            childCoordinators.remove(at: index)
        }
    }
    
    func removeCoordinators() {
        childCoordinators.forEach({$0.removeCoordinators()})
        childCoordinators.removeAll()
    }
    
    deinit {
        print("deinit -> \(String(describing: type(of: self)))")
    }
    
}
