// L18 AssessmentsHub: Assessment interface and helpers extracted
export interface Assessment {
    id: string; type: string; clientId: string; score: number; createdAt: string;
    client: { fullName: string; };
}

export function getTypePillClass(type: string): string {
    const t = type.toLowerCase();
    if (t.includes('adl')) return 'adl';
    if (t.includes('mobility')) return 'mobility';
    if (t.includes('cognitive')) return 'cognitive';
    return 'vital';
}
