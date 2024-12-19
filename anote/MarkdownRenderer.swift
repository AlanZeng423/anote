//
//  MarkdownRenderer.swift
//  anote
//
//  Created by Alan Zeng on 2024/12/19.
//

//import SwiftUI
//
//struct MarkdownRenderer: View {
//    var markdownText: String
//
//    var body: some View {
//        ScrollView {
//            Text(try! AttributedString(markdown: markdownText))
//                .padding()
//                .font(.body)
//        }
//    }
//}


import SwiftUI
import MarkdownUI

struct MarkdownRenderer: View {
    var markdownText: String

    var body: some View {
        ScrollView {
            Markdown(markdownText)
                .padding()
                .font(.body)
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
    }
}
