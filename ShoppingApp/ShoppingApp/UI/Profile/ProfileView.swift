//
//  ProfileView.swift
//  ShoppingApp
//
//  Created by admin on 6/19/24.
//

import SwiftUI

open class ProfileFlowState: ObservableObject {
    @Published var path = NavigationPath()
    @Published var presentedItem: ProfileViewLink?
    @Published var coverItem: ProfileViewLink?
    @Published var selectedLink: ProfileViewLink? // old style
}

struct ProfileView: View {
    @StateObject var vm: ProfileViewModel
    
    var body: some View {
        ProfileCoordinator(state: vm, content: contentView)
    }
    
    func contentView() -> some View {
        VStack {
            Text("ss")
        }
    }
}
