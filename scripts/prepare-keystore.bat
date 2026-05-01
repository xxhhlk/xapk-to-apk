@echo off
REM 准备 keystore 用于 GitHub Actions 的脚本 (Windows 版本)

echo XAPK to APK - Keystore 准备工具
echo =================================
echo.

if "%~1"=="" (
    echo 用法: %0 ^<keystore文件路径^>
    echo.
    echo 示例: %0 release.keystore
    exit /b 1
)

set KEYSTORE_FILE=%~1

if not exist "%KEYSTORE_FILE%" (
    echo 错误: 文件 %KEYSTORE_FILE% 不存在
    exit /b 1
)

echo 正在处理 keystore 文件: %KEYSTORE_FILE%
echo.

REM 生成 base64 编码
echo 生成 base64 编码...
certutil -encode "%KEYSTORE_FILE%" temp.b64 >nul
findstr /v /c:"-" temp.b64 > "%KEYSTORE_FILE%.base64.txt"
del temp.b64

echo.
echo 完成!
echo.
echo 请将以下内容复制到 GitHub Secrets 中的 KEYSTORE_BASE64:
echo.
echo --------------------------------------------------------------------------------
type "%KEYSTORE_FILE%.base64.txt"
echo.
echo --------------------------------------------------------------------------------
echo.
echo base64 内容已保存到: %KEYSTORE_FILE%.base64.txt
echo.
echo 别忘了还需要在 GitHub Secrets 中配置:
echo   - KEYSTORE_PASSWORD: 你的密钥库密码
echo   - KEY_ALIAS: 你的密钥别名
echo   - KEY_PASSWORD: 你的密钥密码
echo.
