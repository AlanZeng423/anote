//import SwiftUI
//
//struct NoteDetailView: View {
//    @State private var title: String
//    @State private var content: String
//    @State private var status: String = ""
//    @State private var showMarkdownPreview = false
//    @State private var isEditing = false
//    @State private var undoStack: [String] = []
//    @State private var redoStack: [String] = []
//
//    @Environment(\.presentationMode) var presentationMode // 控制视图返回
//
//    var note: Note?
//    var onSave: ((Note) -> Void)?
//    var onShare: ((Note) -> Void)?
//    
//    init(note: Note? = nil, onSave: ((Note) -> Void)? = nil, onShare: ((Note) -> Void)? = nil) {
//        _title = State(initialValue: note?.title ?? "")
//        _content = State(initialValue: note?.content ?? "")
//        self.note = note
//        self.onSave = onSave
//        self.onShare = onShare
//        // 设置状态信息
//        _status = State(initialValue: note == nil ? "Creating New Note: " : "Editing Note: ")
//        
//    }
//    
//    
//
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading, spacing: 16)  {
//                if showMarkdownPreview {
//                        Text(status + (title.isEmpty ? "Untitled" : title) + ".md")
//                            .font(.title3.italic())
//                            .foregroundColor(Color.secondary)
//    //                        .padding()
//                            .frame(maxWidth: .infinity, alignment: .center) // 强制水平居中
//                        
//
//                } else {
//                    if isEditing {
//                        TextField("Enter Title", text: $title)
//                            .font(.title)
//    //                        .padding()
//                            .multilineTextAlignment(.leading) // 强制左对齐
//                            .frame(maxWidth: .infinity, alignment: .leading) // 设置最大宽度并左对齐
//                            .padding([.leading, .trailing]) // 仅左右添加边距
//                    } else {
//                        Text(title.isEmpty ? "Untitled" : title)
//                            .font(.title)
//    //                        .padding()
//                            .multilineTextAlignment(.leading) // 强制左对齐
//                                    .frame(maxWidth: .infinity, alignment: .leading) // 设置最大宽度并左对齐
//                                    .padding([.leading, .trailing]) // 仅左右添加边距
//                    }
//                }
//                
//                
//                if showMarkdownPreview {
//                    ScrollView {
//                        MarkdownRenderer(markdownText: content)
////                            .frame(maxWidth: .infinity, alignment: .leading) // 左对齐
////                            .padding()
//                            .frame(maxWidth: .infinity, alignment: .leading) // 左对齐
//                            .padding([.leading, .trailing]) // 同样仅左右添加边距
//                    }
//                } else {
////                    if isEditing {
//                        TextEditor(text: $content)
//                            .onChange(of: content) { newValue in
//                                saveUndoState()
//                            }
//                            .padding()
//                            .font(.body)
////                    } else {
////                        ScrollView {
////                            MarkdownRenderer(markdownText: content)
////                                .frame(maxWidth: .infinity, alignment: .leading) // 左对齐
////                                .padding()
////                        }
////                    }
//                }
//
////                Spacer()
//            }
//            
//            .toolbar {
//                // 左侧工具栏按钮
//                ToolbarItemGroup(placement: .navigationBarLeading) {
//                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
//                                        Label("Back", systemImage: "chevron.left")
//                                    }
//                    Button(action: undo) {
//                        Image(systemName: "arrow.uturn.backward.circle")
//                            .foregroundColor(undoStack.isEmpty ? .gray : .primary)
//                    }
//                    Button(action: redo) {
//                        Image(systemName: "arrow.uturn.forward.circle")
//                            .foregroundColor(redoStack.isEmpty ? .gray : .primary)
//                    }
//                }
//                
//                // 右侧工具栏按钮
//                ToolbarItemGroup(placement: .navigationBarTrailing) {
////                    Button(action: undo) {
////                        Image(systemName: "arrow.uturn.backward.circle")
////                            .foregroundColor(undoStack.isEmpty ? .gray : .primary)
////                    }
////                    Button(action: redo) {
////                        Image(systemName: "arrow.uturn.forward.circle")
////                            .foregroundColor(redoStack.isEmpty ? .gray : .primary)
////                    }
//                    Button(action: toggleMarkdownPreview) {
//                        Image(systemName: "eye")
//                            .foregroundColor(.primary)
//                    }
//                    Button(action: shareContent) {
//                        Image(systemName: "square.and.arrow.up")
//                            .foregroundColor(.primary)
//                    }
//                    if isEditing {
//                        Button("Done", action: saveNote)
//                            .foregroundColor(.primary)
//                    } else {
//                        Button(action: startEditing) {
//                            Image(systemName: "square.and.pencil")
//                                .foregroundColor(.primary)
//                        }
//                    }
//                }
//            }
////            .navigationBarItems(
////                leading: HStack {
////                    Button(action: undo) {
////                        Image(systemName: "arrow.uturn.backward.circle")
////                            .foregroundColor(undoStack.isEmpty ? .gray : .primary)
////                    }
////                    Button(action: redo) {
////                        Image(systemName: "arrow.uturn.forward.circle")
////                            .foregroundColor(redoStack.isEmpty ? .gray : .primary)
////                    }
////                },
////                trailing: HStack {
////                    Button(action: toggleMarkdownPreview) {
////                        Image(systemName: "eye")
////                            .foregroundColor(.primary)
////                    }
////                    Button(action: shareContent) {
////                        Image(systemName: "square.and.arrow.up")
////                            .foregroundColor(.primary)
////                    }
////                    if isEditing {
////                        Button("Done", action: saveNote)
////                            .foregroundColor(.primary)
////                    } else {
////                        Button(action: startEditing) {
////                            Image(systemName: "ellipsis")
////                                .foregroundColor(.primary)
////                        }
////                    }
////                }
////            )
////            .navigationTitle(note == nil ? "New Note" : "Edit Note")
//
//            .onAppear {
////                if note == nil {
////                    // 如果是新建笔记，进入编辑模式
//                    isEditing = true
////                }
//                
//            }
//        }.navigationBarBackButtonHidden(true)
//    }
//
//    // MARK: - Actions
////    private func saveNote() {
////        let newNote = Note(id: note?.id ?? UUID(), title: title, content: content)
////        onSave?(newNote)
////        isEditing = false
////        presentationMode.wrappedValue.dismiss() // 返回上一页面
////    }
//
//    private var currentNote: Note? {
//        guard !title.isEmpty else { return nil }
//        return Note(id: note?.id ?? UUID(), title: title, content: content)
//    }
//
//    private func saveNote() {
//        if let newNote = currentNote {
//            onSave?(newNote) // 调用保存逻辑
//            isEditing = false
//            presentationMode.wrappedValue.dismiss() // 返回上一页面
//        }
//    }
//    
//    private func startEditing() {
//        isEditing = true
//    }
//
//    private func toggleMarkdownPreview() {
//        showMarkdownPreview.toggle()
//    }
//
//    private func saveUndoState() {
//        undoStack.append(content)
//        redoStack.removeAll()
//    }
//
//    private func undo() {
//        guard !undoStack.isEmpty else { return }
//        redoStack.append(content)
//        content = undoStack.removeLast()
//    }
//
//    private func redo() {
//        guard !redoStack.isEmpty else { return }
//        undoStack.append(content)
//        content = redoStack.removeLast()
//    }
//
//    private func shareContent() {
//        let activityController = UIActivityViewController(activityItems: [content], applicationActivities: nil)
//        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let rootVC = scene.windows.first?.rootViewController {
//            DispatchQueue.main.async {
//                rootVC.present(activityController, animated: true, completion: nil)
//            }
//        }
//    }
//}
//
//
//


import SwiftUI

struct NoteDetailView: View {
    @State private var title: String
    @State private var content: String
    @State private var status: String = ""
    @State private var tags: String = ""
    @State private var showMarkdownPreview = false
    @State private var isEditing = false
    @State private var undoStack: [String] = []
    @State private var redoStack: [String] = []

    @Environment(\.presentationMode) var presentationMode

    var note: Note?
    var onSave: ((Note) -> Void)?
    var onShare: ((Note) -> Void)?

    init(note: Note? = nil, onSave: ((Note) -> Void)? = nil, onShare: ((Note) -> Void)? = nil) {
        _title = State(initialValue: note?.title ?? "")
        _content = State(initialValue: note?.content ?? "")
        _tags = State(initialValue: note?.tags.joined(separator: ", ") ?? "")
        self.note = note
        self.onSave = onSave
        self.onShare = onShare
        _status = State(initialValue: note == nil ? "Creating New Note: " : "Editing Note: ")
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                if showMarkdownPreview {
                    Text(status + (title.isEmpty ? "Untitled" : title) + ".md")
                        .font(.title3.italic())
                        .foregroundColor(Color.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    if isEditing {
                        TextField("Enter Title", text: $title)
                            .font(.title)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading, .trailing])
                        
                        TextField("Enter Tags (comma-separated)", text: $tags)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    } else {
                        Text(title.isEmpty ? "Untitled" : title)
                            .font(.title)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading, .trailing])
                    }
                }

                if showMarkdownPreview {
                    ScrollView {
                        MarkdownRenderer(markdownText: content)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading, .trailing])
                    }
                } else {
                    TextEditor(text: $content)
                        .onChange(of: content) { newValue in
                            saveUndoState()
                        }
                        .padding()
                        .font(.body)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Label("Back", systemImage: "chevron.left")
                    }
                    Button(action: undo) {
                        Image(systemName: "arrow.uturn.backward.circle")
                            .foregroundColor(undoStack.isEmpty ? .gray : .primary)
                    }
                    Button(action: redo) {
                        Image(systemName: "arrow.uturn.forward.circle")
                            .foregroundColor(redoStack.isEmpty ? .gray : .primary)
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
//                    Button(action: toggleMarkdownPreview) {
//                        Image(systemName: "eye")
//                            .foregroundColor(.primary)
//                    }
                    Button(action: toggleMarkdownPreview) {
                        Image(systemName: "eye")
                            .foregroundColor(showMarkdownPreview ? .blue : .primary) // 根据状态改变颜色
                    }
                    Button(action: shareContent) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.primary)
                    }
                    if isEditing {
                        Button("Done", action: saveNote)
                            .foregroundColor(.primary)
                    } else {
                        Button(action: startEditing) {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .onAppear {
                isEditing = note == nil
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - File Management
    private func markdownFilePath(for title: String) -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("\(title).md")
    }

    private func saveMarkdownFile() -> URL? {
        guard !title.isEmpty else {
            print("Error: Title is empty. Cannot save the file.")
            return nil
        }

        let fileURL = markdownFilePath(for: title)
        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
            print("Markdown file saved at: \(fileURL.path)")
            return fileURL
        } catch {
            print("Failed to save markdown file: \(error)")
            return nil
        }
    }

    // MARK: - Actions
//    private var currentNote: Note? {
//            guard !title.isEmpty else { return nil }
//        return Note(id: note?.id ?? UUID(), title: title, content: content, tags: tags)
//        }
    
    private var currentNote: Note? {
        guard !title.isEmpty else { return nil }
        let tagArray = tags.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        return Note(id: note?.id ?? UUID(), title: title, content: content, tags: tagArray)
    }
        
    private func saveNote() {
        if let newNote = currentNote {
            onSave?(newNote)
            isEditing = false
            presentationMode.wrappedValue.dismiss()
        }
    }

    private func shareContent() {
        guard let fileURL = saveMarkdownFile() else { return }
        let activityController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = scene.windows.first?.rootViewController {
            DispatchQueue.main.async {
                rootVC.present(activityController, animated: true, completion: nil)
            }
        }
    }

    private func startEditing() {
        isEditing = true
    }

    private func toggleMarkdownPreview() {
        showMarkdownPreview.toggle()
    }

    private func saveUndoState() {
        undoStack.append(content)
        redoStack.removeAll()
    }

    private func undo() {
        guard !undoStack.isEmpty else { return }
        redoStack.append(content)
        content = undoStack.removeLast()
    }

    private func redo() {
        guard !redoStack.isEmpty else { return }
        undoStack.append(content)
        content = redoStack.removeLast()
    }
}
