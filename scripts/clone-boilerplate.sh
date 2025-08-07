#!/bin/bash

# Boilerplate Cloner Script
# Generates a clean copy of this repository for a new project
# Excludes node_modules, dist, coverage, and other git-ignored files

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 <target-directory> [options]"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -f, --force    Force overwrite if target directory exists"
    echo ""
    echo "Examples:"
    echo "  $0 my-new-project"
    echo "  $0 /path/to/my-new-project --force"
    echo ""
    echo "This script will create a clean copy of the boilerplate repository"
    echo "excluding node_modules, dist, coverage, and other git-ignored files."
    echo ""
    echo "If the target directory already exists, you'll be prompted to choose:"
    echo "  - Overwrite: Remove existing contents and start fresh"
    echo "  - Append: Merge contents, overwriting files with same names"
    echo "  - Cancel: Abort the operation"
}

# Parse command line arguments
TARGET_DIR=""
FORCE_OVERWRITE=false
APPEND_MODE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_usage
            exit 0
            ;;
        -f|--force)
            FORCE_OVERWRITE=true
            shift
            ;;
        -*)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
        *)
            if [[ -z "$TARGET_DIR" ]]; then
                TARGET_DIR="$1"
            else
                print_error "Multiple target directories specified"
                show_usage
                exit 1
            fi
            shift
            ;;
    esac
done

# Check if target directory is provided
if [[ -z "$TARGET_DIR" ]]; then
    print_error "Target directory is required"
    show_usage
    exit 1
fi

# Get the current directory (boilerplate root)
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

print_status "Source directory: $SOURCE_DIR"
print_status "Target directory: $TARGET_DIR"

# Check if target directory already exists
if [[ -d "$TARGET_DIR" ]]; then
    if [[ "$FORCE_OVERWRITE" == "true" ]]; then
        print_warning "Target directory exists. Removing it..."
        rm -rf "$TARGET_DIR"
    else
        print_warning "Target directory already exists: $TARGET_DIR"
        echo ""
        echo "Options:"
        echo "  1. Overwrite (remove existing contents)"
        echo "  2. Append (merge contents, overwrite files with same names)"
        echo "  3. Cancel"
        echo ""
        read -p "Choose an option (1-3): " choice
        
        case $choice in
            1)
                print_warning "Removing existing directory contents..."
                rm -rf "$TARGET_DIR"
                ;;
            2)
                print_status "Appending to existing directory..."
                APPEND_MODE=true
                ;;
            3)
                print_status "Operation cancelled."
                exit 0
                ;;
            *)
                print_error "Invalid option. Cancelling."
                exit 1
                ;;
        esac
    fi
fi

# Create target directory
print_status "Creating target directory..."
mkdir -p "$TARGET_DIR"

# Function to check if a file/directory should be excluded
should_exclude() {
    local path="$1"
    
    # Common exclusions
    local exclude_patterns=(
        "node_modules"
        "dist"
        "dist-ssr"
        "build"
        "coverage"
        ".nyc_output"
        ".next"
        ".nuxt"
        ".serverless"
        ".dynamodb"
        ".cache"
        ".parcel-cache"
        ".fusebox"
        "*.log"
        "*.tgz"
        "*.tsbuildinfo"
        ".env*"
        ".DS_Store"
        "Thumbs.db"
        ".git"
        ".cursor"
        "pnpm-lock.yaml"
        "package-lock.json"
        "yarn.lock"
        ".yarn"
        ".vscode"
        ".idea"
        "*.suo"
        "*.ntvs*"
        "*.njsproj"
        "*.sln"
        "*.sw?"
        ".tern-port"
        ".vscode-test"
        "logs"
        "pids"
        "*.pid"
        "*.seed"
        "*.pid.lock"
        "lib-cov"
        ".grunt"
        "bower_components"
        ".lock-wscript"
        "build/Release"
        "jspm_packages"
        ".npm"
        ".eslintcache"
        ".stylelintcache"
        ".rpt2_cache"
        ".rts2_cache_cjs"
        ".rts2_cache_es"
        ".rts2_cache_umd"
        ".node_repl_history"
        ".yarn-integrity"
        ".docusaurus"
        "*.local"
    )
    
    for pattern in "${exclude_patterns[@]}"; do
        if [[ "$path" == *"$pattern"* ]]; then
            return 0  # Should exclude
        fi
    done
    
    return 1  # Should include
}

# Function to copy files recursively
copy_files() {
    local src="$1"
    local dst="$2"
    
    # Create destination directory if it doesn't exist
    mkdir -p "$dst"
    
    # First, count total files to copy for progress bar
    local total_files=0
    while IFS= read -r -d '' item; do
        local rel_path="${item#$src/}"
        if ! should_exclude "$rel_path"; then
            ((total_files++))
        fi
    done < <(find "$src" -mindepth 1 -print0)
    
    print_status "Found $total_files files to copy..."
    
    # Progress bar variables
    local current_file=0
    local progress_width=50
    
    # Copy files and directories
    while IFS= read -r -d '' item; do
        # Get relative path from source
        local rel_path="${item#$src/}"
        
        # Skip if should be excluded (silently)
        if should_exclude "$rel_path"; then
            continue
        fi
        
        # Create destination path
        local dest_path="$dst/$rel_path"
        
        if [[ -d "$item" ]]; then
            # Create directory
            mkdir -p "$dest_path"
        else
            # Copy file (will overwrite if exists in append mode)
            if [[ -f "$dest_path" ]] && [[ "$APPEND_MODE" == "true" ]]; then
                print_status "Overwriting: $rel_path"
            fi
            cp "$item" "$dest_path"
        fi
        
        # Update progress bar
        ((current_file++))
        local progress=$((current_file * progress_width / total_files))
        local percent=$((current_file * 100 / total_files))
        
        # Clear line and show progress
        printf "\r[%-${progress_width}s] %d%%" "$(printf '#%.0s' $(seq 1 $progress))" "$percent"
    done < <(find "$src" -mindepth 1 -print0)
    
    # Clear progress bar and show completion
    printf "\r[%-${progress_width}s] 100%%\n" "$(printf '#%.0s' $(seq 1 $progress_width))"
}

# Copy the boilerplate files
print_status "Copying boilerplate files..."
copy_files "$SOURCE_DIR" "$TARGET_DIR"

# Remove the scripts directory from the target (since it's for the original repo)
print_status "Removing scripts directory from target..."
rm -rf "$TARGET_DIR/scripts"

# Update README.md in the target directory
print_status "Updating README.md for the new project..."
if [[ -f "$TARGET_DIR/README.md" ]]; then
    # Create a backup of the original README
    cp "$TARGET_DIR/README.md" "$TARGET_DIR/README.md.backup"
    
    # Update the README title and add project-specific information
    sed -i.bak "s/# Boilerplate Serverless Vite NestJS Full Stack/# $(basename "$TARGET_DIR")/" "$TARGET_DIR/README.md"
    
    # Add a note about this being a cloned project
    cat >> "$TARGET_DIR/README.md" << 'EOF'

## 📋 Project Information

This project was created from the [Boilerplate Serverless Vite NestJS Full Stack](https://github.com/your-username/boilerplate-serverless-vite-nestjs-full-stack) template.

### Original Template Features
- Full-stack setup with Vite + React frontend and NestJS backend
- Serverless deployment configuration
- TypeScript support throughout
- Modern development tooling

EOF
    
    # Clean up backup files
    rm -f "$TARGET_DIR/README.md.bak"
fi

# Initialize git repository in the target directory
cd "$TARGET_DIR"
if [[ ! -d ".git" ]]; then
    print_status "Initializing git repository..."
    git init
    
    # Create initial commit
    git add .
    git commit -m "feat: initialize project from boilerplate template

- Cloned from boilerplate-serverless-vite-nestjs-full-stack
- Clean setup without node_modules, dist, or other build artifacts
- Ready for development"
else
    print_status "Git repository already exists. Adding changes..."
    git add .
    git commit -m "feat: add boilerplate template files

- Added files from boilerplate-serverless-vite-nestjs-full-stack
- Merged with existing project structure
- Ready for development"
fi

if [[ "$APPEND_MODE" == "true" ]]; then
    print_success "Boilerplate files appended successfully!"
else
    print_success "Boilerplate cloned successfully!"
fi
print_success "Target directory: $TARGET_DIR"
print_status "Next steps:"
echo "  1. cd $TARGET_DIR"
echo "  2. pnpm install"
echo "  3. pnpm dev"
echo ""
print_status "Happy vibecoding! ✨"
