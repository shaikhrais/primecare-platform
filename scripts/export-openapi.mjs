#!/usr/bin/env node
/**
 * Export OpenAPI Spec — Fetches the OpenAPI JSON from the running worker-api
 * 
 * Usage:
 *   node scripts/export-openapi.mjs                         # defaults to localhost:8787
 *   node scripts/export-openapi.mjs https://api.example.com # custom base URL
 * 
 * Prerequisites:
 *   Run `npm run dev:api` (wrangler dev) in another terminal first.
 * 
 * Output:
 *   packages/contracts/openapi.json
 */
import { writeFileSync, mkdirSync } from 'fs';
import { resolve, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const OUTPUT_PATH = resolve(__dirname, '..', 'packages', 'contracts', 'openapi.json');

const baseUrl = process.argv[2] || 'http://localhost:8700';
const specUrl = `${baseUrl}/openapi.json`;

async function main() {
    console.log(`📡 Fetching OpenAPI spec from ${specUrl}...`);

    try {
        const res = await fetch(specUrl);
        if (!res.ok) {
            throw new Error(`HTTP ${res.status}: ${res.statusText}`);
        }

        const spec = await res.json();
        const pathCount = Object.keys(spec.paths || {}).length;
        const schemaCount = Object.keys(spec.components?.schemas || {}).length;

        // Ensure output directory exists
        mkdirSync(dirname(OUTPUT_PATH), { recursive: true });
        writeFileSync(OUTPUT_PATH, JSON.stringify(spec, null, 2), 'utf-8');

        console.log(`✅ Spec written to packages/contracts/openapi.json`);
        console.log(`   📊 ${pathCount} paths, ${schemaCount} schemas`);
        console.log(`   📋 OpenAPI version: ${spec.openapi}`);
        console.log(`   🏷️  API title: ${spec.info?.title}`);
    } catch (err) {
        if (err.cause?.code === 'ECONNREFUSED') {
            console.error(`\n❌ Connection refused at ${specUrl}`);
            console.error(`   Make sure the worker-api dev server is running:`);
            console.error(`   $ npm run dev:api\n`);
        } else {
            console.error(`\n❌ Failed to fetch OpenAPI spec: ${err.message}\n`);
        }
        process.exit(1);
    }
}

main();
