//
//  Pagination.swift
//  Todos
//
//  Created by admin on 3/3/25.
//

import Foundation
import Combine
import Alamofire
import CoreData



class Pagination<T: BaseDataSource> {
     
    
    private var isBlock = false
    
    var paginationItems: PageableItems<T>? = nil
    
    //private var active: Set<Int> = []
    
    var router: RequestModel
    
    //private let subscriber = Cancelable()
    private var cancellable = Set<AnyCancellable>()
    
   @Published public var items: [T]? = []
    let type: NSManagedObject.Type
   // private var keyword: String
    init(size: Int, router: RequestModel, type: NSManagedObject.Type) {
        self.type = type
//        self.current = current
//        self.max = max
//        self.size = size
        self.router = router
        
        //fetchData()
        
        NotificationCenter.default.addObserver(forName: .dataUploaded, object: nil, queue: .main) {[weak self] _ in
            DispatchQueue.main.async {
                
                self?.fetchData()
            }
           
        }
    }
    
    
    func restart(newPage: Int? = nil, newSize: Int? = nil, keyword: String? = nil) {
        
        if let keyword, keyword.count > 0 {
            self.router.keyword = keyword
        } else {
            self.router.keyword = nil
        }
        
        self.router = router.modifyForPagination(newPage ?? newPage, pageSize: newSize , keyword: keyword)
        isBlock = false
        items = nil
        fetchData()
    }
    
    func finish() {
        router.page = 0
        
        isBlock = false
        items = nil
        paginationItems = nil
          
    }
    
    func configureHandler() {
        
        guard let paginationItems else { return}
        if isBlock { return }
        
        if paginationItems.last == true { return }
        
        if paginationItems.empty == true { return }
        
        if router.page <= (paginationItems.totalPages ?? 0) {
            return
        }
        
        fetchData()
    }
    
    private func fetchData() {
      
        if let model = CoreDataManager.shared.fetchData(router, request: type) as PageableItems<T>? {
           
            router.page += router.page
            self.paginationItems = model
            if let content = paginationItems?.content {
                
                if items != nil {
                    Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) {[weak self] _ in
                        guard let self else { return }
                        
                        self.items!.append(contentsOf: content)
                    }
                    
                } else {
                    self.items = content
                }
                   
                
            }
        } else {
            if items == nil {
                self.items = []
            }
        }
       
    }
    
    
}

struct RequestModel {
    var page: Int
    var pageSize: Int
    var keyword: String?
    
    func modifyForPagination(_ page: Int? = nil, pageSize: Int? = nil, keyword: String? = nil) -> Self {
        return .init(page: page ?? self.page, pageSize: pageSize ?? self.pageSize, keyword: keyword ?? self.keyword)
    }
}
