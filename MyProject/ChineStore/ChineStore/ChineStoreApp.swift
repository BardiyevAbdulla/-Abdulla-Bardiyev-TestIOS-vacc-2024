//
//  ChineStoreApp.swift
//  ChineStore
//
//  Created by admin on 2/6/25.
//

import SwiftUI

@main
struct ChineStoreApp: App {
    var body: some Scene {
        WindowGroup {
            VerifyView(vm: .init(number: "+998 99 876 03 39"))
            //AuthView(vm: .init(number: "") )
        }
    }
}
