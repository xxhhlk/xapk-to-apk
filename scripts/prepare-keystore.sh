#!/bin/bash

# 准备 keystore 用于 GitHub Actions 的脚本

echo "XAPK to APK - Keystore 准备工具"
echo "================================="
echo ""

if [ $# -lt 1 ]; then
    echo "用法: $0 <keystore文件路径>"
    echo ""
    echo "示例: $0 release.keystore"
    exit 1
fi

KEYSTORE_FILE=$1

if [ ! -f "$KEYSTORE_FILE" ]; then
    echo "错误: 文件 $KEYSTORE_FILE 不存在"
    exit 1
fi

echo "正在处理 keystore 文件: $KEYSTORE_FILE"
echo ""

# 生成 base64 编码
echo "生成 base64 编码..."
BASE64_CONTENT=$(base64 -w 0 "$KEYSTORE_FILE")

# 保存到文件
OUTPUT_FILE="${KEYSTORE_FILE}.base64.txt"
echo "$BASE64_CONTENT" > "$OUTPUT_FILE"

echo ""
echo "✅ 完成!"
echo ""
echo "请将以下内容复制到 GitHub Secrets 中的 KEYSTORE_BASE64:"
echo ""
echo "--------------------------------------------------------------------------------"
cat "$OUTPUT_FILE"
echo "--------------------------------------------------------------------------------"
echo ""
echo "base64 内容已保存到: $OUTPUT_FILE"
echo ""
echo "别忘了还需要在 GitHub Secrets 中配置:"
echo "  - KEYSTORE_PASSWORD: 你的密钥库密码"
echo "  - KEY_ALIAS: 你的密钥别名"
echo "  - KEY_PASSWORD: 你的密钥密码"
echo ""
