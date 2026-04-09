# Testing Guide

This guide outlines the configuration for running Cypress tests in the PrimeCare Platform.

## Environment Configuration

Cypress tests use the `API_URL` environment variable to determine which backend API to target.

### 1. Local Development (Default)

The default configuration targets the local API at `http://localhost:8787`.

-   **File**: `tests/cypress/cypress.env.json`
-   **Setup**: Copy `cypress.env.example.json` to `cypress.env.json` if it doesn't exist.
    ```bash
    cp tests/cypress/cypress.env.example.json tests/cypress/cypress.env.json
    ```
-   **Command**:
    ```bash
    npx cypress run
    ```

### 2. Production / Staging

To run tests against a remote environment, override the `API_URL` variable via the command line.

-   **Command**:
    ```bash
    npx cypress run --env API_URL=https://your-api.workers.dev
    ```

## Shared Resources

-   **Test Accounts**: See `setup_test_accounts.cjs` in the root for seeding logic.
-   **API Endpoints**: Refer to `apps/worker-api/src/routes` for available endpoints.

## Troubleshooting

-   **403 Forbidden**: Ensure the user has the correct role (Staff/Admin) and the endpoint is public or role-protected correctly.
-   **Connection Refused**: Ensure `wrangler dev` is running for local tests.
