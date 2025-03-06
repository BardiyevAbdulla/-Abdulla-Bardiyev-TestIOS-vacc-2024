//
//  AppCoordinator.swift
//  Todos
//
//  Created by admin on 3/3/25.
//

import Foundation
import UIKit
import Combine
import Alamofire
import Network

class AppCoordinator: Coordinator {
   
    var window: UIWindow?
    
    override func start() {
        removeCoordinators()
        window?.makeKeyAndVisible()
        let coordinator = MainTabBarCoordinator(vm: .init())
        start(coordinator: coordinator)
        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()
        
        let manager = AppManager()
        
    }
    
    func setWindow(window: UIWindow?) {
        self.window = window
    }
}

class AppManager {
   
    var isDatasDownloaded = false {
        
        didSet {
           
            if isDatasDownloaded {
                
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .dataUploaded, object: nil)
                }
               
                
            }
        }
    }
    
    var cancelables = Set<AnyCancellable>()
    
    let monitor = NetworkMonitor()
    
    init() {
        
        //uploadData()
        monitor.start()
        monitor.passer.sink(receiveValue: { value in
            //guard let self else { return }
            
            if value && !self.isDatasDownloaded {
                self.uploadData()
            }
        })
            .store(in: &cancelables)
//        monitor.$isConnected
//            .sink {[weak self] value in
//                guard let self else { return }
//                
//                if value && !self.isDatasDownloaded {
//                    self.uploadData()
//                }
//            }
//            .store(in: &cancelables)
        
    }
    
    func uploadData() {
        APICaller.shared.fetchUsers()
//            APICaller.shared.fetchTodoList()
                .handleEvents(receiveOutput: { _ in
                    self.clearUserData() // Clear old data before inserting new ones
                })
                .flatMap { models -> AnyPublisher<[TodoModel]?, AFError> in
                    if let models {
                        self.saveUserData(models)
                    }
                    
                    return APICaller.shared.fetchTodoList()
                   // return APICaller.shared.fetchUsers() // Now, fetchUsers() starts only after fetchTodoList() is done
                }
                .handleEvents(receiveOutput: { _ in
                    self.clearTodoData()
                     // Clear old user data
                })
                .sink(receiveCompletion: errorHandle, receiveValue: { models in
                    if let models {
                        self.saveTodoData(models)
                        
                        self.isDatasDownloaded = true
                    }
                    
                })
                .store(in: &cancelables)
        }

        // MARK: - Helper Methods
        
        func clearTodoData() {
            for item in CoreDataManager.shared.todoList {
                CoreDataManager.shared.context.delete(item)
            }
        }

        func saveTodoData(_ models: [TodoModel]) {
            for item in models {
                let todo = TodoEntity(context: CoreDataManager.shared.context)
                todo.id = item.id!
                todo.userId = item.userId ?? 2
               
                todo.title = item.title
                todo.name = CoreDataManager.shared.fetchData(item.userId ?? 0, type: UserEntity.self)?.name
                
            }
            saveContext()
            
        }

        func clearUserData() {
            for item in CoreDataManager.shared.DetailList {
                CoreDataManager.shared.context.delete(item)
            }
        }

        func saveUserData(_ models: [UserModel]) {
            for item in models {
                let context = CoreDataManager.shared.context
                let detail = UserEntity(context: context)
                detail.name = item.name
                detail.phone = item.phone
                detail.id = item.id!
                detail.username = item.username
                detail.website = item.website
                detail.email = item.email

                let company = CompanyEntity(context: context)
                company.bs = item.company?.bs
                company.catchPhrase = item.company?.catchPhrase
                company.name = item.company?.name
                detail.company = company

                let address = AdressEntity(context: context)
                address.city = item.address?.city
                address.street = item.address?.street
                address.suite = item.address?.suite
                address.zipcode = item.address?.zipcode
                detail.address = address
            }
            saveContext()
            
        }

        func saveContext() {
            do {
                try CoreDataManager.shared.context.save()
                print("Saved successfully")
            } catch {
                print("Failed to save: \(error.localizedDescription)")
            }
        }
    
    func errorHandle(_ complition: Subscribers.Completion<AFError>) {
        switch complition {
        case .finished:
            break
        case .failure(let failure):
            NotificationCenter.default.post(name: .failedUploadData, object: "Downloading is failed")
        }
    }
}


final class NetworkMonitor: ObservableObject {
    var monitor: NWPathMonitor? = nil
    let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published var isConnected = false
    var passer = PassthroughSubject<Bool, Never>()
    func start() {
        if monitor == nil {
            monitor = NWPathMonitor()
            monitor?.pathUpdateHandler = { [weak self] path in
                DispatchQueue.main.async {
                    print("internet changed")
                    self!.passer.send(path.status == .satisfied)
                    self?.isConnected = path.status == .satisfied ? true : false
                }
            }
        }
        monitor?.start(queue: queue)
    }
    
    func stop() {
        monitor?.cancel()
        monitor = nil
    }
}
