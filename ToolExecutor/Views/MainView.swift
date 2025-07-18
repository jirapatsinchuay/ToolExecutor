import SwiftUI

struct MainView: View {
    @EnvironmentObject var commandManager: CommandManager
    @EnvironmentObject var commandExecutor: CommandExecutor
    @State private var showingAddCommand = false
    @State private var searchText = ""
    @State private var editingCommand: CommandModel?
    @State private var showingDeleteAlert = false
    @State private var commandToDelete: CommandModel?
    
    var filteredCommands: [CommandModel] {
        if searchText.isEmpty {
            return commandManager.commands
        } else {
            return commandManager.commands.filter { command in
                command.name.localizedCaseInsensitiveContains(searchText) ||
                command.command.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
                // Header
                VStack(spacing: 20) {
                    HStack {
                        // 使用文件圖示作為主圖示
                        Image(systemName: "doc.text.magnifyingglass")
                            .font(.system(size: 36))
                            .foregroundStyle(.linearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("ToolExecutor")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(.linearGradient(colors: [.primary, .secondary], startPoint: .leading, endPoint: .trailing))
                            
                            Text("快速執行你的命令工具")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            showingAddCommand = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.linearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .background(
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .frame(width: 36, height: 36)
                                )
                        }
                        .buttonStyle(.borderless)
                    }
                    .padding(.horizontal, 24)
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                            .font(.system(size: 16, weight: .medium))
                        
                        TextField("搜尋命令...", text: $searchText)
                            .textFieldStyle(.plain)
                            .font(.system(size: 16))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.ultraThinMaterial)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.quaternary, lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 24)
                }
                .padding(.top, 20)
                .padding(.bottom, 16)
                .background(Color(.windowBackgroundColor))
                
                Divider()
                
                // Commands Grid
                ScrollView {
                    if filteredCommands.isEmpty {
                        VStack(spacing: 24) {
                            Image(systemName: searchText.isEmpty ? "doc.text.magnifyingglass" : "magnifyingglass")
                                .font(.system(size: 64))
                                .foregroundStyle(.linearGradient(colors: [.blue.opacity(0.3), .purple.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            
                            VStack(spacing: 8) {
                                Text(searchText.isEmpty ? "還沒有任何命令" : "找不到符合的命令")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                
                                Text(searchText.isEmpty ? "開始新增你的第一個命令工具" : "嘗試不同的搜尋關鍵字")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            
                            if searchText.isEmpty {
                                Button("新增第一個命令") {
                                    showingAddCommand = true
                                }
                                .buttonStyle(.borderedProminent)
                                .controlSize(.large)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(40)
                    } else {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16)
                        ], spacing: 16) {
                            ForEach(filteredCommands) { command in
                                CommandCard(
                                    command: command,
                                    onExecute: {
                                        commandExecutor.executeCommand(command)
                                    },
                                    onEdit: {
                                        editingCommand = command
                                    },
                                    onDelete: {
                                        commandToDelete = command
                                        showingDeleteAlert = true
                                    },
                                    onToggle: {
                                        commandManager.toggleCommand(command)
                                    }
                                )
                            }
                        }
                        .padding()
                    }
                }
                .background(Color(.controlBackgroundColor))
            }
        .sheet(isPresented: $showingAddCommand) {
            AddCommandSheet(
                commandManager: commandManager,
                isPresented: $showingAddCommand
            )
        }
        .sheet(item: $editingCommand) { command in
            EditCommandSheet(
                commandManager: commandManager,
                command: command,
                isPresented: Binding(
                    get: { editingCommand != nil },
                    set: { if !$0 { editingCommand = nil } }
                )
            )
        }
        .alert("確認刪除", isPresented: $showingDeleteAlert) {
            Button("取消", role: .cancel) { }
            Button("刪除", role: .destructive) {
                if let command = commandToDelete {
                    commandManager.deleteCommand(command)
                }
            }
        } message: {
            Text("確定要刪除命令「\(commandToDelete?.name ?? "")」嗎？")
        }
    }
}

struct CommandCard: View {
    let command: CommandModel
    let onExecute: () -> Void
    let onEdit: () -> Void
    let onDelete: () -> Void
    let onToggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(command.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(command.isEnabled ? .primary : .secondary)
                    
                    Text(command.command)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.tertiary.opacity(0.3))
                        )
                }
                
                Spacer()
                
                Button(action: onToggle) {
                    Image(systemName: command.isEnabled ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                        .foregroundColor(command.isEnabled ? .green : .gray)
                }
                .buttonStyle(.borderless)
            }
            
            Divider()
                .opacity(0.5)
            
            HStack {
                Button(action: {
                    if command.isEnabled {
                        onExecute()
                    }
                }) {
                    HStack {
                        Image(systemName: "play.fill")
                            .font(.system(size: 12))
                        Text("執行")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!command.isEnabled)
                
                Button(action: onEdit) {
                    HStack {
                        Image(systemName: "pencil")
                            .font(.system(size: 12))
                        Text("編輯")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                .buttonStyle(.bordered)
                
                Button(action: onDelete) {
                    HStack {
                        Image(systemName: "trash")
                            .font(.system(size: 12))
                        Text("刪除")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                .buttonStyle(.bordered)
                .foregroundColor(.red)
                
                Spacer()
                
                Text(command.createdAt, style: .date)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.quaternary, lineWidth: 1)
        )
        .opacity(command.isEnabled ? 1.0 : 0.6)
    }
}

#Preview {
    MainView()
        .environmentObject(CommandManager())
        .environmentObject(CommandExecutor())
}