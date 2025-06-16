set PATH="C:\Program Files\Go\bin";%PATH%
@echo off
setlocal

:: 设置文件名（根据你的项目修改）
set GO_FILE=inkwell.go
set OUTPUT=inkwell

:: 编译配置
set GOOS=linux
set GOARCH=arm
set GOARM=5
set CGO_ENABLED=0
set GOMEMLIMIT=16MiB
set GOGC=50

:: 清理旧输出
if exist %OUTPUT% (
    del %OUTPUT%
)

:: 编译
echo Compiling %GO_FILE% for Kindle (ARMv5)...
go build -o %OUTPUT% -ldflags="-s -w"

:: 检查是否成功
if exist %OUTPUT% (
    echo Compilation successful! Output file: %OUTPUT%
) else (
    echo Compilation failed.
)

endlocal
pause
