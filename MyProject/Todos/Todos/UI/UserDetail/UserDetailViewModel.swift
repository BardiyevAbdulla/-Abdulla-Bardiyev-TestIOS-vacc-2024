//
//  UserDetailViewModel.swift
//  Todos
//
//  Created by admin on 3/4/25.
//

import Foundation
import Combine
import Alamofire

final class UserDetailViewModel: ObservableObject {
    enum Router: Equatable {
        case back
    }
    
    var navigationPasser = PassthroughSubject<Router, Never>()
    let userId: Int64
    @Published var userModel: UserModel?
    var todo: TodoModel?
    
    var array : [SectionData] = []
    
    var cancellablles = Set<AnyCancellable>()
    
    init(_ todo: TodoModel) {
        self.todo = todo
        self.userId = todo.userId ?? 0
        if let detail = CoreDataManager.shared.DetailList.first(where: {$0.id == userId}) {
            
            self.userModel = .init(id: detail.id, name: detail.name, username: detail.username, email: detail.email, phone: detail.phone, website: detail.website, address: .init(street: detail.address?.street, suite: detail.address?.suite, city: detail.address?.city, zipcode: detail.address?.zipcode), company: .init(name: detail.company?.name, catchPhrase: detail.company?.catchPhrase, bs: detail.company?.bs))
        } else {
            uploadData()
        }
        
        
    }
    
    func fillArray() {
        var first: [CellData] = [.init(name: userModel?.name ?? "", title: "name: "),
                             .init(name: userModel?.username ?? "", title: "userName"),
                             .init(name: userModel?.email ?? "", title: "email"),
                             .init(name: userModel?.website ?? "", title: "website"),
                            
        ]
        var second: [CellData] = [.init(name: userModel?.company?.name ?? "", title: "name:"),
                              .init(name: userModel?.company?.catchPhrase ?? "", title: "catch phrase:"),
                              .init(name: userModel?.company?.bs ?? "", title: "bs:")
                              
          ]
        var third: [CellData] = [.init(name: userModel?.address?.street ?? "", title: "street name:"),
                             .init(name: userModel?.address?.suite ?? "", title: "suite:"),
                             .init(name: userModel?.address?.zipcode ?? "", title: "zipcode:")
                              
          ]
        let list = SectionData(section: "personal information", aa: first)
        let list2 = SectionData(section: "Company detail", aa: second)
        let list3 = SectionData(section: "Address detail", aa: third)
        self.array = [list, list2, list3]
    }
    
    func uploadData() {
        APICaller.shared.fetchUsers(id: userId)
            .sink(receiveCompletion: handleError) { userModel in
                if let userModel {
                    self.userModel = userModel
                }
            }.store(in: &cancellablles)
    }
    
    func handleError(_ complition: Subscribers.Completion<AFError>) {
        switch complition {
        case .finished:
            break
        case .failure(let failure):
            NotificationCenter.default.post(name: .failedUploadData, object: "Downloading is failed")
        }
    }
}
