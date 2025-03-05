//
//  ContentView.swift
//  ChineStore
//
//  Created by admin on 2/6/25.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            Text("Enter the verification code")
                .font(.headline)
            
            Text("Enter the 6-digit code that we sent you to your phone")
                .font(.subheadline)
            
            Link("+998 99 876 03 39 🇺🇿", destination: URL(string: "tel://+998998760339")!)
                .foregroundColor(.orange)
                .font(.title3)
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
