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
            JetAccordion(data: data, expandedViewIdx: $expandedViewIdx)
            Spacer()
            HStack {
                Button(action: {
                    expandedViewIdx = 0
                }){
                    Text("Open 1st")
                }
                
                Button(action: {
                    expandedViewIdx = 1
                }){
                    Text("Open 2nd")
                }
                
                Button(action: {
                    expandedViewIdx = nil
                }, label: {
                    Text("Close")
                })
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
