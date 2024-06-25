# GitHub Advanced Security

## Introduction to GitHub Advanced Security

- GHAS: O GitHub Advanced Security (ou GHAS) é uma solução de segurança de aplicativo que capacita os desenvolvedores.
- Secret scanning
- Code scanning
- Dependabot

## Configure Dependabot security updates on your GitHub repo

### GraphQL

```
query {
  repository(name: "${repo}", owner: "${org}") {
    vulnerabilityAlerts(first: 100) {
      nodes {
        createdAt
        dismissedAt
        securityVulnerability {
          package {
            name
          }
          severity
          vulnerableVersionRange
          advisory {
            ghsaId
            publishedAt
            identifiers {
              type
              value
            }
          }
        }
      }
    }
  }
}
```

## Configure and use secret scanning in your GitHub repository

- x
- b

## Configure code scanning on GitHub

- x
- b

## Identify security vulnerabilities in your codebase by using CodeQL

- x
- b

## Code scanning with GitHub CodeQL

- x
- b

## GitHub administration for GitHub Advanced Security

- x
- b

## Manage sensitive data and security policies within GitHub

- x
- b
