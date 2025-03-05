//
//  UserDetailCoordinator.swift
//  Todos
//
//  Created by admin on 3/4/25.
//

import Combine
import UIKit

class UserDetailCoordinator: Coordinator {
    
    //var viewControllers = [UINavigationController]()
    
    let controller: UserDetailView
    

     init(_ model: TodoModel) {
        //super.init()
         controller = .init(vm: .init(model))
        
    }
    init(_ vm: UserDetailViewModel) {
        controller = .init(vm: vm)
    }
    
    override func start() {
        
        
        
       // navigationController.viewControllers = [controller]
        navigationController.pushViewController(controller, animated: true)
        event()
    }
    
    func event() {
//        controller.vm.navigationPasser.sink { router in
//            switch router {
//            case .back:
//                break
//            }
//        }
    }
    }
    
   
