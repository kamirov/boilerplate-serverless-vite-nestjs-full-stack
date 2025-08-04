import { useState } from "react";
import "./App.css";

function App() {
  const [count, setCount] = useState(0);

  return (
    <div className="app">
      <header className="header">
        <h1>Welcome to UI Web</h1>
        <p>A modern React application with Vite and Serverless deployment</p>
      </header>

      <main className="main">
        <div className="card">
          <h2>Features</h2>
          <ul className="features">
            <li>⚡ Vite for fast development</li>
            <li>⚛️ React with TypeScript</li>
            <li>☁️ Serverless deployment to AWS</li>
            <li>📦 S3 + CloudFront for static hosting</li>
            <li>🧪 Vitest for testing</li>
            <li>📊 Code coverage reporting</li>
          </ul>
        </div>

        <div className="card">
          <h2>Interactive Demo</h2>
          <button
            className="counter-button"
            onClick={() => setCount((count) => count + 1)}
          >
            Count is {count}
          </button>
          <p>Click the button to test React state management</p>
        </div>

        <div className="card">
          <h2>Available Scripts</h2>
          <div className="scripts">
            <div className="script-item">
              <code>pnpm start:dev</code>
              <span>Start serverless offline</span>
            </div>
            <div className="script-item">
              <code>pnpm test</code>
              <span>Run tests once</span>
            </div>
            <div className="script-item">
              <code>pnpm test:watch</code>
              <span>Run tests in watch mode</span>
            </div>
            <div className="script-item">
              <code>pnpm test:cov</code>
              <span>Run tests with coverage</span>
            </div>
            <div className="script-item">
              <code>pnpm test:cov:watch</code>
              <span>Run tests with coverage in watch mode</span>
            </div>
            <div className="script-item">
              <code>pnpm deploy</code>
              <span>Build and deploy to AWS</span>
            </div>
          </div>
        </div>
      </main>

      <footer className="footer">
        <p>Built with ❤️ using modern web technologies</p>
      </footer>
    </div>
  );
}

export default App;
