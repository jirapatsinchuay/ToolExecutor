import Foundation

struct CommandModel: Codable, Identifiable, Equatable {
    let id: UUID
    var name: String
    var command: String
    let createdAt: Date
    var isEnabled: Bool
    
    init(name: String, command: String, isEnabled: Bool = true) {
        self.id = UUID()
        self.name = name
        self.command = command
        self.createdAt = Date()
        self.isEnabled = isEnabled
    }
    
    mutating func updateName(_ newName: String) {
        self.name = newName
    }
    
    mutating func updateCommand(_ newCommand: String) {
        self.command = newCommand
    }
    
    mutating func toggleEnabled() {
        self.isEnabled.toggle()
    }
    
    static func == (lhs: CommandModel, rhs: CommandModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension CommandModel {
    static let sampleCommands = [
        CommandModel(name: "開啟終端機", command: "open -a Terminal"),
        CommandModel(name: "查看系統資訊", command: "system_profiler SPHardwareDataType"),
        CommandModel(name: "清理垃圾桶", command: "rm -rf ~/.Trash/*"),
        CommandModel(name: "查看目前目錄", command: "pwd && ls -la"),
        CommandModel(name: "查看系統進程", command: "top -l 1 | head -20"),
        CommandModel(name: "網路連接測試", command: "ping -c 4 google.com"),
        CommandModel(name: "磁碟使用情況", command: "df -h"),
        CommandModel(name: "記憶體使用情況", command: "vm_stat"),
        CommandModel(name: "查看正在運行的應用", command: "ps aux | grep -v grep | head -10"),
        CommandModel(name: "開啟系統偏好設定", command: "open /System/Applications/System\\ Preferences.app")
    ]
}