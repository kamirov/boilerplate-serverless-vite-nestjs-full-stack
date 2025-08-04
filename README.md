# Boilerplate Serverless Vite NestJS Full Stack

A full-stack boilerplate project combining Vite for the frontend and NestJS for the backend, deployed using Serverless Framework.

## ⚠️ Work in Progress

**This project is currently under active development and may not be fully functional.**

- 🚧 **Experimental**: This is an experimental setup and may contain bugs or incomplete features
- 🔄 **In Development**: Features are being added and modified regularly
- 🐛 **May Not Work**: Some components might not work as expected or may be broken
- 📝 **Documentation**: Documentation is incomplete and may be outdated

## 🎨 Built with Vibecoding

This project was tragically built using **vibecoding** - an approach that prioritizes aesthetics and developer experience over strict functionality. What this means:

- ✨ Beautiful code structure and organization
- 🎯 Focus on developer happiness and workflow
- 🎨 Aesthetic considerations in architecture decisions
- 🚀 Rapid prototyping and iteration
- ⚡ Emphasis on modern tooling and practices

_Note: While vibecoding creates delightful development experiences, it may occasionally sacrifice some production-ready robustness for the sake of elegance._

## 🏗️ Architecture

This boilerplate follows a common pattern for applications with both backend and frontend components:

### Frontend (UI Web)

- **Framework**: React with TypeScript
- **Build Tool**: Vite
- **Testing**: Vitest
- **Location**: `apps/ui-web/`

### Backend (API Core)

- **Framework**: NestJS with TypeScript
- **Deployment**: Serverless Framework
- **Testing**: Jest
- **Location**: `apps/api-core/`

## 🚀 Getting Started

### Prerequisites

- Node.js (v22 or higher)
- pnpm (required for this project)
- AWS CLI (for serverless deployment)

### Installation

```bash
# Install dependencies
pnpm install

# Start development servers
pnpm dev
```

### Development

```bash
# Run frontend development server
cd apps/ui-web
pnpm dev

# Run backend development server
cd apps/api-core
pnpm dev
```

## 📁 Project Structure

```
├── apps/
│   ├── ui-web/          # Frontend React application
│   └── api-core/        # Backend NestJS API
├── application.code-workspace  # VS Code workspace configuration
└── README.md
```

## 🤝 Contributing

Since this is a work in progress, contributions are welcome but please note:

1. **Expect Breaking Changes**: The codebase is evolving rapidly
2. **Test Thoroughly**: Ensure your changes don't break existing functionality
3. **Follow Vibecoding Principles**: Maintain the aesthetic and developer experience focus
4. **Document Changes**: Update documentation for any new features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚡ Disclaimer

This boilerplate is provided as-is for educational and experimental purposes. It may not be suitable for production use without significant modifications and testing. Use at your own risk.

---

_Built with ❤️ and a tragic amount of vibecoding_
