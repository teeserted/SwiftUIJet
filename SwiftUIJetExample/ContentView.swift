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
            
            JetBadge(text: "Custom font", padding: 30, font: .title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
