//
//  VerifyViewModel.swift
//  ChineStore
//
//  Created by admin on 2/9/25.
//

import Foundation

class VerifyViewModel: ObservableObject {
    let number: String
    let interval: Int
    let cellCount: Int
    let repo = VerifyRepository()
    @Published var counter: Int?
var timer: Timer?
    init(number: String, interval: Int = 60, CellCount: Int = 6) {
        self.number = number
        self.interval = interval
        self.cellCount = CellCount
        
    }
    
    func resendSMS() {
        time()
    }
    
    func time() {
        counter = interval
        timer = Timer(timeInterval: 1.0, repeats: true, block: handleTimeBlock)
        
    }
    
    func handleTimeBlock(_ time: Timer) {
        guard let counter else {
            timer?.invalidate()
            timer?.fire()
            timer = nil
            return
        }
        self.counter! -= 1
        if counter < 1 {
            self.counter = nil
            
                timer?.invalidate()
                timer?.fire()
                timer = nil
                return
            
        }
    }
    
    func back() {
        
    }
    
}
