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
            JetAccordion(data: testData, body: { item, isExpanded in
                VStack {
                    HStack {
                        Spacer()
                    }
                    Text("Custom content \(item.content)")
                }
                .background(Color.red)
                .padding()
            })
            Spacer()
            JetAccordion(data: testData, header: { item, isExpanded in
                HStack {
                    Image(systemName: isExpanded ? "pencil" : "scribble.variable")
                    Text("Custom content \(item.content)")
                    Spacer()
                }
            })
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
