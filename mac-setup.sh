#!/bin/bash

# Function to print status messages
print_status() {
  echo "==============================="
  echo "$1"
  echo "==============================="
}

# Update macOS and install Xcode Command Line Tools
print_status "Installing Xcode Command Line Tools..."
xcode-select --install

# Install Homebrew
print_status "Installing Homebrew..."
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew is already installed."
fi

# Install iTerm2
print_status "Installing iTerm2..."
brew install --cask iterm2

# Configure iTerm2 (optional: load preferences from a URL or set defaults)
print_status "Configuring iTerm2..."
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Install and configure Zsh & Oh My Zsh
print_status "Installing and configuring Oh My Zsh..."
brew install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Set Zsh as default shell
chsh -s "$(which zsh)"

# Add Powerlevel10k theme (popular for Oh My Zsh)
brew install romkatv/powerlevel10k/powerlevel10k
echo 'source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Install Bash and enable tab completion
print_status "Installing Bash and tab completion..."
brew install bash bash-completion
echo "[[ -r \"\$(brew --prefix)/etc/profile.d/bash_completion.sh\" ]] && . \"\$(brew --prefix)/etc/profile.d/bash_completion.sh\"" >>~/.bash_profile

# Install developer tools
print_status "Installing developer tools..."
brew install curl git coreutils

# Install Miniforge (Python 3.11)
print_status "Installing Miniforge (Python 3.11)..."
brew install --cask miniforge
conda init zsh

# Install Poetry
print_status "Installing Poetry..."
curl -sSL https://install.python-poetry.org | python3 -

# Install PyCharm
print_status "Installing PyCharm..."
brew install --cask pycharm

# Install Node.js for JavaScript development
print_status "Installing Node.js..."
brew install node

# Install Docker for DevOps
print_status "Installing Docker..."
brew install --cask docker

# Install Zotero for bibliography management
print_status "Installing Zotero..."
brew install --cask zotero

# Final system update and cleanup
print_status "Final system update and cleanup..."
brew update && brew upgrade
brew cleanup

# Instructions for post-installation configuration
cat <<EOF

Setup is complete! Here are some post-installation steps:
1. Open iTerm2 and customize preferences (Appearance, Fonts, etc.).
2. Configure your Oh My Zsh plugins in ~/.zshrc.
   Recommended plugins: git, zsh-autosuggestions, zsh-syntax-highlighting.
   Install with:
     brew install zsh-autosuggestions zsh-syntax-highlighting
     echo "source \$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
     echo "source \$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
3. Set up Powerlevel10k by running 'p10k configure' in the terminal.
4. Configure Docker and log in if needed.

Enjoy your new development setup!

EOF