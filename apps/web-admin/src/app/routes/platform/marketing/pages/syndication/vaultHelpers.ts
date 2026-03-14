// SocialMediaCredentialVault: OAuth connect handlers extracted
export interface SocialPlatform {
    id: string; platformName: string; iconUrl: string; accountName: string | null;
    status: 'CONNECTED' | 'DISCONNECTED' | 'EXPIRED'; lastSync: string | null;
    tokenExpiry: string | null; permissions: string[];
}

export function getStatusColor(status: SocialPlatform['status']): string {
    switch(status) { case 'CONNECTED': return '#16A34A'; case 'DISCONNECTED': return '#64748B'; case 'EXPIRED': return '#DC2626'; }
}

export function getStatusBg(status: SocialPlatform['status']): string {
    switch(status) { case 'CONNECTED': return '#F0FDF4'; case 'DISCONNECTED': return '#F8FAFC'; case 'EXPIRED': return '#FEF2F2'; }
}
