import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    static var shared: AppDelegate!
    
    private var statusBarController: StatusBarController?
    
    @Published var commandManager = CommandManager()
    @Published var commandExecutor = CommandExecutor()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        AppDelegate.shared = self
        
        statusBarController = StatusBarController(
            commandManager: commandManager,
            commandExecutor: commandExecutor
        )
        
        // 設定為一般應用程式，允許主視圖顯示
        NSApp.setActivationPolicy(.regular)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        statusBarController = nil
    }
}