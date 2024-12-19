//
//  ContentView.swift
//  anote
//
//  Created by Alan Zeng on 2024/12/19.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}

import SwiftUI

struct ContentView: View {
    var body: some View {
        NoteListView()
//        NoteDetailView(note: "1", notes: "!")
    }
}

#Preview {
    ContentView()
}
