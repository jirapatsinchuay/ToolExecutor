import SwiftUI

struct AddCommandSheet: View {
    @ObservedObject var commandManager: CommandManager
    @Binding var isPresented: Bool
    @State private var name = ""
    @State private var command = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Title Bar
            HStack {
                Text("新增命令")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("✕") {
                    isPresented = false
                }
                .buttonStyle(.plain)
                .foregroundColor(.secondary)
                .font(.system(size: 16, weight: .medium))
                .frame(width: 24, height: 24)
                .background(Circle().fill(.quaternary))
                .contentShape(Circle())
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 10)
            
            Divider()
            
            // Content
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("為你的工具命令添加一個易記的名稱")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("命令名稱")
                        .font(.headline)
                    
                    TextField("例如：開啟終端機", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .font(.system(size: 16))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("命令內容")
                        .font(.headline)
                    
                    TextField("例如：open -a Terminal", text: $command)
                        .textFieldStyle(.roundedBorder)
                        .font(.system(size: 16, design: .monospaced))
                }
                
                Spacer()
                
                // Buttons
                HStack {
                    Button("取消") {
                        isPresented = false
                    }
                    .keyboardShortcut(.cancelAction)
                    
                    Spacer()
                    
                    Button("新增") {
                        let newCommand = CommandModel(
                            name: name,
                            command: command,
                            isEnabled: true
                        )
                        commandManager.addCommand(newCommand)
                        isPresented = false
                    }
                    .keyboardShortcut(.defaultAction)
                    .buttonStyle(.borderedProminent)
                    .disabled(name.isEmpty || command.isEmpty)
                }
            }
            .padding(20)
        }
        .frame(width: 450, height: 400)
        .background(.regularMaterial)
    }
}

#Preview {
    AddCommandSheet(
        commandManager: CommandManager(),
        isPresented: .constant(true)
    )
}