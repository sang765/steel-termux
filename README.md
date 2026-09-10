# Steel CLI for Termux

Pre-built [Steel CLI](https://github.com/steel-dev/cli) binaries for [Termux](https://termux.dev) on Android (aarch64).

## Installation

### Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/steel-termux/main/install.sh | bash
```

### Manual Install

1. Download the latest release from [Releases](../../releases)
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

## How It Works

This repository uses GitHub Actions to cross-compile the official Steel CLI for Android's Bionic libc (used by Termux) instead of glibc (used by standard Linux).

The official Steel CLI releases only provide glibc-linked binaries, which cannot run on Termux due to incompatible C libraries.

## Building Locally

If you want to build locally on Termux:

```bash
pkg install rust
git clone https://github.com/steel-dev/cli.git
cd cli
cargo build --release --target aarch64-unknown-linux-android
```

## License

Steel CLI is licensed under the MIT License. See [LICENSE](https://github.com/steel-dev/cli/blob/main/LICENSE) for details.
