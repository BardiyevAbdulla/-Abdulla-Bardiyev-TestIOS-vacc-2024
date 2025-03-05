//
//  ContentView.swift
//  AIGemini
//
//  Created by admin on 7/4/24.
//

import SwiftUI
import GoogleGenerativeAI

let token = "AIzaSyDfycW9PtHB8G1OnQO_wB1e4ru4CSD0Ty0"

struct ContentView: View {
    
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default, safetySettings: [.init(harmCategory: .sexuallyExplicit, threshold: .blockNone)])
    
    @State var userPrompt = ""
    @State var response = "How can I help you today?"
    @State var isLoading = false
    
    var body: some View {
        VStack {
        
            Text("Welcome Gemini AI")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.indigo)
                .padding(.top, 40)
            
            ZStack {
                ScrollView {
                    Text(response)
                        .font(.title)
                        .onTapGesture {
                            UIPasteboard.general.string = response
                        }
                }
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(4)
                    }
                }
            TextField("Ask Anything", text: $userPrompt, axis: .vertical)
                .lineLimit(5)
                .font(.title)
                .padding()
                .background(Color.indigo.opacity(0.2), in: Capsule())
                .disableAutocorrection(true)
                .onSubmit {
                    generateResponse()
                }
            
        }
        .padding()
        .background(Color.white)
    }
    
    func generateResponse() {
        isLoading = true
        response = ""
        
        Task {
            do {
                let result = try await model.generateContent(userPrompt)
                isLoading = false
                response = result.text ?? "No response found"
                userPrompt = ""
            }
            catch {
                response = "Something went wrong\n\(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    ContentView()
}
