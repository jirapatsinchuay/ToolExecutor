import Foundation
import Combine

class CommandManager: ObservableObject {
    @Published var commands: [CommandModel] = []
    
    private let userDefaults = UserDefaults.standard
    private let commandsKey = "SavedCommands"
    
    init() {
        loadCommands()
    }
    
    func loadCommands() {
        if let data = userDefaults.data(forKey: commandsKey),
           let decodedCommands = try? JSONDecoder().decode([CommandModel].self, from: data) {
            commands = decodedCommands
        } else {
            commands = CommandModel.sampleCommands
            saveCommands()
        }
    }
    
    func saveCommands() {
        if let encoded = try? JSONEncoder().encode(commands) {
            userDefaults.set(encoded, forKey: commandsKey)
        }
    }
    
    func addCommand(_ command: CommandModel) {
        commands.append(command)
        saveCommands()
    }
    
    func updateCommand(_ command: CommandModel) {
        if let index = commands.firstIndex(where: { $0.id == command.id }) {
            commands[index] = command
            saveCommands()
        }
    }
    
    func deleteCommand(_ command: CommandModel) {
        commands.removeAll { $0.id == command.id }
        saveCommands()
    }
    
    func deleteCommands(at offsets: IndexSet) {
        commands.remove(atOffsets: offsets)
        saveCommands()
    }
    
    func moveCommands(from source: IndexSet, to destination: Int) {
        commands.move(fromOffsets: source, toOffset: destination)
        saveCommands()
    }
    
    func toggleCommand(_ command: CommandModel) {
        if let index = commands.firstIndex(where: { $0.id == command.id }) {
            commands[index].isEnabled.toggle()
            saveCommands()
        }
    }
    
    var enabledCommands: [CommandModel] {
        commands.filter { $0.isEnabled }
    }
}