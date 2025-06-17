@echo off
setlocal

set GOOS=linux
set GOARCH=arm
set GOARM=5
set CGO_ENABLED=0
set GOMEMLIMIT=16MiB
set GOGC=50

set GO_FILE=inkwell.go
set OUTPUT=inkwell-%GOARCH%%GOARM%

if exist %OUTPUT% (
    del %OUTPUT%
)

echo Compiling %GO_FILE% for Kindle (ARMv%GOARM%)...
go build -trimpath -o %OUTPUT% -ldflags="-s -w"

if exist %OUTPUT% (
    echo Compilation successful! Output file: %OUTPUT%
) else (
    echo Compilation failed.
)

endlocal
pause
