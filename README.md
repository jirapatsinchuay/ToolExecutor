# ToolExecutor

一個優雅的 macOS 命令執行工具，讓你能夠快速管理和執行常用的系統命令。

## 🌟 特色功能

- **🎯 快速執行**: 一鍵執行預設的系統命令
- **📋 命令管理**: 輕鬆新增、編輯、刪除和排序你的命令
- **🔧 狀態列整合**: 直接從 macOS 狀態列快速存取你的命令
- **💾 資料持久化**: 自動儲存你的命令設定
- **🔔 通知回饋**: 執行結果即時通知
- **🎨 現代化介面**: 採用 SwiftUI 設計，支援毛玻璃效果和現代化視覺設計
- **🔒 安全執行**: 沙盒環境中安全執行命令

## 📱 界面截圖

### 主界面
- 清晰的命令卡片佈局
- 搜尋功能
- 一鍵執行、編輯、刪除
- 命令啟用/停用切換

### 狀態列選單
- 快速訪問啟用的命令
- 顯示主視圖選項
- 乾淨的選單設計

## 🚀 安裝方式

### 方式一：下載預編譯版本
1. 前往 [Releases](../../releases) 頁面
2. 下載最新版本的 `.app` 文件
3. 將 `ToolExecutor.app` 拖拽到 Applications 資料夾
4. 首次啟動時，可能需要在系統偏好設定中允許應用程式運行

### 方式二：從原始碼建置
1. 克隆此儲存庫：
   ```bash
   git clone https://github.com/your-username/ToolExecutor.git
   cd ToolExecutor
   ```

2. 使用 Xcode 開啟：
   ```bash
   open ToolExecutor.xcodeproj
   ```

3. 在 Xcode 中建置並運行 (⌘+R)

## 💡 使用方法

### 基本操作
1. **新增命令**: 點擊主界面右上角的 "+" 按鈕
2. **執行命令**: 點擊命令卡片中的 "執行" 按鈕
3. **編輯命令**: 點擊命令卡片中的 "編輯" 按鈕
4. **刪除命令**: 點擊命令卡片中的 "刪除" 按鈕（會顯示確認對話框）
5. **啟用/停用命令**: 點擊命令卡片右上角的圓形圖示

### 狀態列功能
- 點擊狀態列中的應用程式圖示查看啟用的命令
- 直接從狀態列選單執行命令
- 點擊 "顯示主視圖" 開啟主應用程式界面

### 搜尋功能
- 在搜尋欄中輸入關鍵字
- 支援命令名稱和命令內容的搜尋
- 即時篩選結果

## 🔧 系統需求

- macOS 15.5 或更高版本
- Apple Silicon (M1/M2) 或 Intel 處理器

## 📦 建置需求

如果你想要從原始碼建置此專案：

- Xcode 15.0 或更高版本
- Swift 5.9 或更高版本
- macOS 15.5 SDK

## 🏗️ 專案結構

```
ToolExecutor/
├── ToolExecutor/
│   ├── ToolExecutorApp.swift          # 主應用程式入口
│   ├── AppDelegate.swift              # 應用程式委派
│   ├── Models/
│   │   ├── CommandModel.swift         # 命令資料模型
│   │   └── CommandManager.swift       # 命令管理器
│   ├── Views/
│   │   ├── MainView.swift             # 主界面視圖
│   │   ├── AddCommandSheet.swift      # 新增命令視圖
│   │   └── EditCommandSheet.swift     # 編輯命令視圖
│   ├── Controllers/
│   │   ├── StatusBarController.swift  # 狀態列控制器
│   │   └── CommandExecutor.swift      # 命令執行器
│   ├── Assets.xcassets/               # 應用程式資源
│   └── ToolExecutor.entitlements      # 應用程式權限
├── README.md
└── .gitignore
```

## 🔐 權限說明

此應用程式需要以下權限：
- **Shell 任務執行**: 用於執行你新增的命令
- **檔案讀寫**: 用於儲存和讀取命令設定
- **通知**: 用於顯示執行結果通知

所有權限都在沙盒環境中受到限制，確保系統安全。

## 🛡️ 安全性

- 所有命令都在受限的沙盒環境中執行
- 使用 UserDefaults 安全儲存命令設定
- 不會收集或傳輸任何個人資料

## 📋 常見問題

**Q: 為什麼某些命令無法執行？**
A: 由於沙盒限制，某些系統級命令可能無法執行。請確保你的命令符合 macOS 安全政策。

**Q: 如何備份我的命令？**
A: 命令儲存在 UserDefaults 中。你可以使用 macOS 的時間機器或其他備份工具來備份你的設定。

**Q: 應用程式支援多語言嗎？**
A: 目前主要支援繁體中文界面。

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

---

**🔧 使用 [Claude Code](https://claude.ai/code) 開發**