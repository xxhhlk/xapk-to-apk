# 使用 GitHub Actions 转换 XAPK 为 APK

本项目提供了三个 GitHub Actions 工作流程，用于自动化 XAPK 到 APK 的转换。

## 工作流程说明

### 1. `convert-xapk.yml` - 基础转换
- 不带签名功能的基础转换
- 适合只需要 APK 文件不需要签名的情况

### 2. `convert-xapk-with-sign.yml` - 自动签名转换
- 使用自动生成的调试密钥库签名
- 转换后的 APK 可以直接安装到 Android 设备

### 3. `convert-xapk-custom-sign.yml` - 自定义签名转换
- 支持使用自己的密钥库签名（通过 GitHub Secrets）
- 适合发布应用的场景

## 快速开始

### 方法一：直接上传 XAPK 文件到仓库

1. 将你的 `.xapk` 文件推送到 GitHub 仓库
2. GitHub Actions 会自动检测并触发转换
3. 在 Actions 页面下载生成的 APK 工件

### 方法二：手动触发工作流程

1. 打开仓库的 **Actions** 标签页
2. 选择你想使用的工作流程
3. 点击 **Run workflow**
4. （可选）输入 XAPK 文件的 URL 或仓库内路径
5. 点击 **Run workflow** 按钮

## 配置自定义签名（可选）

如果你想使用自己的密钥库签名 APK，请按照以下步骤配置 GitHub Secrets：

### 1. 生成 keystore 文件（如果还没有）

```bash
keytool -genkey -v -keystore release.keystore -storepass your_keystore_password -alias your_key_alias -keypass your_key_password -keyalg RSA -keysize 2048 -validity 10000
```

### 2. 将 keystore 转为 base64 编码

```bash
base64 -w 0 release.keystore > keystore.base64
```

### 3. 在 GitHub 仓库配置 Secrets

进入仓库的 **Settings → Secrets and variables → Actions**，添加以下 Secrets：

| Secret 名称 | 说明 |
|------------|------|
| `KEYSTORE_BASE64` | keystore 文件的 base64 编码内容 |
| `KEYSTORE_PASSWORD` | 密钥库密码 |
| `KEY_ALIAS` | 密钥别名 |
| `KEY_PASSWORD` | 密钥密码 |

### 4. 使用自定义签名工作流程

选择 `Convert XAPK to APK (Custom Signing)` 工作流程即可。

## 获取转换后的 APK

1. 工作流程完成后，进入工作流程详情页
2. 在 **Artifacts** 部分找到生成的 APK
3. 点击下载即可

## 注意事项

- APK 工件默认保留 30 天
- 转换过程可能需要几分钟时间
- 请确保你的 XAPK 文件是有效的
