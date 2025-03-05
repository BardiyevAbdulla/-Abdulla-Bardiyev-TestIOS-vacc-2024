//
//  AuthView.swift
//  ChineStore
//
//  Created by admin on 2/6/25.
//

import SwiftUI

struct AuthView: View {
    @StateObject var vm: AuthViewModel
    var body: some View {
        VStack(spacing: 12) {
            Image(.logoAndName)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            Text("Enter your phone number to log in or register.".localize)
                .font(.Inter.medium(20))
                .frame(maxWidth: .infinity, alignment: .leading)
            PhoneNumberView(number: $vm.number)
                //.frame(height: 60)
                
            Text("Proceeding, you accept Privacy Policy and User Agreement China Store.", changeFonts: [ChangeFont(text: "China Store", font: .boldSystemFont(ofSize: 12))], setLinks: [SetLink(text: "Privacy Policy", link: "https://your-china-store-url.com"), SetLink(text: "User Agreemen", link: "https://your-china-store-url.com")]).font(.system(size: 12))
                .frame(maxWidth: .infinity, alignment: .leading)
            
           
            
            Button("Continue", action: {})
                .foregroundStyle(Color.black)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color.App.AmberBlaze)
                .clipShape(RoundedRectangle(cornerRadius: 26))
                .frame(maxWidth: .infinity, alignment: .trailing)
                //.padding(.trailing)
            Spacer()
            Label("All data is kept secure", image: .lock)
            Text("CS MEMBERSHIP", changeColors: [ChangeColor(text: "C", color: UIColor(named: "AmberBlaze")!)])
            
        }
        .padding(.horizontal, 12)
        
    }
}

#Preview {
    AuthView(vm: .init(number: ""))
}
struct PhoneNumberView: View {
    @Binding var number: String
    var body: some View {
        HStack {
            Image(.uzbekistan)
                .padding(.leading, 10)
            Text("+998 ")
            TextField("", text: $number)
        }
        .padding(.vertical, 12)
        .overlay(
            RoundedRectangle(cornerRadius: 4).stroke(Color.gray, lineWidth: 0.5)
        )
        
    }
}

func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
