# GitHub Advanced Security

[linkedin course](https://www.linkedin.com/learning/github-advanced-security-cert-prep-by-microsoft-press/introduction)

## 1. Unveil GHAS Security Features

- Open Source
  - basic code scanning for public repos
  - limited secret scanning and vulnerability alerts
  - no container scanning or ci/cd integration
- GHAS + GHEC(GitHub Enterprise Cloud)/GHES(GitHub Enterprise Server)
  - CodeQL code scanning
  - comprehensive secret scanning
  - container scanning
  - prioritized security alerts
- GitHub Advanced Security (GHAS)
  - security and dependency review toolset
  - Required GitHub Enterprise
  - Enabled by default on all https://github.com public repositories
- GitHub Enterprise Cloud (GHEC)
  - Cloud-based GitHub Enterprise-grade solution
- GitHub Enterprise Server (GHES)
  - Self-hosted option

### Security Overview: Your central command

- Unified Dashboard: See all security insights in one place - code scanning results, secret scanning alerts, vulnerability status.
  - Track progress, identify areas for improvement. Drill down for detailed analysis
- Customizable security policies: Define severity levels, set automatic actions (e.g., block pull requests), tailor security posture to your organization.

### Secret scanning vs. code scanning

- Secret Scanning: protect sensitive information (tokens, password, API keys) in code, commits, issues
  - Prevents leaks and unauthirized access.
- Code Scanning: Analyzes code for vulnerabilities and coding errors (exploits, injection flaws, insecure practices)
  - Helps developers write secure and robust code

### Building a secure SDLC with GHAS tools

- Secret Scanning: Integrates with CI/CD pipelines for early leak detection and prevention
  - automates remediation workflows to revoke exposed secrets
- Code Scanning: Provides actionable guidance for developers to fix vulnerabilities and improve code security
  - Integrates with pull requests for real-time feedback and code review
- Dependabot: Automates dependency management and vulnerability patching, reducing manual effort and accelerating remediation

### Traditional approach vs Integration with GHAS

- Isolated security review: Security considered only at final stages or if you're notified of a breach
- Integrated security in SDLC: Continuous security assessment at each development phase

## 2. Harness GHAS Features

## 3. Implement Secret Scanning

## 4. Tailor Secret Scanning

## 5. Explore Dependency Vulnerability Tools

## 6. Set Up Vulnerability Management Tools

## 7. Resolve Vulnerable Dependencies

## 8. Initiate Code Scanning

## 9

## 10

## 11

## 12

## 13

## 14

## 15

## 16
