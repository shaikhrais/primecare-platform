// ================================================================
// PAGE IDENTITY: H14 � Credential Vault
// Type: Hub | Owner: psw
// ================================================================
import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';

interface Credential {
    id: string;
    name: string;
    issuer: string;
    issueDate: string;
    expiryDate: string;
    status: 'active' | 'expiring' | 'expired' | 'pending';
    documentUrl?: string;
}

export default function CredentialVault() {
    const { t } = useTranslation();
    const [credentials, setCredentials] = useState<Credential[]>([
        { id: '1', name: 'CPR/First Aid - BLS', issuer: 'Red Cross', issueDate: '2025-01-15', expiryDate: '2026-01-15', status: 'active' },
        { id: '2', name: 'Vulnerable Sector Check', issuer: 'Regional Police', issueDate: '2024-06-10', expiryDate: '2025-06-10', status: 'expiring' },
        { id: '3', name: 'PSW Certification', issuer: 'Ontario Health', issueDate: '2023-09-20', expiryDate: 'Never', status: 'active' },
        { id: '4', name: 'TB Skin Test', issuer: 'Public Health', issueDate: '2024-03-05', expiryDate: '2025-03-05', status: 'expired' },
    ]);

    const getStatusStyles = (status: string) => {
        switch (status) {
            case 'active': return 'bg-green-500/10 text-green-600 border-green-500/20';
            case 'expiring': return 'bg-orange-500/10 text-orange-600 border-orange-500/20';
            case 'expired': return 'bg-red-500/10 text-red-600 border-red-500/20';
            case 'pending': return 'bg-blue-500/10 text-blue-600 border-blue-500/20';
            default: return 'bg-zinc-500/10 text-zinc-600 border-zinc-500/20';
        }
    };

    return (
        <div className="p-8 max-w-5xl mx-auto space-y-8 animate-in fade-in slide-in-from-bottom-4 duration-500">
            <header className="flex justify-between items-center">
                <div>
                    <h1 className="text-3xl font-black tracking-tight">Credential Vault</h1>
                    <p className="text-muted-foreground">Manage your clinical certifications and compliance documentation.</p>
                </div>
                <button className="px-6 py-3 bg-primary text-primary-foreground rounded-xl font-bold hover:opacity-90 transition-all flex items-center gap-2">
                    <span>➕</span> Upload New
                </button>
            </header>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                {credentials.map(cred => (
                    <div key={cred.id} className="bg-card border rounded-2xl p-6 shadow-sm hover:border-primary transition-all group flex flex-col justify-between">
                        <div className="space-y-4">
                            <div className="flex justify-between items-start">
                                <div className="p-3 bg-secondary rounded-xl text-2xl">
                                    {cred.name.includes('Check') ? '👮' : cred.name.includes('Test') ? '🔬' : '📜'}
                                </div>
                                <span className={`px-2 py-0.5 rounded-full text-[10px] font-black uppercase border ${getStatusStyles(cred.status)}`}>
                                    {cred.status}
                                </span>
                            </div>
                            <div>
                                <h3 className="text-lg font-bold group-hover:text-primary transition-colors">{cred.name}</h3>
                                <p className="text-xs text-muted-foreground font-medium">{cred.issuer}</p>
                            </div>
                            <div className="flex justify-between text-xs pt-4 border-t border-dashed">
                                <div className="space-y-1">
                                    <div className="text-muted-foreground uppercase font-black text-[8px] tracking-widest">Issued</div>
                                    <div className="font-mono font-bold">{cred.issueDate}</div>
                                </div>
                                <div className="space-y-1 text-right">
                                    <div className="text-muted-foreground uppercase font-black text-[8px] tracking-widest">Expires</div>
                                    <div className={`font-mono font-bold ${cred.status === 'expired' ? 'text-red-500' : cred.status === 'expiring' ? 'text-orange-500' : ''}`}>
                                        {cred.expiryDate}
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="mt-6 flex gap-3">
                            <button className="flex-1 py-2 bg-secondary hover:bg-zinc-200 rounded-lg text-xs font-bold transition-all">
                                View File
                            </button>
                            <button className="flex-1 py-2 border hover:bg-accent rounded-lg text-xs font-bold transition-all">
                                Update
                            </button>
                        </div>
                    </div>
                ))}
            </div>

            <div className="bg-zinc-900 text-white rounded-3xl p-8 flex items-center justify-between gap-8 border-4 border-zinc-800">
                <div className="space-y-2">
                    <h3 className="text-xl font-bold text-primary">Compliance Status: <span className="text-orange-400">ACTION REQUIRED</span></h3>
                    <p className="text-sm text-zinc-400 max-w-lg">
                        You have <span className="text-red-400 font-bold">1 expired</span> and <span className="text-orange-400 font-bold">1 expiring</span> credential. Failure to update these by next week will trigger a temporary hold on your ability to claim open shifts.
                    </p>
                </div>
                <div className="hidden lg:block text-6xl opacity-20">🛡️</div>
            </div>
        </div>
    );
}
