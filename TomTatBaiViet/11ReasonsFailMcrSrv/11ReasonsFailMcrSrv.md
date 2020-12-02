# ***11 Reasons Why You Are Going To Fail With Microservices***
> [Link](https://medium.com/xebia-engineering/11-reasons-why-you-are-going-to-fail-with-microservices-29b93876268b)

- [***11 Reasons Why You Are Going To Fail With Microservices***](#11-reasons-why-you-are-going-to-fail-with-microservices)
  - [TLDR:](#tldr)
  - [**1. Complexity**](#1-complexity)
  - [**2. No update libraries and tools process**](#2-no-update-libraries-and-tools-process)
  - [**3. Use shared service**](#3-use-shared-service)
  - [**4. Lack of visibility in version control**](#4-lack-of-visibility-in-version-control)
  - [**5. No clear definition**](#5-no-clear-definition)
  - [**6. No clear strategy on code reuse**](#6-no-clear-strategy-on-code-reuse)
  - [**7. Polyglot programming**](#7-polyglot-programming)
  - [**8. People dependency**](#8-people-dependency)
  - [**9. Lack of documentation**](#9-lack-of-documentation)
  - [**10. Feature over platform maturity**](#10-feature-over-platform-maturity)
  - [**11. Lack of automated testing**](#11-lack-of-automated-testing)

## TLDR:
- Consider about using microservice architectures:
  - Hard on local developments.
  - Fragment in technologies and versions.
  - Lack of visibility in architectures.

- Use tool to automation process.
- Communication between services and developers.

## **1. Complexity**

- Need a productive local environment setup.
- Need good development machine.
- Build the entire application on a new machine without much configuration.
- Should use multiple docker-compose files to spin up different services.

## **2. No update libraries and tools process**

- Become a technical debt.
- Keep dependency versions in sync for all the services.
- Create technical debt items for these upgrades in their backlog.

## **3. Use shared service**

- Example: shared database
  - Developer can wipe out data written by another.
  - Experimentation as their work can impact some other.
  - Difficult to test changes in isolation.
  - Lose the traceability of the changes.
  - Difficult to work when you are not online.

## **4. Lack of visibility in version control**

- Group Microservices in some way from the start.

## **5. No clear definition**

- Have few large services than to have too many small services.
- Break a domain into subdomains and bounded contexts.
- Should only communicate through the published contracts.
> If two pieces of information are dependent on each other, they should belong to a single server. In other words, the natural boundaries for a service should be the natural boundaries of its data.

## **6. No clear strategy on code reuse**

- Copy and paste code -> need to applied fix multiple times.
- Use an artifact manager like Bintray or Nexus and publish dependencies.
- Tooling to make it easy to upgrade Microservices so that a human does not have to do this.

## **7. Polyglot programming**

- Use multiples technologies -> Hard to maintain and share knowlegde.
- Need to Publishes a list of languages that teams can use.
- Think before you choose a language.

## **8. People dependency**

- teams don’t understand the complete ecosystem.
- Create overall architecture team roadmap and goals.

## **9. Lack of documentation**

- Minimum:
  - Design documents.
  - Context and container diagrams.
  - Keeping track of key architecture decisions.
  - Developer onboarding guide.

## **10. Feature over platform maturity**

- Features built on a weak platform fail to deliver value.
- Need to get into the platform mentality.

## **11. Lack of automated testing**

- Automation testing is in the overall quality of the product