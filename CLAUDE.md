# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Inkwell is a terminal-based AI assistant primarily designed for Kindle devices. It provides a single-file implementation in both Python and Go, with no external dependencies, making it suitable for constrained environments like jailbroken Kindles.

## Common Commands

### Building the Go version
```bash
# For Linux ARM v5 (Kindle)
GOOS=linux GOARCH=arm GOARM=5 CGO_ENABLED=0 go build -trimpath -o inkwell-arm5 -ldflags="-s -w" inkwell.go

# Using the provided batch script (Windows)
./build_go_kindle.bat
```

### Running the application
```bash
# Python version
python3 inkwell.py

# Python with custom config
python3 inkwell.py --config /path/to/config.json

# Python setup mode
python3 inkwell.py --setup

# Go version (after building)
./inkwell-arm5
```

### Testing
No automated test suite is present. Testing is manual through the interactive interface.

## Architecture

### Core Components

**Dual Implementation Strategy:**
- `inkwell.py`: Full-featured Python implementation (68K lines)
- `inkwell.go`: Go port for better performance on ARM devices (64K lines)

**Key Design Patterns:**

1. **Single-File Architecture**: Both implementations are entirely self-contained with no external dependencies
2. **Multi-Provider AI Support**: Abstracted interface supporting OpenAI, Google, Anthropic, xAI, Mistral, Groq, Perplexity, and Alibaba
3. **Configuration-Driven**: JSON-based configuration with runtime generation of default configs
4. **State Management**: Conversation history stored in `history.json` with topic-based organization

### Data Flow

1. **Configuration Loading**: `config.json` → AppConfig struct/class
2. **AI Provider Selection**: Based on `provider` field, instantiates appropriate API client
3. **Conversation Management**: Messages stored as role/content pairs, exported as eBooks
4. **Kindle Integration**: Reads `My Clippings.txt` for AI-assisted reading comprehension

### Key Classes/Structs

**Python (`inkwell.py`):**
- `Inkwell`: Main application class managing configuration, history, and AI interaction
- `SimpleAiProvider`: Unified interface for different AI providers
- `MarkdownRenderer`: Converts markdown to terminal-friendly or HTML output

**Go (`inkwell.go`):**
- `InkWell`: Main struct mirroring Python implementation
- `SimpleAiProvider`: Provider abstraction with HTTP client
- `AppConfig`: Configuration structure with JSON tags

### File Organization

- Configuration files: `config.json` (auto-generated), `prompts.txt`
- History storage: `history.json` (follows config file location)
- Kindle integration: `/mnt/us/documents/My Clippings.txt`
- Output: eBooks exported to `/mnt/us/documents/`

### Multi-Provider AI Architecture

The codebase implements a unified interface across 8 different AI providers:

```
SimpleAiProvider
├── OpenAI API (GPT models)
├── Google (Gemini models)  
├── Anthropic (Claude models)
├── xAI (Grok models)
├── Mistral AI
├── Groq
├── Perplexity
└── Alibaba (Qwen models)
```

Each provider has specific URL patterns, authentication methods, and response formats, but all implement the same `chat()` interface.

### Terminal Interface

- **kterm Integration**: Designed for Kindle's kterm terminal emulator
- **Markdown Rendering**: Three display modes (markdown, markdown_table, plaintext)
- **Menu System**: Interactive command interface with single-character commands
- **Multi-line Input**: Supports multi-line text input with empty line as delimiter

## Development Notes

### Memory Constraints
- Go build optimized for low memory: `GOMEMLIMIT=16MiB GOGC=50`
- ARM v5 compatibility for older Kindle models
- Minimal memory footprint through single-file design

### Kindle-Specific Features
- Automatic WiFi toggle integration
- eBook export with proper formatting for Kindle display
- Integration with Kindle's document directory structure
- Support for jailbroken Kindle filesystem layout

### API Key Management
- Supports multiple API keys with automatic rotation
- Multiple API hosts with fallback support
- Semicolon-separated key/host lists in configuration