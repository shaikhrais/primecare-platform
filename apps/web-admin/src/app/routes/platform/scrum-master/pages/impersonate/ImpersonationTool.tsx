import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';

const { ApiRegistry } = AdminRegistry;

export default function ImpersonationTool() {
    const { t } = useTranslation();
    const [searchQuery, setSearchQuery] = useState('');
    const [users, setUsers] = useState<any[]>([]);
    const [loading, setLoading] = useState(false);
    const [selectedUser, setSelectedUser] = useState<any>(null);
    const [isImpersonating, setIsImpersonating] = useState(false);

    const CONTENT = AdminRegistry.ContentRegistry.IMPERSONATION;

    const handleSearch = async () => {
        setLoading(true);
        try {
            const resp = await apiClient.get(`${ApiRegistry.ADMIN.USERS}?q=${searchQuery}`);
            if (resp.ok) {
                const data = await resp.json();
                setUsers(data.users || []);
            }
        } catch (err) {
            console.error('Search failed', err);
        } finally {
            setLoading(false);
        }
    };

    const handleImpersonate = async (user: any) => {
        setIsImpersonating(true);
        setSelectedUser(user);

 // the impersonation logic
        await new Promise(resolve => setTimeout(resolve, 2000));

        localStorage.setItem('impersonated_user', JSON.stringify(user));
        window.location.href = AdminRegistry.RouteRegistry.ADMIN.DASHBOARD;
    };

    return (
        <div className="p-8 max-w-6xl mx-auto space-y-8">
            <header className="space-y-2">
                <h1 className="text-3xl font-black tracking-tight flex items-center gap-3">
                    <span>👥</span> {t(CONTENT.TITLE)}
                </h1>
                <p className="text-muted-foreground">{t(CONTENT.SUBTITLE)}</p>
            </header>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <div className="lg:col-span-2 space-y-6">
                    <div className="bg-card border rounded-2xl p-6 shadow-sm">
                        <div className="flex gap-4">
                            <div className="relative flex-1">
                                <span className="absolute left-4 top-1/2 -translate-y-1/2 text-lg opacity-50">🔍</span>
                                <input
                                    type="text"
                                    placeholder={t(CONTENT.SEARCH_PLACEHOLDER)}
                                    className="w-full pl-12 pr-4 py-3 rounded-xl border bg-background focus:ring-2 focus:ring-primary outline-none transition-all"
                                    value={searchQuery}
                                    onChange={(e) => setSearchQuery(e.target.value)}
                                    onKeyDown={(e) => e.key === 'Enter' && handleSearch()}
                                />
                            </div>
                            <button
                                onClick={handleSearch}
                                disabled={loading}
                                className="px-6 py-3 bg-primary text-primary-foreground rounded-xl font-bold hover:opacity-90 transition-all disabled:opacity-50"
                            >
                                {loading ? t(CONTENT.SEARCHING) : t(CONTENT.SEARCH_BTN)}
                            </button>
                        </div>
                    </div>

                    <div className="space-y-4">
                        <h2 className="text-sm font-bold uppercase tracking-widest text-muted-foreground flex justify-between items-center px-2">
                            <span>{t(CONTENT.RESULTS_TITLE)}</span>
                            <span>{CONTENT.MATCH_COUNT(users.length)}</span>
                        </h2>

                        <div className="grid grid-cols-1 gap-4">
                            {users.map(user => (
                                <div key={user.id} className="bg-card border rounded-2xl p-5 flex items-center justify-between group hover:border-primary transition-all shadow-sm">
                                    <div className="flex items-center gap-4">
                                        <div className="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center text-xl">
                                            {user.roles.includes('admin') ? '👑' : '👤'}
                                        </div>
                                        <div>
                                            <div className="font-bold text-lg">{user.email}</div>
                                            <div className="flex gap-2 mt-1">
                                                {user.roles.map((role: string) => (
                                                    <span key={role} className="text-[10px] font-black uppercase px-2 py-0.5 bg-secondary rounded-full border">
                                                        {role}
                                                    </span>
                                                ))}
                                                <span className="text-[10px] font-black uppercase px-2 py-0.5 bg-green-500/10 text-green-600 rounded-full border border-green-500/20">
                                                    {user.status}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <button
                                        onClick={() => setSelectedUser(user)}
                                        className="px-4 py-2 text-sm font-bold bg-secondary hover:bg-primary hover:text-primary-foreground rounded-lg transition-all opacity-0 group-hover:opacity-100"
                                    >
                                        {t(CONTENT.INSPECT_BTN)}
                                    </button>
                                </div>
                            ))}

                            {users.length === 0 && !loading && (
                                <div className="py-20 text-center text-muted-foreground bg-secondary/30 rounded-3xl border-2 border-dashed">
                                    <div className="text-5xl mb-4">🕵️</div>
                                    <p className="font-medium">{t(CONTENT.EMPTY_STATE)}</p>
                                    <p className="text-xs">{t(CONTENT.EMPTY_DESC)}</p>
                                </div>
                            )}
                        </div>
                    </div>
                </div>

                <div className="space-y-6">
                    <div className={`bg-card border rounded-3xl p-8 transition-all duration-500 ${selectedUser ? 'border-primary ring-4 ring-primary/5' : 'opacity-50'}`}>
                        {selectedUser ? (
                            <div className="space-y-6">
                                <div className="text-center">
                                    <div className="w-24 h-24 rounded-full bg-primary/10 flex items-center justify-center text-4xl mx-auto mb-4 border-4 border-background shadow-xl">
                                        💎
                                    </div>
                                    <h3 className="text-xl font-black">{selectedUser.email}</h3>
                                    <p className="text-sm text-muted-foreground">{AdminRegistry.ContentRegistry.USERS.TENANT_ID}: {selectedUser.tenantId || 'GLOBAL'}</p>
                                </div>

                                <div className="space-y-3 pt-6 border-t">
                                    <div className="flex justify-between text-xs">
                                        <span className="text-muted-foreground font-bold uppercase">{AdminRegistry.ContentRegistry.USERS.ROLE}</span>
                                        <span className="font-mono">{selectedUser.roles[0].toUpperCase()}</span>
                                    </div>
                                    <div className="flex justify-between text-xs">
                                        <span className="text-muted-foreground font-bold uppercase">Auth Provider</span>
                                        <span className="font-mono text-primary">KINDE_OIDC</span>
                                    </div>
                                    <div className="flex justify-between text-xs">
                                        <span className="text-muted-foreground font-bold uppercase">Last Active</span>
                                        <span className="font-mono">Today, 14:22</span>
                                    </div>
                                </div>

                                <div className="pt-6">
                                    <button
                                        onClick={() => handleImpersonate(selectedUser)}
                                        disabled={isImpersonating}
                                        className="w-full py-4 bg-primary text-primary-foreground rounded-2xl font-black text-lg shadow-xl shadow-primary/20 hover:scale-[1.02] active:scale-[0.98] transition-all flex items-center justify-center gap-3 disabled:opacity-50"
                                    >
                                        {isImpersonating ? t(CONTENT.MODAL.SHIFTING) : t(CONTENT.MODAL.SHADOW_BTN)}
                                    </button>
                                    <p className="text-[10px] text-center text-muted-foreground mt-4 leading-relaxed px-4">
                                        {t(CONTENT.MODAL.FOOTER)}
                                    </p>
                                </div>
                            </div>
                        ) : (
                            <div className="text-center py-20 space-y-4">
                                <div className="text-4xl opacity-20">🕳️</div>
                                <p className="text-sm font-bold text-muted-foreground uppercase tracking-widest leading-relaxed">
                                    {t(CONTENT.MODAL.SELECT_PROMPT).split('view')[0]}<br />{t(CONTENT.MODAL.SELECT_PROMPT).split('view')[1]}
                                </p>
                            </div>
                        )}
                    </div>

                    <div className="bg-zinc-900 text-white rounded-3xl p-6 space-y-4">
                        <div className="flex items-center gap-2 text-xs font-black text-primary uppercase tracking-tighter">
                            <span className="w-2 h-2 rounded-full bg-primary animate-ping"></span>
                            {t(CONTENT.GOVERNANCE.TITLE)}
                        </div>
                        <p className="text-xs text-zinc-400 leading-relaxed">
                            {t(CONTENT.GOVERNANCE.FOOTER)}
                        </p>
                    </div>
                </div>
            </div>
        </div>
    );
}
