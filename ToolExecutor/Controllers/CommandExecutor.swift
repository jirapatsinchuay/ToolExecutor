import Foundation
import UserNotifications

class CommandExecutor: ObservableObject {
    
    init() {
        requestNotificationPermission()
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("通知權限請求失敗: \(error)")
            }
        }
    }
    
    // 新增：在終端中執行命令
    func executeCommandInTerminal(_ command: CommandModel) {
        guard command.isEnabled else { return }
        
        let appleScript = """
        tell application "Terminal"
            activate
            do script "\(command.command.escapingAppleScriptString())"
        end tell
        """
        
        let task = Process()
        task.launchPath = "/usr/bin/osascript"
        task.arguments = ["-e", appleScript]
        
        do {
            try task.run()
            showNotification(
                title: "命令已發送到終端",
                message: "「\(command.name)」已在終端中執行",
                isError: false
            )
        } catch {
            showNotification(
                title: "無法開啟終端",
                message: "發送命令「\(command.name)」到終端失敗: \(error.localizedDescription)",
                isError: true
            )
        }
    }
    
    func executeCommand(_ command: CommandModel) {
        guard command.isEnabled else { return }
        
        let task = Process()
        let pipe = Pipe()
        let errorPipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = errorPipe
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", command.command]
        
        do {
            try task.run()
            
            DispatchQueue.global(qos: .background).async {
                task.waitUntilExit()
                
                let outputData = pipe.fileHandleForReading.readDataToEndOfFile()
                let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
                
                let output = String(data: outputData, encoding: .utf8) ?? ""
                let errorOutput = String(data: errorData, encoding: .utf8) ?? ""
                
                DispatchQueue.main.async {
                    self.handleCommandResult(
                        command: command,
                        exitCode: task.terminationStatus,
                        output: output,
                        error: errorOutput
                    )
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.showNotification(
                    title: "命令執行失敗",
                    message: "無法執行命令「\(command.name)」: \(error.localizedDescription)",
                    isError: true
                )
            }
        }
    }
    
    private func handleCommandResult(command: CommandModel, exitCode: Int32, output: String, error: String) {
        if exitCode == 0 {
            if !output.isEmpty {
                showNotification(
                    title: "命令執行成功",
                    message: "「\(command.name)」已執行完成",
                    isError: false
                )
            } else {
                showNotification(
                    title: "命令執行完成",
                    message: "「\(command.name)」已成功執行",
                    isError: false
                )
            }
        } else {
            let errorMessage = error.isEmpty ? "命令執行失敗 (退出碼: \(exitCode))" : error
            showNotification(
                title: "命令執行失敗",
                message: "「\(command.name)」執行失敗: \(errorMessage)",
                isError: true
            )
        }
    }
    
    private func showNotification(title: String, message: String, isError: Bool) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = isError ? .defaultCritical : .default
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("通知發送失敗: \(error)")
            }
        }
    }
}

// 擴展 String 來處理 AppleScript 字符串轉義
extension String {
    func escapingAppleScriptString() -> String {
        return self
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
    }
}