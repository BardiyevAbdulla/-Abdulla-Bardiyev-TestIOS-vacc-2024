//
//  MainTabBarCoordinator.swift
//  Todos
//
//  Created by admin on 3/3/25.
//

import Foundation
import UIKit
import Combine

class MainTabBarCoordinator: Coordinator {
    
   // var viewControllers = [UINavigationController]()
    
    let controller: MainTableViewController
    var cancelables = Set<AnyCancellable>()
    init(vm: MainViewModel) {
        controller = .init(vm: vm)
        
        
    }
    
    override func start() {
        
        navigationController.pushViewController(controller, animated: false)
        subscribeEvent()
        //navigationController.viewControllers = [controller]
        
    }
    
    func subscribeEvent() {
        controller.vm.navigationPasser.sink {[weak self] model in
            guard let self else { return }
            switch model {
            case .detail(let todoModel):
                let vm = UserDetailViewModel(todoModel)
                let coordinator = UserDetailCoordinator(vm)
                vm.navigationPasser.sink { router in
                    switch router {
                    case .back:
                        
                        //DispatchQueue.main.async {
                            self.didFinish(coordinator: coordinator)
                        self.navigationController.popViewController(animated: true)
                        //}
                        
                        
                    }
                    
                }.store(in: &cancelables)
                //self.navigationController.pushViewController(coordinator.controller, animated: true)
                coordinator.navigationController = self.navigationController
                self.start(coordinator: coordinator)
                
            }
            
        }.store(in: &cancelables)
    }
    
    }
    
   
