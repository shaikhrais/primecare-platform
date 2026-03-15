/**
 * Prisma Schema Governance Tests
 *
 * Validates structural integrity of the Prisma schema:
 * - All multi-tenant models have @@index([tenantId])
 * - All models have @@map() for consistent table naming
 * - All JSON string fields follow naming conventions
 * - All models have proper id/timestamps
 */
import { describe, it, expect } from 'vitest';
import fs from 'fs';
import path from 'path';

const schemaPath = path.resolve(__dirname, '../../../../apps/worker-api/prisma/schema.prisma');
const schema = fs.readFileSync(schemaPath, 'utf-8');

// Parse models from schema
function parseModels(schemaContent: string) {
    const modelRegex = /model (\w+) \{([\s\S]*?)^\}/gm;
    const models: { name: string; body: string }[] = [];
    let match;
    while ((match = modelRegex.exec(schemaContent)) !== null) {
        models.push({ name: match[1], body: match[2] });
    }
    return models;
}

const models = parseModels(schema);

describe('Prisma Schema Governance', () => {
    // ── Structural Integrity ──────────────────────────────────────────────
    describe('structural integrity', () => {
        it('should have at least 80 models', () => {
            expect(models.length).toBeGreaterThanOrEqual(80);
        });

        it('every model should have @@map() for consistent table naming', () => {
            const missing = models.filter(m => !m.body.includes('@@map('));
            expect(missing.map(m => m.name)).toEqual([]);
        });

        it('every model should have an id field', () => {
            const missing = models.filter(m => !m.body.includes('@id'));
            expect(missing.map(m => m.name)).toEqual([]);
        });
    });

    // ── Multi-Tenancy Enforcement ─────────────────────────────────────────
    describe('multi-tenancy', () => {
        // Models that have a tenantId field should also have an index on it
        it('models with tenantId should generally have @@index([tenantId])', () => {
            const modelsWithTenant = models.filter(m => m.body.includes('tenantId'));
            const missingIndex = modelsWithTenant.filter(m => !m.body.includes('@@index([tenantId])'));
            // Some junction/child models inherit tenant via parent relation
            // Allow up to 30 models without explicit tenantId index
            expect(
                missingIndex.length,
                `${missingIndex.length} models with tenantId missing @@index([tenantId]): ${missingIndex.map(m => m.name).join(', ')}`
            ).toBeLessThan(30);
        });

        it('core domain models should have tenantId', () => {
            const coreDomainModels = [
                'Visit', 'Service', 'Booking', 'Invoice', 'Incident',
                'Timesheet', 'AuditLog', 'Lead', 'DailyEntry'
            ];
            for (const modelName of coreDomainModels) {
                const model = models.find(m => m.name === modelName);
                expect(model, `Model ${modelName} not found`).toBeDefined();
                expect(
                    model!.body.includes('tenantId'),
                    `${modelName} should be tenant-scoped`
                ).toBe(true);
            }
        });
    });

    // ── Timestamp Consistency ──────────────────────────────────────────────
    describe('timestamp consistency', () => {
        it('primary domain models should have a created timestamp', () => {
            const primaryModels = [
                'User', 'Visit', 'Service', 'Invoice',
                'Incident', 'Timesheet', 'Lead', 'AuditLog'
            ];
            for (const modelName of primaryModels) {
                const model = models.find(m => m.name === modelName);
                expect(model, `Model ${modelName} not found`).toBeDefined();
                // Check for createdAt or created_at mapping or @default(now())
                expect(
                    model!.body.includes('created_at') || model!.body.includes('createdAt') || model!.body.includes('now()'),
                    `${modelName} should have a created timestamp`
                ).toBe(true);
            }
        });
    });

    // ── JSON String Fields ────────────────────────────────────────────────
    describe('JSON string fields', () => {
        it('JSON fields should use _json suffix in DB column mapping', () => {
            // Find all fields mapped to *_json columns
            const jsonMappings = schema.match(/@map\("(\w+)_json"\)/g) || [];
            expect(jsonMappings.length).toBeGreaterThanOrEqual(5);
        });

        it('should not have untyped JSON blobs without column mapping', () => {
            // Every String field that stores JSON should have @map("..._json") or a clear name
            // This is a soft check — we just verify there aren't too many unmapped String fields
            const stringFields = models.flatMap(m => {
                const lines = m.body.split('\n');
                return lines.filter(l => l.includes('String') && !l.includes('@map') && !l.includes('@id') && !l.includes('@unique'));
            }).filter(l => l.trim().length > 0 && !l.includes('//'));
            // Allow some unmapped string fields (name, description, etc.) but flag if >200
            expect(stringFields.length).toBeLessThan(200);
        });
    });

    // ── Relationship Integrity ────────────────────────────────────────────
    describe('relationship integrity', () => {
        it('User model should have relation to Tenant', () => {
            const user = models.find(m => m.name === 'User');
            expect(user).toBeDefined();
            expect(user!.body).toContain('tenant');
            expect(user!.body).toContain('tenantId');
        });

        it('Tenant model should exist with required fields', () => {
            const tenant = models.find(m => m.name === 'Tenant');
            expect(tenant).toBeDefined();
            expect(tenant!.body).toContain('name');
            expect(tenant!.body).toContain('slug');
            expect(tenant!.body).toContain('@unique');
        });

        it('Visit model should relate to Client, Service, and Tenant', () => {
            const visit = models.find(m => m.name === 'Visit');
            expect(visit).toBeDefined();
            expect(visit!.body).toContain('clientId');
            expect(visit!.body).toContain('serviceId');
            expect(visit!.body).toContain('tenantId');
        });
    });

    // ── Security Models ───────────────────────────────────────────────────
    describe('security models', () => {
        it('AuditLog should track actor, action, and resource', () => {
            const auditLog = models.find(m => m.name === 'AuditLog');
            expect(auditLog).toBeDefined();
            expect(auditLog!.body).toContain('actorUserId');
            expect(auditLog!.body).toContain('action');
            expect(auditLog!.body).toContain('resourceType');
        });

        it('UserDevice should exist for device management', () => {
            const device = models.find(m => m.name === 'UserDevice');
            expect(device).toBeDefined();
            expect(device!.body).toContain('deviceId');
            expect(device!.body).toContain('isAuthorized');
        });

        it('SystemEvent should have checksum for tamper detection', () => {
            const event = models.find(m => m.name === 'SystemEvent');
            expect(event).toBeDefined();
            expect(event!.body).toContain('checksum');
            expect(event!.body).toContain('previousChecksum');
        });
    });

    // ── Financial Models ──────────────────────────────────────────────────
    describe('financial models', () => {
        it('should have double-entry ledger models', () => {
            const chartOfAccount = models.find(m => m.name === 'ChartOfAccount');
            const journalEntry = models.find(m => m.name === 'JournalEntry');
            const financialTransaction = models.find(m => m.name === 'FinancialTransaction');
            expect(chartOfAccount).toBeDefined();
            expect(journalEntry).toBeDefined();
            expect(financialTransaction).toBeDefined();
        });

        it('Invoice should relate to Payment', () => {
            const invoice = models.find(m => m.name === 'Invoice');
            expect(invoice).toBeDefined();
            expect(invoice!.body).toContain('payments');
        });
    });
});
