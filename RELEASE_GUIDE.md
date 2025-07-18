# GitHub Release 发布指南

## 📋 准备工作

### 1. 确保所有文件已提交
```bash
git add .
git commit -m "Release v1.0.0: ToolExecutor with dual execution modes"
git push origin main
```

### 2. 创建版本标签
```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

## 🚀 在 GitHub 上创建 Release

### 步骤 1: 访问 GitHub 仓库
1. 打开您的 GitHub 仓库页面
2. 点击右侧的 **"Releases"** 选项卡

### 步骤 2: 创建新的 Release
1. 点击 **"Create a new release"** 按钮
2. 在 **"Tag version"** 字段中输入: `v1.0.0`
3. 在 **"Release title"** 字段中输入: `ToolExecutor v1.0.0`

### 步骤 3: 编写 Release 说明
建议使用以下模板：

```markdown
# ToolExecutor v1.0.0

一個優雅的 macOS 命令執行工具，支援雙重執行模式。

## ✨ 主要功能

- **🚀 雙重執行模式**
  - 背景執行：靜默運行，通過系統通知查看結果
  - 終端執行：在 Terminal.app 中執行，實時查看輸出和互動

- **🎯 直觀的管理介面**
  - 現代化的 SwiftUI 界面設計
  - 可視化的命令管理（新增、編輯、刪除）
  - 即時搜尋和篩選功能
  - 一鍵啟用/停用命令

- **⚡ 便捷的狀態欄操作**
  - 系統狀態欄快速存取
  - 每個命令都提供背景執行和終端執行選項
  - 支援子菜單操作

- **🔧 豐富的預設命令**
  - 系統資訊查看
  - 網路連接測試
  - 磁碟和記憶體使用情況
  - 進程監控等實用工具

## 📥 安裝方式

1. 下載 `ToolExecutor.dmg` 文件
2. 雙擊打開 DMG 文件
3. 將 ToolExecutor.app 拖拽到 Applications 文件夾
4. 首次啟動時右鍵點擊選擇「打開」

## 🔧 系統需求

- macOS 15.5 或更高版本
- Apple Silicon (M1/M2/M3) 或 Intel 處理器

## 📝 更新日誌

### v1.0.0 (2025-07-18)
- 🎉 首次發布
- ✅ 雙重執行模式實現
- ✅ 完整的命令管理功能
- ✅ 狀態欄集成
- ✅ 非沙盒模式，解決權限問題

## 🛡️ 安全說明

此版本為非沙盒模式，以確保終端執行功能正常運作。應用程式僅在本地運行，不會收集或傳輸任何個人資料。

## 🙏 致謝

感謝所有測試用戶的反饋和建議！
```

### 步骤 4: 上传 DMG 文件
1. 在 **"Attach binaries"** 区域，点击 **"choose your files"**
2. 选择 `/Users/p304/Documents/Swift/ToolExecutor/ToolExecutor.dmg`
3. 等待文件上传完成

### 步骤 5: 发布设置
- ✅ 勾选 **"Set as the latest release"**
- ❌ 不要勾选 **"Set as a pre-release"**（除非这是测试版本）

### 步骤 6: 发布
点击 **"Publish release"** 按钮完成发布

## 📱 发布后的操作

### 1. 更新 README.md
在项目的 README.md 中添加下载链接：

```markdown
## 📥 下载

[⬇️ 下载 ToolExecutor v1.0.0 (DMG)](https://github.com/你的用户名/ToolExecutor/releases/download/v1.0.0/ToolExecutor.dmg)
```

### 2. 社交媒体宣传
- 在 Twitter、LinkedIn 等平台分享您的项目
- 考虑在相关的 macOS 开发社区分享

### 3. 收集用户反馈
- 鼓励用户在 GitHub Issues 中报告问题
- 考虑添加用户反馈收集机制

## 🔄 后续版本发布

对于后续版本，重复以上步骤，但需要：
1. 更新版本号（如 v1.1.0）
2. 更新 Release 说明
3. 重新构建 DMG 文件
4. 创建新的 Git 标签

## 💡 提示

- 确保 DMG 文件在不同 macOS 版本上都能正常工作
- 考虑添加自动更新机制
- 定期更新依赖和安全补丁
- 保持 Release 说明的详细和专业性 