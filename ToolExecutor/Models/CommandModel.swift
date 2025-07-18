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
        CommandModel(name: "清理垃圾桶", command: "rm -rf ~/.Trash/*")
    ]
}