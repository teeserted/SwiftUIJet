//
//  ContentView.swift
//  SwiftUIJetExample
//
//  Created by Vello Vaherpuu on 15.05.2021.
//

import SwiftUI
import SwiftUIJet

struct ContentView: View {
    let data = [
        JetAccordionItem(title: "Header 1", content: "Content 1"),
        JetAccordionItem(title: "Header 2", content: "Content 2")
    ]
    @State var expandedViewIdx: Int? = 0
    var body: some View {
        VStack {
            Text("Expanded view index: \(expandedViewIdx ?? -1)")
            JetAccordion(data: data)
            JetAccordion(expandedViewIdx: $expandedViewIdx, data: data)
            JetAccordion(data: data, body: { item, isExpanded in
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
            JetAccordion(data: data, header: { item, isExpanded in
                HStack {
                    Image(systemName: isExpanded ? "pencil" : "scribble.variable")
                    Text("Custom content \(item.content)")
                    Spacer()
                }
                .contentShape(Rectangle()) // Makes whole HStack tappable
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
