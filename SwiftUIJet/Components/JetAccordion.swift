//
//  JetAccordion.swift
//  SwiftUIJet
//
//  Created by Vello Vaherpuu on 15.05.2021.
//

import SwiftUI

public struct JetAccordionItem: Hashable {
    let id = UUID()
    let title: String
    let content: String
    
    public init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}

public struct JetAccordion: View {
    var data: [JetAccordionItem]
  //  var renderHeader: (JetAccordionItem, Bool) -> Content
  //  var renderBody: (JetAccordionItem, Bool) -> Content
    @State private var expandedViewId: UUID?
    
    public init(data: [JetAccordionItem]) {
        self.data = data
    }
    
    public var body: some View {
        VStack {
            ForEach(data, id: \.id) { item in
                VStack {
                    header(item)
                    body(item)
                }
            }
        }
    }
    
    private func header(_ item: JetAccordionItem) -> some View {
        Button(action: { headerTapped(item) }, label: {
            HStack {
                Text(item.title)
                Spacer()
                Image(systemName: iconName(item))
            }
            .padding(.bottom, 1)
            .background(Color.white.opacity(0.01))
        }).buttonStyle(PlainButtonStyle())
    }
    
    private func body(_ item: JetAccordionItem) -> some View {
        var contentMaxHeight: CGFloat? {
            isExpanded(item) ? nil : 0
        }
        
        return VStack {
            Text(item.content)
        }
        .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: contentMaxHeight)
        .clipped()
        .animation(.easeOut)
        .transition(.slide)
    }
    
    private func iconName(_ item: JetAccordionItem) -> String {
        return isExpanded(item) ? "chevron.up" : "chevron.down"
    }
    
    private func isExpanded(_ item: JetAccordionItem) -> Bool {
        return expandedViewId == item.id
    }
    
    private func headerTapped(_ item: JetAccordionItem) {
        if expandedViewId == item.id {
            expandedViewId = nil
            return
        }
        expandedViewId = item.id
    }
}

struct JetAccordion_Previews: PreviewProvider {
    static var previews: some View {
        let testData = [
            JetAccordionItem(title: "Header 1", content: "Content 1"),
            JetAccordionItem(title: "Header 2", content: "Content 2")
        ]
        return JetAccordion(data: testData)
    }
}
