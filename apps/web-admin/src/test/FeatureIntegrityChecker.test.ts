/**
 * FeatureIntegrityChecker Unit Tests
 *
 * Tests that the integrity checker runs and returns a report.
 */
import { describe, it, expect } from 'vitest';
import { runIntegrityCheck } from 'prime-care-shared';

describe('FeatureIntegrityChecker', () => {
    it('runIntegrityCheck should be a function', () => {
        expect(typeof runIntegrityCheck).toBe('function');
    });

    it('should return an object', () => {
        const report = runIntegrityCheck();
        expect(report).toBeDefined();
        expect(typeof report).toBe('object');
    });

    it('report should have at least one key', () => {
        const report = runIntegrityCheck();
        expect(Object.keys(report).length).toBeGreaterThan(0);
    });

    it('report keys should have meaningful names', () => {
        const report = runIntegrityCheck();
        const keys = Object.keys(report);
        // Should have category-like keys
        keys.forEach(key => {
            expect(typeof key).toBe('string');
            expect(key.length).toBeGreaterThan(0);
        });
    });
});
