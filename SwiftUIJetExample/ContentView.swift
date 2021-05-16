//
//  ContentView.swift
//  SwiftUIJetExample
//
//  Created by Vello Vaherpuu on 15.05.2021.
//

import SwiftUI
import SwiftUIJet

struct ContentView: View {
    let testData = [
        JetAccordionItem(title: "Header 1", content: "Content 1"),
        JetAccordionItem(title: "Header 2", content: "Content 2")
    ]
    var body: some View {
        VStack {
            JetAccordion(data: testData)
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
