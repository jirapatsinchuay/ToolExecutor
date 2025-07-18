import Cocoa
import SwiftUI
import Combine

class StatusBarController: NSObject, ObservableObject {
    private var statusItem: NSStatusItem?
    private var commandManager: CommandManager
    private var commandExecutor: CommandExecutor
    
    init(commandManager: CommandManager, commandExecutor: CommandExecutor) {
        self.commandManager = commandManager
        self.commandExecutor = commandExecutor
        super.init()
        setupStatusItem()
        setupObservers()
    }
    
    private func setupStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "doc.text.magnifyingglass", accessibilityDescription: "ToolExecutor")
            button.image?.size = NSSize(width: 16, height: 16)
            button.image?.isTemplate = true
        }
        
        updateMenu()
    }
    
    private func setupObservers() {
        commandManager.objectWillChange.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.updateMenu()
            }
        }.store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private func updateMenu() {
        let menu = NSMenu()
        
        let enabledCommands = commandManager.enabledCommands
        
        if enabledCommands.isEmpty {
            let noCommandsItem = NSMenuItem(title: "沒有可用的命令", action: nil, keyEquivalent: "")
            noCommandsItem.isEnabled = false
            menu.addItem(noCommandsItem)
        } else {
            for command in enabledCommands {
                let menuItem = NSMenuItem(
                    title: command.name,
                    action: #selector(executeCommand(_:)),
                    keyEquivalent: ""
                )
                menuItem.target = self
                menuItem.representedObject = command
                menu.addItem(menuItem)
            }
        }
        
        menu.addItem(NSMenuItem.separator())
        
        let showMainViewItem = NSMenuItem(title: "顯示主視圖", action: #selector(showMainView), keyEquivalent: "")
        showMainViewItem.target = self
        menu.addItem(showMainViewItem)
        
        menu.addItem(NSMenuItem.separator())
        
        let quitItem = NSMenuItem(title: "結束應用程式", action: #selector(quit), keyEquivalent: "q")
        quitItem.target = self
        menu.addItem(quitItem)
        
        statusItem?.menu = menu
    }
    
    @objc private func executeCommand(_ sender: NSMenuItem) {
        guard let command = sender.representedObject as? CommandModel else { return }
        commandExecutor.executeCommand(command)
    }
    
    @objc private func showMainView() {
        // 顯示主視圖
        if let window = NSApplication.shared.windows.first {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
        }
    }
    
    @objc private func quit() {
        NSApplication.shared.terminate(nil)
    }
    
    deinit {
        statusItem = nil
    }
}