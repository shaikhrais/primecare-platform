#!/bin/bash

# PrimeCare Postman/Newman Quality Assurance Orchestrator
# This script executes the exhaustive 597+ endpoint test matrices generated from the codebase.

echo "========================================================="
echo "🛡️  Booting PrimeCare Zero-Trust QA Perimeter Scanner 🛡️"
echo "========================================================="

# Load Test Environment (Tokens and Target URL)
if [ -f .env.test ]; then
    export $(cat .env.test | grep -v '^#' | xargs)
    echo "[SYSTEM] Injected physical .env.test variables -> Local Newman runtime"
else
    echo "[WARNING] .env.test File not found! Network mappings will degrade to '{{BASE_URL}}' raw format."
fi

# Ensure newman and html reporter are available locally
if ! command -v newman &> /dev/null; then
    echo "[INSTALLING] Newman CLI not found globally. Installing local instance via NPX..."
    npm install -g newman newman-reporter-html
fi

echo "[EXECUTION] Launching HTML reporting interceptors for 10 boundary microservices..."

# Run Collection using newman
npx newman run artifacts/primecare.postman_collection.json \
  --env-var "BASE_URL=${BASE_URL:-http://localhost:8700}" \
  --env-var "ADMIN_TOKEN=${ADMIN_TOKEN}" \
  --env-var "INVALID_TOKEN=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.INVALID" \
  --env-var "EXPIRED_TOKEN=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.EXPIRED" \
  --env-var "CLIENT_TOKEN=${CLIENT_TOKEN}" \
  --env-var "FOREIGN_TENANT_TOKEN=${FOREIGN_TENANT_TOKEN}" \
  -r cli,html \
  --reporter-html-export artifacts/security-report.html

echo "========================================================="
echo "✅  QA Perimeter Complete! View 'artifacts/security-report.html' for exhaustive security logging."
echo "========================================================="
