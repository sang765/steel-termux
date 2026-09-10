#!/usr/bin/env bash
set -euo pipefail

# Steel CLI Installer for Termux
# Downloads the latest pre-built binary from GitHub Releases

REPO="sang765/steel-termux"
INSTALL_DIR="${HOME}/.local/bin"

echo "Steel CLI Installer for Termux"
echo "=============================="
echo ""

# Create install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Get latest release info
echo "Fetching latest release info..."
LATEST=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest")
VERSION=$(echo "$LATEST" | grep -o '"tag_name": "[^"]*"' | cut -d'"' -f4)

if [ -z "$VERSION" ]; then
    echo "Error: Could not determine latest version"
    exit 1
fi

echo "Latest version: $VERSION"

# Download URL
DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${VERSION}/steel-${VERSION}-aarch64-termux.tar.gz"
CHECKSUM_URL="https://github.com/${REPO}/releases/download/${VERSION}/steel-${VERSION}-aarch64-termux.tar.gz.sha256"

# Download tarball
echo "Downloading Steel CLI..."
TEMP_DIR=$(mktemp -d)
curl -fsSL "$DOWNLOAD_URL" -o "$TEMP_DIR/steel.tar.gz"

# Verify checksum if available
if curl -fsSL "$CHECKSUM_URL" -o "$TEMP_DIR/steel.tar.gz.sha256" 2>/dev/null; then
    echo "Verifying checksum..."
    cd "$TEMP_DIR"
    if ! sha256sum -c steel.tar.gz.sha256; then
        echo "Error: Checksum verification failed"
        rm -rf "$TEMP_DIR"
        exit 1
    fi
    cd -
fi

# Extract and install
echo "Installing Steel CLI..."
tar xzf "$TEMP_DIR/steel.tar.gz" -C "$TEMP_DIR"
mv "$TEMP_DIR/steel" "$INSTALL_DIR/steel"
chmod +x "$INSTALL_DIR/steel"

# Cleanup
rm -rf "$TEMP_DIR"

echo ""
echo "✅ Steel CLI installed successfully!"
echo ""
echo "Binary location: $INSTALL_DIR/steel"
echo ""

# Check if in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "⚠️  $INSTALL_DIR is not in your PATH"
    echo ""
    echo "Add this to your ~/.bashrc or ~/.config/fish/config.fish:"
    echo ""
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
fi

echo "Run 'steel --help' to get started"
