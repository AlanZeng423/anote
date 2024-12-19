//import SwiftUI
//
//struct NoteListView: View {
//    @State private var notes: [Note] = DataManager.shared.load()
//    @State private var showAddNoteView = false
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(notes) { note in
//                    NavigationLink(destination: NoteDetailView(note: note, onSave: saveNote)) {
//                        Text(note.title)
//                            .padding()
//                    }
//                }
//                .onDelete(perform: deleteNote)
//            }
//            .navigationBarTitle("Notes")
//            .navigationBarItems(trailing: Button(action: {
//                showAddNoteView = true
//            }) {
//                Image(systemName: "plus")
//            })
//            .sheet(isPresented: $showAddNoteView) {
//                NoteDetailView(note: nil, onSave: addNote)
//            }
//        }
//    }
//
//    private func saveNote(note: Note) {
//        if let index = notes.firstIndex(where: { $0.id == note.id }) {
//            notes[index] = note
//        } else {
//            notes.append(note)
//        }
//        DataManager.shared.save(notes: notes)
//    }
//
//    private func addNote(note: Note) {
//        notes.append(note)
//        DataManager.shared.save(notes: notes)
//    }
//
//    private func deleteNote(at offsets: IndexSet) {
//        notes.remove(atOffsets: offsets)
//        DataManager.shared.save(notes: notes)
//    }
//}

//import SwiftUI
//
//struct NoteListView: View {
//    @State private var notes: [Note] = []
//    @State private var showAddNoteView = false
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(notes) { note in
//                    NavigationLink(destination: NoteDetailView(note: note)) {
//                        VStack(alignment: .leading) {
//                            Text(note.title)
//                                .font(.headline)
//                                .lineLimit(1)
//                            Text(note.preview)
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                                .lineLimit(1)
//                        }
//                    }
//                }
//                .onDelete(perform: deleteNote)
//            }
////            .navigationTitle("Notes")
//            .navigationBarTitleDisplayMode(.large)
////            .navigationBarItems(trailing: Button(action: {
////                showAddNoteView = true
////            }) {
////                Image(systemName: "plus")
////            })
//            .toolbar {
//                // 自定义标题和按钮
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Text("Notes")
//                        .font(.largeTitle)
//                        .bold()
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        showAddNoteView = true
//                    }) {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//            .sheet(isPresented: $showAddNoteView) {
//                NoteDetailView(note: nil, onSave: addNote)
//            }
//        }
//    }
//
//    private func deleteNote(at offsets: IndexSet) {
//        notes.remove(atOffsets: offsets)
//    }
//
//    private func addNote(_ note: Note) {
//        notes.append(note)
//    }
//}
//
//
//

//
import SwiftUI

struct NoteListView: View {
    @State private var notes: [Note] = []
    @State private var showAddNoteView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note, onSave: updateNote)) {
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                                .lineLimit(1)
                            Text(note.preview)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                        }
                    }
                }
                .onDelete(perform: deleteNote)
            }
//            List {
//                ForEach(groupedNotes.keys.sorted(), id: \.self) { tag in
//                    Section(header: Text(tag)) { // 按标签分组
//                        ForEach(groupedNotes[tag] ?? []) { note in
//                            NavigationLink(destination: NoteDetailView(note: note, onSave: updateNote)) {
//                                VStack(alignment: .leading) {
//                                    Text(note.title)
//                                        .font(.headline)
//                                        .lineLimit(1)
//                                    Text(note.preview)
//                                        .font(.subheadline)
//                                        .foregroundColor(.gray)
//                                        .lineLimit(1)
//                                }
//                            }
//                        }
//                        .onDelete { offsets in
//                            let notesToDelete = groupedNotes[tag] ?? []
//                            let indicesToDelete = offsets.map { notes.firstIndex(where: { $0.id == notesToDelete[$0].id })! }
//                            for index in indicesToDelete {
//                                notes.remove(at: index)
//                            }
//                            saveNotesToFile()
//                        }
//                    }
//                }
//            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Notes")
                        .font(.largeTitle)
                        .bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddNoteView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddNoteView) {
                NoteDetailView(note: nil, onSave: addNote)
            }
            .onAppear {
                notes = loadNotesFromFile()
            }
        }
    }
    
//    private var groupedNotes: [String: [Note]] {
//        let allNotes = notes
//        return Dictionary(grouping: allNotes, by: { $0.tags.first ?? "Untagged" })
//    }
    

    private var notesFileURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("notes.json")
    }

    private func saveNotesToFile() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(notes) {
            try? data.write(to: notesFileURL)
        }
    }

    private func loadNotesFromFile() -> [Note] {
        if let data = try? Data(contentsOf: notesFileURL) {
            let decoder = JSONDecoder()
            if let loadedNotes = try? decoder.decode([Note].self, from: data) {
                return loadedNotes
            }
        }
        return []
    }

    private func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        saveNotesToFile()
    }

    private func addNote(_ note: Note) {
        notes.append(note)
        saveNotesToFile()
    }

    private func updateNote(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note
            saveNotesToFile()
        }
    }
    
//    private func shareNote(_ note: Note) {
//           let fileURL = filePath(for: note.title)
//           let activityController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
//           if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let rootVC = scene.windows.first?.rootViewController {
//               rootVC.present(activityController, animated: true, completion: nil)
//           }
//       }
}



//import SwiftUI
//
//struct NoteListView: View {
//    @State private var notes: [Note] = []
//    @State private var showAddNoteView = false
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(notes) { note in
//                    NavigationLink(destination: NoteDetailView(note: note, onSave: updateNote, onShare: shareNote)) {
//                        VStack(alignment: .leading) {
//                            Text(note.title)
//                                .font(.headline)
//                                .lineLimit(1)
//                            Text(note.preview)
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                                .lineLimit(1)
//                        }
//                    }
//                }
//                .onDelete(perform: deleteNote)
//            }
//            .navigationBarTitleDisplayMode(.large)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Text("Notes")
//                        .font(.largeTitle)
//                        .bold()
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        showAddNoteView = true
//                    }) {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//            .sheet(isPresented: $showAddNoteView) {
//                NoteDetailView(note: nil, onSave: addNote, onShare: nil)
//            }
//            .onAppear {
//                notes = loadNotesFromFiles()
//            }
//        }
//    }
//
//    private var documentsDirectory: URL {
//        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//    }
//
//    private func filePath(for title: String) -> URL {
//        documentsDirectory.appendingPathComponent("\(title).md")
//    }
//
//    private func saveNoteToFile(_ note: Note) {
//        let fileURL = filePath(for: note.title)
//        try? note.content.write(to: fileURL, atomically: true, encoding: .utf8)
//    }
//
//    private func loadNotesFromFiles() -> [Note] {
//        guard let fileURLs = try? FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil) else {
//            return []
//        }
//        return fileURLs.compactMap { url in
//            guard url.pathExtension == "md",
//                  let content = try? String(contentsOf: url) else { return nil }
//            return Note(id: UUID(), title: url.deletingPathExtension().lastPathComponent, content: content)
//        }
//    }
//
//    private func deleteNote(at offsets: IndexSet) {
//        offsets.forEach { index in
//            let note = notes[index]
//            let fileURL = filePath(for: note.title)
//            try? FileManager.default.removeItem(at: fileURL)
//        }
//        notes.remove(atOffsets: offsets)
//    }
//
//    private func addNote(_ note: Note) {
//        notes.append(note)
//        saveNoteToFile(note)
//    }
//
//    private func updateNote(_ note: Note) {
//        if let index = notes.firstIndex(where: { $0.id == note.id }) {
//            notes[index] = note
//            saveNoteToFile(note)
//        }
//    }
//
//    private func shareNote(_ note: Note) {
//        let fileURL = filePath(for: note.title)
//        let activityController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
//        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let rootVC = scene.windows.first?.rootViewController {
//            rootVC.present(activityController, animated: true, completion: nil)
//        }
//    }
//}
