//
//  ToolExecutorApp.swift
//  ToolExecutor
//
//  Created by p304 on 2025/7/18.
//

import SwiftUI

@main
struct ToolExecutorApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appDelegate.commandManager)
                .environmentObject(appDelegate.commandExecutor)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        .defaultSize(width: 800, height: 600)
        
        Settings {
            EmptyView()
        }
    }
}
