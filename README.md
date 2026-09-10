# Steel CLI for Termux

Pre-built [Steel CLI](https://github.com/steel-dev/cli) binaries for [Termux](https://termux.dev) on Android (aarch64).

## Ok, what is Steel?

[Steel](https://github.com/steel-dev/cli) is a browser automation tool for AI agents. It provides:

- Headless browser control for coding agents
- Session management and persistence
- Screenshot and DOM extraction
- JavaScript execution
- Cookie and storage management

Think of it as a programmable browser that AI agents can use to browse the web, fill forms, take screenshots, and interact with web applications — all without a visible GUI.

## Why this repository exist?

The official Steel CLI releases only provide **glibc-linked binaries** (standard Linux). Termux uses **Android's Bionic libc**, which is incompatible with glibc. This means you can't just download and run the official releases on Termux.

This repository uses GitHub Actions to cross-compile Steel CLI for Android's Bionic libc, producing binaries that actually work on Termux.

**TL;DR:** Official Steel binaries don't work on Termux. This repo fixes that.

## Lazy install manual? Paste this prompt to your LLM agent
```
Install Steel CLI for Termux. Download the binary from https://github.com/sang765/steel-termux/releases/latest and set it up.
```

Or just run this:

```bash
curl -fsSL https://raw.githubusercontent.com/sang765/steel-termux/main/install.sh | bash
```

## Manual Install

1. Download the latest release from [Releases](https://github.com/sang765/steel-termux/releases/latest)
2. Extract the tarball:
   ```bash
   tar xzf steel-*-aarch64-termux.tar.gz
   ```
3. Move the binary to your PATH:
   ```bash
   mv steel ~/.local/bin/
   ```
4. Make it executable:
   ```bash
   chmod +x ~/.local/bin/steel
   ```

## Usage

```bash
steel --help
steel init --agent
```

## Building Locally

If you want to build locally on Termux:

```bash
pkg install rust
git clone https://github.com/steel-dev/cli.git
cd cli
cargo build --release --target aarch64-linux-android
```

## License

Steel CLI is licensed under the MIT License. See [LICENSE](https://github.com/steel-dev/cli/blob/main/LICENSE) for details.
