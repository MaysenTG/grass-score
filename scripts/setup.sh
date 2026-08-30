#!/bin/bash

# Grass Score Setup Script
# This script sets up the development environment for Grass Score

set -e  # Exit on any error

echo "=========================================="
echo "Grass Score Development Setup"
echo "=========================================="
echo ""

REQUIRED_RUBY="3.2.3"

# Return success only when the version manager is installed and usable.
manager_is_usable() {
    local manager="$1"
    local version_check="$2"

    if ! command -v "$manager" &> /dev/null; then
        return 1
    fi

    if ! "$manager" $version_check &> /dev/null 2>&1; then
        echo "⚠️  Found $manager at $(command -v "$manager"), but it is not working correctly in this terminal."
        return 1
    fi

    return 0
}

# Function to check and install Ruby with version managers
install_ruby_with_manager() {
    echo "🔍 Checking for Ruby version managers..."
    echo ""

    # Check for asdf
    if manager_is_usable "asdf" "--version"; then
        echo "✅ Found working asdf"
        if ! asdf list ruby 2>/dev/null | grep -q "$REQUIRED_RUBY"; then
            echo "   Installing Ruby $REQUIRED_RUBY..."
            asdf install ruby "$REQUIRED_RUBY"
        fi
        echo "   Setting local Ruby version to $REQUIRED_RUBY..."
        asdf local ruby "$REQUIRED_RUBY"
        return 0
    fi

    # Check for rbenv
    if manager_is_usable "rbenv" "--version"; then
        echo "✅ Found working rbenv"
        if ! rbenv versions 2>/dev/null | grep -q "$REQUIRED_RUBY"; then
            echo "   Installing Ruby $REQUIRED_RUBY..."
            rbenv install "$REQUIRED_RUBY"
        fi
        echo "   Setting local Ruby version to $REQUIRED_RUBY..."
        rbenv local "$REQUIRED_RUBY"
        return 0
    fi

    # Check for rvm
    if command -v rvm &> /dev/null; then
        echo "✅ Found rvm"
        if ! rvm list 2>/dev/null | grep -q "$REQUIRED_RUBY"; then
            echo "   Installing Ruby $REQUIRED_RUBY..."
            rvm install "$REQUIRED_RUBY"
        fi
        echo "   Setting local Ruby version to $REQUIRED_RUBY..."
        rvm use "$REQUIRED_RUBY" --default
        return 0
    fi

    return 1
}

# Check if Ruby is installed
if ! command -v ruby &> /dev/null; then
    echo "❌ Ruby is not installed."
    echo ""

    # Try to install with a version manager
    if install_ruby_with_manager; then
        echo "✅ Ruby $REQUIRED_RUBY installed successfully"
    else
        echo "⚠️  No Ruby version manager found (asdf, rbenv, or rvm)"
        echo ""
        echo "   Please install one of the following:"
        echo "   - asdf: https://asdf-vm.com/guide/getting-started.html"
        echo "   - rbenv: https://github.com/rbenv/rbenv#installation"
        echo "   - rvm: https://rvm.io/rvm/install"
        echo ""
        echo "   Or install Ruby 3.3.2 directly from:"
        echo "   https://www.ruby-lang.org/en/downloads/"
        exit 1
    fi
else
    CURRENT_RUBY=$(ruby -v 2>/dev/null || true)
    echo "📌 Current Ruby version: $CURRENT_RUBY"

    if ruby -v 2>/dev/null | grep -q "$REQUIRED_RUBY"; then
        echo "✅ Correct Ruby version found in this terminal; skipping Ruby version setup"
    else
        echo ""
        echo "⚠️  Version mismatch! The project requires Ruby $REQUIRED_RUBY"
        echo ""

        # Try to install with a version manager
        if install_ruby_with_manager; then
            echo "✅ Ruby $REQUIRED_RUBY installed and set successfully"
            # Refresh the shell environment for the new Ruby version
            if command -v asdf &> /dev/null && asdf --version &> /dev/null 2>&1; then
                eval "$(asdf env bash)"
            elif command -v rbenv &> /dev/null && rbenv --version &> /dev/null 2>&1; then
                eval "$(rbenv init -)"
            fi
        else
            echo ""
            echo "   To install the correct version with rbenv:"
            echo "   $ rbenv install $REQUIRED_RUBY"
            echo "   $ rbenv local $REQUIRED_RUBY"
            echo ""
            echo "   To install with rvm:"
            echo "   $ rvm install $REQUIRED_RUBY"
            echo "   $ rvm use $REQUIRED_RUBY"
            echo ""
            echo "   To install with asdf:"
            echo "   $ asdf install ruby $REQUIRED_RUBY"
            echo "   $ asdf local ruby $REQUIRED_RUBY"
            echo ""
            echo "   If you already have a version manager installed but it is failing, remove or repair the broken binary and retry."
            echo ""
            read -p "Do you want to continue anyway? (y/n) " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                exit 1
            fi
        fi
    fi
fi

echo ""
echo "📦 Installing dependencies..."
if ! command -v bundle &> /dev/null; then
    echo "   Installing Bundler..."
    gem install bundler
fi

bundle install

echo ""
echo "🗄️  Setting up the database..."
bundle exec rails db:setup



echo ""
echo "Starting the development server..."
bundle exec rails server
echo ""
echo "To start with Docker:"
echo "  $ docker compose up"
echo ""
