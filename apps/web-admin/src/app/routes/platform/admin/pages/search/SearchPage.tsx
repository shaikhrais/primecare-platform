import React, { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';

const { ApiRegistry } = AdminRegistry;

const SearchPage: React.FC = () => {
    const { t } = useTranslation();
    const [query, setQuery] = useState('');
    const [results, setResults] = useState<any>(null);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);

    const handleSearch = async (q: string) => {
        if (q.length < 2) {
            setResults(null);
            return;
        }
        setLoading(true);
        setError(null);
        try {
            const resp = await apiClient.get(`${ApiRegistry.ADMIN.SEARCH}?q=${encodeURIComponent(q)}`);
            if (resp.ok) {
                const data = await resp.json();
                setResults(data.results);
            } else {
                const data = await resp.json();
                setError(data.error || 'Search failed');
            }
        } catch (err: any) {
            setError(err.message || 'Search failed');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        const timer = setTimeout(() => {
            if (query) handleSearch(query);
        }, 500);
        return () => clearTimeout(timer);
    }, [query]);

    return (
        <div className="p-6 max-w-6xl mx-auto space-y-8">
            <header className="space-y-2">
                <h1 className="text-3xl font-bold tracking-tight">{t('platform.admin.search.title', 'Global Platform Search')}</h1>
                <p className="text-muted-foreground">{t('platform.admin.search.subtitle', 'Search across users, clients, leads, and incidents.')}</p>
            </header>

            <div className="relative">
                <span className="absolute left-3 top-1/2 -translate-y-1/2 text-xl opacity-50">🔍</span>
                <input
                    type="text"
                    placeholder={t('platform.admin.search.placeholder', 'Type to search...')}
                    className="w-full pl-12 pr-4 py-4 rounded-xl border bg-background text-lg shadow-sm focus:ring-2 focus:ring-primary outline-none transition-all"
                    value={query}
                    onChange={(e) => setQuery(e.target.value)}
                    autoFocus
                />
                {loading && (
                    <div className="absolute right-4 top-1/2 -translate-y-1/2">
                        <div className="animate-spin rounded-full h-5 w-5 border-b-2 border-primary"></div>
                    </div>
                )}
            </div>

            {error && (
                <div className="p-4 rounded-lg bg-destructive/10 text-destructive flex items-center gap-2">
                    <span className="text-xl">⚠️</span>
                    <span>{error}</span>
                </div>
            )}

            {results && (
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    {/* Users */}
                    <ResultSection
                        title="Users"
                        icon={<span className="text-xl">👤</span>}
                        data={results.users}
                        renderItem={(u: any) => (
                            <div key={u.id} className="p-4 rounded-lg border bg-card hover:bg-accent/5 transition-colors flex justify-between items-center group">
                                <div>
                                    <p className="font-medium">{u.email}</p>
                                    <p className="text-xs text-muted-foreground capitalize">{u.roles.join(', ')} • {u.status}</p>
                                </div>
                                <span className="opacity-0 group-hover:opacity-100 transition-opacity">➡️</span>
                            </div>
                        )}
                    />

                    {/* Clients */}
                    <ResultSection
                        title="Clients"
                        icon={<span className="text-xl">🏠</span>}
                        data={results.clients}
                        renderItem={(c: any) => (
                            <div key={c.id} className="p-4 rounded-lg border bg-card hover:bg-accent/5 transition-colors flex justify-between items-center group">
                                <div>
                                    <p className="font-medium">{c.fullName}</p>
                                    <p className="text-xs text-muted-foreground">{c.city} • {c.user?.email}</p>
                                </div>
                                <span className="opacity-0 group-hover:opacity-100 transition-opacity">➡️</span>
                            </div>
                        )}
                    />

                    {/* Leads */}
                    <ResultSection
                        title="Leads"
                        icon={<span className="text-xl">📋</span>}
                        data={results.leads}
                        renderItem={(l: any) => (
                            <div key={l.id} className="p-4 rounded-lg border bg-card hover:bg-accent/5 transition-colors flex justify-between items-center group">
                                <div>
                                    <p className="font-medium">{l.fullName}</p>
                                    <p className="text-xs text-muted-foreground">{l.email} • {l.status}</p>
                                </div>
                                <span className="opacity-0 group-hover:opacity-100 transition-opacity">➡️</span>
                            </div>
                        )}
                    />

                    {/* Incidents */}
                    <ResultSection
                        title="Incidents"
                        icon={<span className="text-xl">🚨</span>}
                        data={results.incidents}
                        renderItem={(i: any) => (
                            <div key={i.id} className="p-4 rounded-lg border bg-card hover:bg-accent/5 transition-colors flex justify-between items-center group">
                                <div className="flex-1 min-w-0">
                                    <p className="font-medium truncate">{i.description}</p>
                                    <p className="text-xs text-muted-foreground uppercase">{i.type} • {i.status}</p>
                                </div>
                                <span className="opacity-0 group-hover:opacity-100 transition-opacity">➡️</span>
                            </div>
                        )}
                    />
                </div>
            )}

            {!results && !loading && !query && (
                <div className="flex flex-col items-center justify-center py-20 text-muted-foreground opacity-50">
                    <span className="text-6xl mb-4">🔍</span>
                    <p className="text-xl">Enter a search term to begin</p>
                </div>
            )}
        </div>
    );
};

interface ResultSectionProps {
    title: string;
    icon: React.ReactNode;
    data: any[];
    renderItem: (item: any) => React.ReactNode;
}

const ResultSection: React.FC<ResultSectionProps> = ({ title, icon, data, renderItem }) => (
    <div className="space-y-4">
        <div className="flex items-center gap-2 border-b pb-2">
            {icon}
            <h2 className="font-semibold text-lg">{title} ({data.length})</h2>
        </div>
        <div className="space-y-2">
            {data.length > 0 ? (
                data.map(renderItem)
            ) : (
                <p className="text-sm text-muted-foreground italic">No results found</p>
            )}
        </div>
    </div>
);

export default SearchPage;
