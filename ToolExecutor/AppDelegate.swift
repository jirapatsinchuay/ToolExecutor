import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject, NSWindowDelegate {
    static var shared: AppDelegate!
    
    private var statusBarController: StatusBarController?
    private var mainWindow: NSWindow?
    
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
        
        // 如果視窗已經存在，直接顯示
        if let window = mainWindow {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }
        
        // 嘗試找到現有視窗
        if let existingWindow = NSApplication.shared.windows.first {
            mainWindow = existingWindow
            existingWindow.delegate = self
            existingWindow.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }
        
        // 創建新視窗
        createMainWindow()
    }
    
    private func createMainWindow() {
        // 創建主視圖
        let mainView = MainView()
            .environmentObject(commandManager)
            .environmentObject(commandExecutor)
        
        // 創建視窗
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 800, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        
        window.title = "ToolExecutor"
        window.contentView = NSHostingView(rootView: mainView)
        window.delegate = self
        window.center()
        window.makeKeyAndOrderFront(nil)
        
        // 保存視窗引用
        mainWindow = window
        
        // 激活應用程式
        NSApp.activate(ignoringOtherApps: true)
    }
    
    func hideMainWindow() {
        // 切換回狀態欄應用模式，從 Dock 中隱藏
        NSApp.setActivationPolicy(.accessory)
    }
    
    func closeMainWindow() {
        // 關閉主視窗
        mainWindow?.close()
        // 切換回狀態欄應用模式
        hideMainWindow()
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
        // 不要釋放視窗，以便重複使用
        if let window = notification.object as? NSWindow, window == mainWindow {
            // 視窗即將關閉，但保留引用以便重複使用
        }
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        statusBarController = nil
    }
}