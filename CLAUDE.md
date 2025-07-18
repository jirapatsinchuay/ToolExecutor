# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ToolExecutor 是一個 macOS 命令執行工具，使用 SwiftUI 構建，支援雙重執行模式（背景執行和終端執行）。應用程式採用 MVVM 架構，提供狀態欄和主視窗介面。

## Development Commands

### Building and Running
```bash
# 使用 Xcode 打開項目
open ToolExecutor.xcodeproj

# 或使用 xcodebuild 命令行構建
xcodebuild -project ToolExecutor.xcodeproj -scheme ToolExecutor -configuration Release build

# 運行測試
xcodebuild test -project ToolExecutor.xcodeproj -scheme ToolExecutor -destination 'platform=macOS'
```

### Git and Release Management
```bash
# 創建發佈標籤
git tag -a v1.0.1 -m "Release v1.0.1"
git push origin v1.0.1

# 參考 RELEASE_GUIDE.md 瞭解完整的發佈流程
```

### DMG 打包流程
```bash
# 創建專業的 DMG 安裝包
mkdir dmg_template
cp -R ToolExecutor.app dmg_template/
cd dmg_template && ln -s /Applications Applications
hdiutil create -volname "ToolExecutor v1.0.1" -srcfolder dmg_template -format UDRW temp_dmg.dmg
hdiutil attach temp_dmg.dmg
# 使用 AppleScript 設定圖標位置
hdiutil detach "/Volumes/ToolExecutor v1.0.1"
hdiutil convert temp_dmg.dmg -format UDZO -o ToolExecutor-v1.0.1-Final.dmg
```

## Architecture

### Core Components

1. **Models**
   - `CommandModel`: 命令數據模型，包含 id、name、command、createdAt、isEnabled 等屬性
   - `CommandManager`: 命令管理器，負責命令的 CRUD 操作和數據持久化

2. **Controllers**
   - `CommandExecutor`: 命令執行器，處理兩種執行模式
     - 背景執行：使用 Process 直接執行命令
     - 終端執行：使用 AppleScript 在 Terminal.app 中執行
   - `StatusBarController`: 狀態欄控制器，管理系統狀態欄選單

3. **Views**
   - `MainView`: 主視窗，展示命令列表和搜索功能
   - `AddCommandSheet`: 新增命令的彈出視窗
   - `EditCommandSheet`: 編輯命令的彈出視窗

### Data Flow

- 使用 `@EnvironmentObject` 進行依賴注入
- `CommandManager` 使用 `UserDefaults` 進行數據持久化
- 命令執行結果透過 `UNUserNotificationCenter` 顯示系統通知

### Key Features

- **雙重執行模式**: 背景執行用於靜默操作，終端執行用於互動命令
- **狀態欄專用應用**: 使用 `.accessory` 策略，不佔用 Dock 空間
- **動態視窗管理**: 主視圖按需顯示，支援 `.regular` 和 `.accessory` 模式切換
- **AppleScript 集成**: 使用 `osascript` 控制 Terminal.app
- **非沙盒模式**: 應用程式需要完整的系統訪問權限
- **實時搜索**: 支援按名稱和命令內容搜索

## Development Notes

### Permissions and Entitlements
- 應用程式運行在非沙盒模式下（com.apple.security.app-sandbox = false）
- 需要 AppleEvents 權限控制 Terminal.app
- 需要通知權限顯示執行結果

### Sample Commands
項目包含預設的範例命令，包括系統資訊查看、網路測試、磁碟監控等常用系統命令。

### String Handling
- 實現了 `escapingAppleScriptString()` 擴展方法處理 AppleScript 字符串轉義
- 支援多行命令和複雜的 shell 命令

### Testing
- 項目包含基本的單元測試和 UI 測試結構
- 使用標準的 XCTest 框架

## Important Files

- `ToolExecutor.entitlements`: 應用程式權限設定
- `CommandModel.swift`: 核心數據模型和範例命令
- `CommandExecutor.swift`: 命令執行邏輯的核心實現
- `StatusBarController.swift`: 狀態欄整合功能
- `AppDelegate.swift`: 應用程式生命週期和視窗管理
- `RELEASE_GUIDE.md`: 發佈流程指南
- `icon.png`: 應用程式主圖標檔案

## Version History

### v1.0.1 (2025-07-18)
- 更新為狀態欄專用應用 (NSApp.setActivationPolicy(.accessory))
- 實現動態視窗顯示/隱藏機制
- 更新應用程式圖標為重新裁切版本
- 改進 DMG 打包流程，提供拖拽安裝體驗

### v1.0.0 (2025-07-18)
- 初始版本發佈
- 實現雙重執行模式
- 完整的命令管理功能