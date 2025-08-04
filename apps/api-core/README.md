# API Core

A NestJS-based API with Serverless deployment support.

## Features

- 🚀 NestJS framework with TypeScript
- ☁️ Serverless deployment with AWS Lambda
- 🗄️ PostgreSQL database with TypeORM
- 🔧 Configuration management with environment variables
- 📚 Swagger API documentation
- 🧪 Jest testing with coverage
- 🔄 GitHub Actions CI/CD pipeline
- 🎯 Node.js 22 support

## Prerequisites

- Node.js 22+
- pnpm (recommended) or npm
- PostgreSQL database
- AWS CLI (for deployment)

## Installation

```bash
cd apps/api-core
pnpm install
```

## Environment Setup

1. Copy the example environment file:
```bash
cp .env.example .env
```

2. Update the `.env` file with your configuration:
```env
# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=postgres
DB_PASSWORD=your_password
DB_DATABASE=api_core_dev

# JWT Configuration
JWT_SECRET=your-super-secret-jwt-key

# API Configuration
API_KEY=your-api-key-here
```

## Available Scripts

### Development
- `pnpm start:dev` - Start the serverless offline development server
- `pnpm start:debug` - Start in debug mode with watch
- `pnpm build` - Build the application

### Testing
- `pnpm test` - Run tests once
- `pnpm test:watch` - Run tests in watch mode
- `pnpm test:cov` - Run tests with coverage report
- `pnpm test:cov:watch` - Run tests with coverage in watch mode
- `pnpm test:e2e` - Run end-to-end tests

### Deployment
- `pnpm deploy` - Deploy to development environment
- `pnpm deploy:prod` - Deploy to production environment

## API Documentation

Once the application is running, you can access the Swagger documentation at:
- Local: http://localhost:3001/api
- Deployed: https://your-api-gateway-url/api

## Database Setup

The application uses PostgreSQL with TypeORM. Make sure you have a PostgreSQL instance running and update the database configuration in your `.env` file.

## Deployment

### Local Development
```bash
pnpm start:dev
```

### AWS Deployment
```bash
# Deploy to development
pnpm deploy

# Deploy to production
pnpm deploy:prod
```

## GitHub Actions

The project includes a GitHub Actions workflow that:
1. Runs tests with PostgreSQL service
2. Builds the application
3. Deploys to development (develop branch)
4. Deploys to production (main branch)

### Required Secrets

Set up the following secrets in your GitHub repository:

#### AWS Credentials
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

#### Development Environment
- `DB_HOST_DEV`
- `DB_PORT_DEV`
- `DB_USERNAME_DEV`
- `DB_PASSWORD_DEV`
- `DB_DATABASE_DEV`
- `JWT_SECRET_DEV`
- `API_KEY_DEV`

#### Production Environment
- `DB_HOST_PROD`
- `DB_PORT_PROD`
- `DB_USERNAME_PROD`
- `DB_PASSWORD_PROD`
- `DB_DATABASE_PROD`
- `JWT_SECRET_PROD`
- `API_KEY_PROD`

## Project Structure

```
src/
├── config/
│   └── configuration.ts    # Application configuration
├── app.controller.ts       # Main controller
├── app.service.ts         # Main service
├── app.module.ts          # Root module
├── main.ts               # Application entry point
└── lambda.ts             # Lambda handler for serverless
```

## Contributing

1. Create a feature branch
2. Make your changes
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

This project is part of the boilerplate-serverless-vite-nestjs-full-stack repository. 