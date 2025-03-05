//
//  VerifyView.swift
//  ChineStore
//
//  Created by admin on 2/9/25.
//

import SwiftUI

struct VerifyView: View {
    @StateObject var vm: VerifyViewModel
    var body: some View {
        VStack {
            Text("Enter the verification code")
                .font(.Inter.bold(18))
            
            Text("Enter the \(vm.cellCount)-digit code that we sent you to your phone \(vm.number) 🇺🇿", changeColors: [ChangeColor(text: vm.number, color: .amberBlaze)])
                
            HStack(spacing: 12) {
                ForEach(0 ..< vm.count) { index in
                    CharacterBox(character: getInputBinding(index: index), selectedInput: $vm.selectedInput, index: index)
                        .onTapGesture {
                            vm.selectedInput = index
                        }
                }
            

            }
            
//            Text("Enter the \(vm.cellCount)-digit code that we sent you to your phone \(vm.number)", changeColors: [ChangeColor(text: vm.number, color: .amberBlaze)]) + Text(vm.number)

            if let counter = vm.counter {
                Text("Resend code in \(counter) sec.")
            } else {
                Button("Resend code", action: vm.resendSMS)
                    .foregroundStyle(Color.App.AmberBlaze)
            }
            
            
            Button(action: {}, label: {
                Text("Button")
            })
        }
        
    }
}

#Preview {
    VerifyView(vm: .init(number: "+998 99 876 03 39"))
}
