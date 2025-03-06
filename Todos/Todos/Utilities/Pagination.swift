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






fileprivate var ConstSize: Int = 0
fileprivate var ConstPage: Int = 0

class Pagination<T: BaseDataSource> {
     
    private var current: Int
    
    private var max: Int? = nil
    
    private var size: Int = 0
    
    private var isBlock = false
    
    var paginationItems: PageableItems<T>? = nil
    
    //private var active: Set<Int> = []
    
    var router: RequestModel
    
    //private let subscriber = Cancelable()
    private var cancellable = Set<AnyCancellable>()
    
   @Published public var items: [T]? = []
    let type: NSManagedObject.Type
   // private var keyword: String
    init(current: Int = 0, max: Int? = nil, size: Int, router: RequestModel, type: NSManagedObject.Type) {
        self.type = type
        self.current = current
        self.max = max
        self.size = size
        self.router = router
        //self.keyword = keyword
        ConstSize = size
        ConstPage = current
        //fetchData()
        
        NotificationCenter.default.addObserver(forName: .dataUploaded, object: nil, queue: .main) {[weak self] _ in
            DispatchQueue.main.async {
                
                self?.fetchData()
            }
           
        }
    }
    
    
    func restart(newPage: Int? = nil, newSize: Int? = nil, keyword: String? = nil) {
        current = 0
        self.router = router.modifyForPagination(newPage ?? self.current, pageSize: newSize ?? self.size, keyword: keyword)
        isBlock = false
        items = nil
        fetchData()
    }
    
    func finish() {
       
        current = 0
        isBlock = false
        items = nil
        paginationItems = nil
          
    }
    
    func configureHandler() {
        
        guard let paginationItems else { return}
        if isBlock { return }
        
        if paginationItems.last == true { return }
        
        if paginationItems.empty == true { return }
        
        if let max, max <= (paginationItems.totalPages ?? 0) {
            return
        }
        
           router = router.modifyForPagination( current, pageSize: size)
        fetchData()
    }
    
    private func fetchData() {
      
        if let model = CoreDataManager.shared.fetchData(router, request: type) as PageableItems<T>? {
            self.current += 1
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
    
    func modifyForPagination(_ page: Int, pageSize: Int, keyword: String? = nil) -> Self {
        return .init(page: page, pageSize: pageSize, keyword: keyword)
    }
}
