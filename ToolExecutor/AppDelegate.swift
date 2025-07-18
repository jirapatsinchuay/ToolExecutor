import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject, NSWindowDelegate {
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
        
        // 設定為狀態欄應用，不在 Dock 中顯示
        NSApp.setActivationPolicy(.accessory)
    }
    
    func showMainWindow() {
        // 切換到一般應用程式模式，顯示在 Dock 中
        NSApp.setActivationPolicy(.regular)
        
        // 顯示主視圖
        if let window = NSApplication.shared.windows.first {
            window.delegate = self
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
        }
    }
    
    func hideMainWindow() {
        // 切換回狀態欄應用模式，從 Dock 中隱藏
        NSApp.setActivationPolicy(.accessory)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
    
    func applicationDidHide(_ notification: Notification) {
        // 當主視圖隱藏時，切換回狀態欄模式
        hideMainWindow()
    }
    
    // MARK: - NSWindowDelegate
    func windowWillClose(_ notification: Notification) {
        // 當視窗關閉時，切換回狀態欄模式
        hideMainWindow()
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        statusBarController = nil
    }
}