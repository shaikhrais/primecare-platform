/**
 * Hierarchical Governance Roles for PrimeCare Platform
 * Synchronized with packages/flutter_core/lib/models/governance_role.dart
 */

export type PlatformRole =
    | 'ADMIN'
    | 'CEO'
    | 'CISO'
    | 'SCRUM_MASTER'
    | 'COO'
    | 'CFO'
    | 'CTO'
    | 'FINANCE_DIRECTOR'
    | 'HR_DIRECTOR'
    | 'CLINICAL_DIRECTOR'
    | 'REGIONAL_MANAGER'
    | 'FRANCHISE_OWNER'
    | 'OPERATIONS_MANAGER'
    | 'MANAGER'
    | 'COORDINATOR'
    | 'RN'
    | 'RPN'
    | 'PSW'
    | 'STAFF'
    | 'CLIENT'
    | 'PUBLIC';

export const ROLE_WEIGHTS: Record<PlatformRole, number> = {
    'ADMIN': 1000,          // Absolute System Authority
    'CEO': 100,            // Highest Corporate Authority
    'CISO': 95,            // Security & Governance Lead
    'SCRUM_MASTER': 90,     // Architectural & Platform Governance
    'COO': 85,             // Operations Lead
    'CFO': 85,             // Financial Lead
    'CTO': 85,             // Technology Lead
    'FINANCE_DIRECTOR': 80,
    'HR_DIRECTOR': 80,
    'CLINICAL_DIRECTOR': 80,
    'REGIONAL_MANAGER': 70,
    'FRANCHISE_OWNER': 65,
    'OPERATIONS_MANAGER': 60,
    'MANAGER': 55,
    'COORDINATOR': 50,
    'RN': 45,
    'RPN': 40,
    'PSW': 35,
    'STAFF': 30,
    'CLIENT': 10,
    'PUBLIC': 0,
};

/**
 * Checks if a role is superior or equal to a target role.
 */
export function isSuperiorOrEqual(role: string, targetRole: PlatformRole): boolean {
    const roleUpper = role.toUpperCase() as PlatformRole;
    const currentWeight = ROLE_WEIGHTS[roleUpper] || 0;
    const targetWeight = ROLE_WEIGHTS[targetRole] || 0;
    return currentWeight >= targetWeight;
}

/**
 * Checks if a role is strictly superior to a target role.
 */
export function isSuperior(role: string, targetRole: PlatformRole): boolean {
    const roleUpper = role.toUpperCase() as PlatformRole;
    const currentWeight = ROLE_WEIGHTS[roleUpper] || 0;
    const targetWeight = ROLE_WEIGHTS[targetRole] || 0;
    return currentWeight > targetWeight;
}

/**
 * Resolves a role string to its canonical PlatformRole.
 */
export function resolveRole(roleName: string): PlatformRole {
    const normalized = roleName.toUpperCase().replace(/_/g, '');
    
    if (normalized === 'SUPERADMIN') return 'ADMIN';
    if (normalized === 'SCRUMMASTER') return 'SCRUM_MASTER';
    if (normalized === 'FINANCEDIRECTOR') return 'FINANCE_DIRECTOR';
    if (normalized === 'HRDIRECTOR') return 'HR_DIRECTOR';
    if (normalized === 'CLINICALDIRECTOR') return 'CLINICAL_DIRECTOR';
    if (normalized === 'REGIONALMANAGER') return 'REGIONAL_MANAGER';
    if (normalized === 'FRANCHISEOWNER') return 'FRANCHISE_OWNER';
    if (normalized === 'OPERATIONSMANAGER') return 'OPERATIONS_MANAGER';

    // Fallback to direct mapping if it exists in weights
    if (normalized in ROLE_WEIGHTS) return normalized as PlatformRole;
    
    return 'PUBLIC';
}
