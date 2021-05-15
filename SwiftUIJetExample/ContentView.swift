//
//  ContentView.swift
//  SwiftUIJetExample
//
//  Created by Vello Vaherpuu on 15.05.2021.
//

import SwiftUI
import SwiftUIJet

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello world")
                .padding()
                .badge(count: 5)
            
            Text("Text Badge")
                .badge(text: "!!")
            
            JetBadge(text: "Custom font", padding: 20, font: .title)
            JetBadge(padding: 10, backgroundColor: .blue) {
                HStack(spacing: 0) {
                    Image(systemName: "square.and.arrow.up")
                    Text("With custom content")
                }
                .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
