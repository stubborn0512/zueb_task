# HarmonyHomework 最终归档

本目录保存本会话最后一次提供的 HarmonyOS 作业工程源码、配置、PNG 图标、作业说明和修复记录。

## 作业组成
- 作业一：Gesture：TapGesture 双击缩放、PinchGesture 双指捏合、PanGesture 侧滑删除与控件拖拽。
- 作业二：商品列表 Tab、每个 Tab 5 条本地模拟商品、登录与购买提示。
- 作业三：Preferences 初始化、存储、读取、删除以及 `flush()` 数据落盘。

## 目录
- `entry/src/main/ets/pages/Index.ets`：完整综合作业主页面，包含三项作业相关演示。
- `AppScope/`：应用级配置及图标素材。
- `entry/`：模块配置、能力入口和页面资源。
- `作业拆分说明/`：按作业分开的索引说明。
- `scripts/`：环境检查和配置修复脚本。
- `修复说明-00303038.txt`：本会话末次配置修复记录。

## 环境与验证
工程配置面向 HarmonyOS 5.0.0（API 12）。须确认 DevEco Studio SDK Manager 确实安装该版本，并使用 all-in-one 模式提供的内置 Hvigor 插件。

源码和 JSON 文件已进行静态检查；没有在用户 Windows/DevEco Studio 环境中实际编译运行，因此不能标记为本机已验证可运行。请以本机 Build 输出为最终验证依据。