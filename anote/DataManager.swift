import Foundation

class DataManager {
    static let shared = DataManager()  // 使用单例模式，方便在应用中共享实例
    private let notesKey = "notes"     // 存储笔记的键

    // 保存笔记数据到 UserDefaults
    func save(notes: [Note]) {
        if let data = try? JSONEncoder().encode(notes) {  // 编码笔记为 Data
            UserDefaults.standard.set(data, forKey: notesKey)  // 保存到 UserDefaults
        }
    }

    // 从 UserDefaults 加载笔记数据
    func load() -> [Note] {
        guard let data = UserDefaults.standard.data(forKey: notesKey),  // 从 UserDefaults 获取数据
              let notes = try? JSONDecoder().decode([Note].self, from: data) else {  // 解码数据为笔记数组
            return []
        }
        return notes  // 返回笔记列表
    }
}
