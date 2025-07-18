# ToolExecutor

一個優雅的 macOS 命令執行工具，支援雙重執行模式，讓命令行工具的使用變得更加簡單高效！

![ToolExecutor](icon.png)

## 📥 下载

[⬇️ 下载 ToolExecutor v1.0.2 (DMG)](https://github.com/panhyer36/ToolExecutor/releases/download/v1.0.2/ToolExecutor-v1.0.2-ESC.dmg)

## ✨ 主要功能

### 🚀 雙重執行模式
- **背景執行**：在後台靜默執行命令，通過系統通知查看結果
- **終端執行**：在 Terminal.app 中執行命令，實時查看輸出和互動

### 🎯 直觀的管理介面
- 現代化的 SwiftUI 界面設計
- 可視化的命令管理（新增、編輯、刪除）
- 即時搜尋和篩選功能
- 一鍵啟用/停用命令

### ⚡ 便捷的狀態欄操作
- 系統狀態欄快速存取，不佔用 Dock 空間
- 每個命令都提供背景執行和終端執行選項
- 支援子菜單操作
- 狀態欄專用應用，主視圖按需顯示

### 🔧 豐富的預設命令
- 開啟終端機
- 查看系統資訊和進程
- 網路連接測試
- 磁碟和記憶體使用情況
- 進程監控等實用工具

## 📱 使用方式

### 安裝
1. 下載 `ToolExecutor-v1.0.2-ESC.dmg` 文件
2. 雙擊打開 DMG 文件
3. 將 ToolExecutor.app 拖拽到 Applications 文件夾
4. 首次啟動時右鍵點擊選擇「打開」

### 主界面操作
1. **新增命令**：點擊右上角的 "+" 按鈕
2. **執行命令**：選擇 "背景執行" 或 "終端執行"
   - **背景執行**：適合需要靜默運行的命令
   - **終端執行**：適合需要查看輸出或互動的命令
3. **編輯命令**：點擊命令卡片的 "編輯" 按鈕
4. **搜尋命令**：使用頂部的搜尋欄快速找到命令

### 狀態欄快速存取
1. 點擊狀態欄中的 ToolExecutor 圖示
2. 選擇要執行的命令
3. 在子菜單中選擇執行方式：
   - **背景執行**：直接在後台運行
   - **在終端執行**：在 Terminal.app 中打開執行
4. 點擊「顯示主視圖」可打開完整的管理界面
5. **快速關閉**：在主視圖中按下 ESC 鍵可快速關閉視窗

## 🔧 系統需求

- macOS 15.5 或更高版本
- Apple Silicon (M1/M2/M3) 或 Intel 處理器

## 🛡️ 安全權限

應用程式需要以下權限：
- **AppleEvents 控制權限**：用於控制 Terminal.app
- **Shell 任務執行權限**：用於後台執行命令
- **通知權限**：用於顯示執行結果

首次使用時，系統可能會要求您授權 ToolExecutor 控制其他應用程式。

## 💻 技術特點

- 使用 **SwiftUI** 構建的現代化界面
- **AppleScript** 集成，完美控制 Terminal.app
- **非沙盒模式**，確保終端執行功能正常運作
- 命令歷史和狀態管理
- 支援複雜的多行命令
- 本地數據存儲，保護隱私安全

## 🚀 功能演示

### 雙重執行模式
```bash
# 背景執行示例
系統資訊查看 → 後台運行 → 通知顯示結果

# 終端執行示例
網路測試 → Terminal.app 打開 → 實時查看 ping 輸出
```

### 狀態欄集成
- 快速訪問常用命令
- 無需打開主界面
- 支援鍵盤快捷鍵

## 📝 更新日誌

### v1.0.2 (2025-07-18)
- ⌨️ 新增 ESC 按鍵快速關閉主視圖功能
- 🔧 修復「顯示主視圖」功能，確保視窗正確創建和顯示
- 🛠️ 改進視窗生命週期管理，支援視窗重複使用
- 🎯 提升用戶體驗，支援鍵盤快捷鍵操作
- 📦 更新 DMG 安裝包為 v1.0.2 版本

### v1.0.1 (2025-07-18)
- 🎨 更新應用程式圖標，更加美觀統一
- 🔧 改進為狀態欄專用應用，不佔用 Dock 空間
- 📦 重新設計 DMG 安裝包，提供拖拽安裝體驗
- 🛠️ 優化主視圖顯示/隱藏機制
- 📝 更新項目文檔和開發指南

### v1.0.0 (2025-07-18)
- 🎉 首次發布
- ✅ 雙重執行模式實現
- ✅ 完整的命令管理功能
- ✅ 狀態欄集成
- ✅ 非沙盒模式，解決權限問題
- ✅ 包含安全的預設系統命令

## ⚠️ 注意事項

- 執行命令前請確保了解命令的作用
- 某些系統級命令可能需要管理員權限
- 建議先使用 "終端執行" 模式測試新命令
- 應用程式會自動保存您的命令設定
- 此版本為非沙盒模式，確保功能完整性

## 🏗️ 開發

### 建置需求
- Xcode 15.0 或更高版本
- Swift 5.9 或更高版本
- macOS 15.5 SDK

### 專案結構
```
ToolExecutor/
├── ToolExecutor/
│   ├── Controllers/
│   │   ├── CommandExecutor.swift      # 命令執行器
│   │   └── StatusBarController.swift  # 狀態欄控制器
│   ├── Models/
│   │   ├── CommandModel.swift         # 命令資料模型
│   │   └── CommandManager.swift       # 命令管理器
│   ├── Views/
│   │   ├── MainView.swift             # 主界面視圖
│   │   ├── AddCommandSheet.swift      # 新增命令視圖
│   │   └── EditCommandSheet.swift     # 編輯命令視圖
│   └── Assets.xcassets/               # 應用程式資源
├── README.md
└── RELEASE_GUIDE.md
```

### 本地開發
```bash
git clone https://github.com/您的用户名/ToolExecutor.git
cd ToolExecutor
open ToolExecutor.xcodeproj
```

## 🤝 貢獻

歡迎提交 Issue 和 Pull Request！

1. Fork 此專案
2. 創建你的功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 開啟 Pull Request

## 📄 授權

此專案採用 MIT 授權 - 請查看 [LICENSE](LICENSE) 文件以獲得詳細資訊。

## 🙏 致謝

- 感謝 SwiftUI 社群的靈感和資源
- 感謝所有測試用戶的反饋
- 使用 Claude AI 協助開發

## 📞 支援

如有問題或建議，請：
- 開啟 [GitHub Issue](https://github.com/panhyer36/ToolExecutor/issues)
- 聯繫開發者

---

**🔧 使用 SwiftUI 和 AppleScript 打造的現代化 macOS 命令執行工具**