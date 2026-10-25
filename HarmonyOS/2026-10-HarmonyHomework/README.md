# HarmonyHomework 最终归档

本目录保存本会话最后一次提供的 HarmonyOS 作业源码、配置和作业索引。

## 作业组成
- 作业一：Gesture：TapGesture 双击缩放、PinchGesture 双指捏合、PanGesture 侧滑和拖拽。
- 作业二：商品列表 Tab、每个 Tab 5 条模拟商品、登录以及购买提示。
- 作业三：Preferences 初始化、存储、读取、删除、flush 数据落盘。

## 注意
GitHub 文件接口当前未能直接上传 ZIP 内的二进制 PNG 图标。`AppScope/resources/base/media/app_icon.png` 的仓库条目只是说明占位，并非真正 PNG。需要从本仓库外提供的 ZIP 备份解压真实图标并覆盖该占位文件后，才是完整工程素材。

## 验证声明
目录结构和 JSON 配置做过静态检查；没有在用户 Windows/DevEco Studio 环境中实际编译运行。工程配置面向 HarmonyOS 5.0.0 (API 12)，必须确认 SDK Manager 中已经安装。
