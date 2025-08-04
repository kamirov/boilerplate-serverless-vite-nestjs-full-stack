# UI Web

A modern React application built with Vite and TypeScript, deployed to AWS using Serverless Framework.

## 🚀 Features

- ⚡ **Vite** - Fast development and build tooling
- ⚛️ **React 19** - Latest React with TypeScript support
- ☁️ **Serverless** - AWS deployment with S3 and CloudFront
- 🧪 **Vitest** - Fast unit testing with coverage
- 📊 **Code Coverage** - Comprehensive test coverage reporting
- 🔄 **CI/CD** - GitHub Actions for automated testing and deployment

## 📋 Prerequisites

- Node.js 22 or higher
- AWS CLI configured with appropriate permissions
- Serverless Framework CLI

## 🛠️ Installation

```bash
# Install dependencies
npm install

# Install Serverless Framework globally (if not already installed)
npm install -g serverless
```

## 🎯 Available Scripts

| Script                   | Description                                |
| ------------------------ | ------------------------------------------ |
| `npm run dev`            | Start Vite development server              |
| `npm run start:dev`      | Start serverless offline for local testing |
| `npm run build`          | Build the application for production       |
| `npm run test`           | Run tests once                             |
| `npm run test:watch`     | Run tests in watch mode                    |
| `npm run test:cov`       | Run tests with coverage                    |
| `npm run test:cov:watch` | Run tests with coverage in watch mode      |
| `npm run lint`           | Run ESLint                                 |
| `npm run preview`        | Preview production build                   |
| `npm run deploy`         | Build and deploy to AWS                    |

## 🧪 Testing

The project uses Vitest for testing with React Testing Library for component testing.

```bash
# Run tests
npm run test

# Run tests with coverage
npm run test:cov

# Run tests in watch mode
npm run test:watch
```

## 🚀 Deployment

### Prerequisites

1. Configure AWS credentials:

   ```bash
   aws configure
   ```

2. Set up GitHub Secrets for CI/CD:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

### Manual Deployment

```bash
# Deploy to development
npm run deploy

# Deploy to production
STAGE=prod npm run deploy
```

### Automated Deployment

The project includes a GitHub Actions workflow that automatically:

1. Runs tests and checks coverage
2. Builds the application
3. Deploys to AWS (on main branch)

## 🏗️ Architecture

### AWS Resources

- **S3 Bucket**: Static file hosting
- **CloudFront Distribution**: CDN for global content delivery
- **Lambda Function**: Serverless handler for SPA routing

### Project Structure

```
apps/ui-web/
├── src/
│   ├── components/     # React components
│   ├── test/          # Test setup and utilities
│   ├── App.tsx        # Main application component
│   └── main.tsx       # Application entry point
├── .github/workflows/ # CI/CD workflows
├── serverless.yml     # Serverless configuration
├── handler.js         # AWS Lambda handler
├── vitest.config.ts   # Test configuration
└── package.json       # Dependencies and scripts
```

## 🔧 Configuration

### Serverless Configuration

The `serverless.yml` file configures:

- AWS Lambda function for serving static files
- S3 bucket for static asset storage
- CloudFront distribution for CDN
- Custom domain and caching policies

### Environment Variables

- `STAGE`: Deployment stage (dev, staging, prod)
- `AWS_REGION`: AWS region for deployment

## 📊 Monitoring

### CloudWatch Logs

Lambda function logs are available in CloudWatch:

- Log Group: `/aws/lambda/ui-web-{stage}-serveStatic`

### CloudFront Metrics

Monitor CloudFront performance in the AWS Console:

- Request counts
- Error rates
- Cache hit ratios

## 🔒 Security

- S3 bucket configured for public read access
- CloudFront distribution with HTTPS enforcement
- CORS headers configured for cross-origin requests

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## 📝 License

This project is licensed under the MIT License.
