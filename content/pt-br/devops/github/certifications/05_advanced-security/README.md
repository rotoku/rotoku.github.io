# GitHub Advanced Security (GHAS)

## Enable the dependency graph
- Feature of GitHub Advanced Security
- Available for free on public repos
- Cannot be disabled on public repos

## Transient dependencies
- Dependencies of your dependencies
    - Software with dependencies, and the dependencies have dependencies
- Important in the supply chain

## Risks
- Vulnerabilities in your dependencies
- Risks scope for your dependents
- Transient dependencies might have vulnerabilities
- Future vulnerabilities
- License aggrements

## Dependency Graph: Ecosystems
- support ecosystems:
    - composer (php)
    - .net
    - go modules
    - maven (java, scala)
    - npm
    - python pip
    - python poetry
    - ruby gems
    - yarn
    - GitHub Actions

## Dependabot
- Package used
- Package ecosystems
- Available versions
- Create Pull Requests

@dependabot rebase
@dependabot recreate
@dependabot merge
@dependabot squash and merge
@dependabot cancel merge
@dependabot reopen
@dependabot close

## Vulnerable Alerts Management
```mermaid
graph TD;
    Vulnerability Found-->Risk Acceptable?;
    Risk Acceptable?-->Dismiss;
    Risk Acceptable?-->Newer Version With Fix?;
    Newer Version With Fix?-->New Version Compatible?;
    Newer Version With Fix?-->Older Version Available Without Vulnerability?;
    New Version Compatible?-->Upgrade;
    New Version Compatible?-->Older Version Available Without Vulnerability?;
    Older Version Available Without Vulnerability?-->Downgrade;
```
- Alert Settings
- Who is notified?
- Where are the notifications visible?

## Automatic Security Updates
- Dependabot functionality
- Builds on software composition analysis
- Immediate Pull Requests after vulnerability disclosure

## Check New Dependencies
- Dependency review on a Pull Requests
- Fail on new vulnerable dependency

## GitHub Advisory Database
- Vulnerabilities are added from the following sources:
    - the national vulnerability database (NIST)
    - a combination of machine learning and human reviews to detect vulnerabilities in public commits on GitHub
    - Security Advisories reported on GitHub
    - The npm Security Advisories database
- Supported ecosystems:
    - composer
    - go
    - maven
    - npm
    - nuget
    - pip
    - ruby gems
    - rust

1. GitHub Reviewed Advisories
    - Mapped to track dependencies from the dependency graph
    - Will generate an alert

2. Unreview Advisories:
    - Directly added from the national vulnerability database (NIST)
    - Will not generate an alert
    - Limitations:
        - ecosystems:
            - vulnerability alerts not supported for that ecosystems    



COMO IGNORAR ARQUIVOS OU DIRETÓRIO NO CODE SCANNING, SECRET SCANNING?

COMO DEFINIR UM CONJUNTO DE ARQUIVOS NO CODEQL?

on:
  pull_request:
    paths-ignore:
      - 'docs/**'
      - 'examples/**'
      - 'tests/**'
      - 'test/**'
      - 'test_*/**'
      - 'test-*/**'
      - 'test/**'
      - 'test_*/**'
      - 'test-*/**'
      - .github/**
    paths:
      - app/**
    branches:
        - main
        - develop            