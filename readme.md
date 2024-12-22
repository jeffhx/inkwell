# 简介
运行于终端的Ai助手，主要为Kindle设计，也适用于其他系统的终端
1. Python >= 3.8
2. 单文件设计，不依赖任何第三方库
3. 支持多个api服务器自动轮换，规避流量限制
4. 支持终端显示格式化后的markdown文本
5. 支持将会话历史导出为格式良好的电子书

# 用法
1. 使用命令行参数 -s 或 --setup 开始交互式的初始化和配置
2. 不带参数执行，自动使用同一目录下的配置文件 config.json，如果没有则自动新建一个默认模板
3. 如果需要不同的配置，可以传入参数 python inkwell.py --config path/to/config.json
4. 在kindle上使用时可以在kterm的menu.json里面添加一个或多个项目，action值为：
```bash
bin/kterm.sh -e 'python3 /mnt/us/extensions/kterm/ai/inkwell.py --config /mnt/us/extensions/kterm/ai/google.json
```
5. 如果需要自动开关wifi，可以在kterm.sh的 `${EXTENSION}/bin/kterm ${PARAM} "$@"` 行前后添加
```python
lipc-set-prop com.lab126.cmd wirelessEnable 1
lipc-set-prop com.lab126.cmd wirelessEnable 0
```

# 自定义prompt
inkwell支持方便切换prompt
1. 可以在配置时输入 `Custom prompt`
2. 可以手动编辑配置文件，在 `custom_prompt` 区段填写，然后将 `prompt` 修改为 `custom`
3. 在inkwell.py同目录下创建文件 `prompts.txt`，可以写入多个prompt，然后在程序内容切换，格式为
```
prompt name
content line
content line
...
</>
prompt name
content line
content line
...
</>
...
```
