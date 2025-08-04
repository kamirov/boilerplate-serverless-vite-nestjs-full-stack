import { fireEvent, render, screen } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import App from "./App";

describe("App", () => {
  it("renders the main heading", () => {
    render(<App />);
    expect(screen.getByText("Welcome to UI Web")).toBeInTheDocument();
  });

  it("renders the subtitle", () => {
    render(<App />);
    expect(
      screen.getByText(
        "A modern React application with Vite and Serverless deployment"
      )
    ).toBeInTheDocument();
  });

  it("renders all feature items", () => {
    render(<App />);
    expect(
      screen.getByText("⚡ Vite for fast development")
    ).toBeInTheDocument();
    expect(screen.getByText("⚛️ React with TypeScript")).toBeInTheDocument();
    expect(
      screen.getByText("☁️ Serverless deployment to AWS")
    ).toBeInTheDocument();
    expect(
      screen.getByText("📦 S3 + CloudFront for static hosting")
    ).toBeInTheDocument();
    expect(screen.getByText("🧪 Vitest for testing")).toBeInTheDocument();
    expect(screen.getByText("📊 Code coverage reporting")).toBeInTheDocument();
  });

  it("renders the counter button", () => {
    render(<App />);
    expect(screen.getByText("Count is 0")).toBeInTheDocument();
  });

  it("increments counter when button is clicked", () => {
    render(<App />);
    const button = screen.getByText("Count is 0");

    fireEvent.click(button);
    expect(screen.getByText("Count is 1")).toBeInTheDocument();

    fireEvent.click(button);
    expect(screen.getByText("Count is 2")).toBeInTheDocument();
  });

  it("renders all script commands", () => {
    render(<App />);
    expect(screen.getByText("pnpm start:dev")).toBeInTheDocument();
    expect(screen.getByText("pnpm test")).toBeInTheDocument();
    expect(screen.getByText("pnpm test:watch")).toBeInTheDocument();
    expect(screen.getByText("pnpm test:cov")).toBeInTheDocument();
    expect(screen.getByText("pnpm test:cov:watch")).toBeInTheDocument();
    expect(screen.getByText("pnpm deploy")).toBeInTheDocument();
  });

  it("renders script descriptions", () => {
    render(<App />);
    expect(screen.getByText("Start serverless offline")).toBeInTheDocument();
    expect(screen.getByText("Run tests once")).toBeInTheDocument();
    expect(screen.getByText("Run tests in watch mode")).toBeInTheDocument();
    expect(screen.getByText("Run tests with coverage")).toBeInTheDocument();
    expect(
      screen.getByText("Run tests with coverage in watch mode")
    ).toBeInTheDocument();
    expect(screen.getByText("Build and deploy to AWS")).toBeInTheDocument();
  });

  it("renders the footer", () => {
    render(<App />);
    expect(
      screen.getByText("Built with ❤️ using modern web technologies")
    ).toBeInTheDocument();
  });
});
