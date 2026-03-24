import React, { useState, useEffect, useRef, useCallback } from 'react';
import { useNavigate } from 'react-router';
import { Search, User, ClipboardList, Briefcase, X, Zap, Clock, ArrowRight } from 'lucide-react';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

interface SearchResult {
    id: string;
    type: 'patient' | 'staff' | 'module';
    name: string;
    subtitle: string;
    route: string;
}

interface QuickAction {
    id: string;
    label: string;
    icon: string;
    route: string;
    shortcut?: string;
}

const QUICK_ACTIONS: QuickAction[] = [
    // ── Core ──
    { id: 'qa-home', label: 'Go to Home', icon: '📊', route: RouteRegistry.ADMIN.HOME, shortcut: 'D' },
    { id: 'qa-schedule', label: 'Open Schedule', icon: '📅', route: RouteRegistry.ADMIN.SCHEDULE, shortcut: 'S' },
    { id: 'qa-ops-center', label: 'Operations Center', icon: '🛰️', route: RouteRegistry.ADMIN.OPERATIONS.CENTER, shortcut: 'O' },
    { id: 'qa-users', label: 'Manage Users', icon: '👥', route: RouteRegistry.ADMIN.USERS, shortcut: 'U' },
    { id: 'qa-customers', label: 'Customers', icon: '🏥', route: RouteRegistry.ADMIN.CUSTOMERS },
    { id: 'qa-search', label: 'Global Search', icon: '🔍', route: RouteRegistry.ADMIN.SEARCH },

    // ── Clinical ──
    { id: 'qa-incidents', label: 'Incidents', icon: '🚨', route: RouteRegistry.ADMIN.INCIDENTS, shortcut: 'I' },
    { id: 'qa-clinical', label: 'Clinical Assistant', icon: '🩺', route: RouteRegistry.ADMIN.CLINICAL_ASSISTANT },
    { id: 'qa-evv', label: 'EVV Home', icon: '📍', route: RouteRegistry.ADMIN.EVV.HOME },
    { id: 'qa-pharmacy', label: 'Pharmacy Hub', icon: '💊', route: RouteRegistry.ADMIN.PHARMACY.HUB },
    { id: 'qa-telehealth', label: 'Telehealth Center', icon: '📹', route: RouteRegistry.ADMIN.TELEHEALTH.CENTER },
    { id: 'qa-referrals', label: 'Referrals', icon: '🔗', route: RouteRegistry.ADMIN.REFERRALS.LIST },

    // ── Finance ──
    { id: 'qa-finance', label: 'Accounting Home', icon: '💰', route: RouteRegistry.ADMIN.FINANCE.HOME },
    { id: 'qa-ledger', label: 'Financial Ledger', icon: '📒', route: RouteRegistry.ADMIN.SECURITY.FINANCIAL_LEDGER },
    { id: 'qa-tax', label: 'Tax Compliance Hub', icon: '🧾', route: RouteRegistry.ADMIN.SECURITY.TAX_HUB },
    { id: 'qa-payroll', label: 'Payroll Hub', icon: '💵', route: RouteRegistry.ADMIN.PAYROLL_HUB },
    { id: 'qa-timesheets', label: 'Timesheets', icon: '⏱️', route: RouteRegistry.ADMIN.TIMESHEETS },
    { id: 'qa-claims', label: 'Claims', icon: '📋', route: RouteRegistry.ADMIN.CLAIMS.LIST },
    { id: 'qa-rcm', label: 'Revenue Cycle', icon: '💎', route: RouteRegistry.ADMIN.RCM.CLAIMS },
    { id: 'qa-reconciliation', label: 'Reconciliation', icon: '🔄', route: RouteRegistry.ADMIN.FINANCE.RECONCILIATION },
    { id: 'qa-earnings', label: 'Earnings', icon: '📈', route: RouteRegistry.ADMIN.EARNINGS },

    // ── Operations ──
    { id: 'qa-leads', label: 'Inquiries', icon: '📩', route: RouteRegistry.ADMIN.LEADS },
    { id: 'qa-bookings', label: 'Booking Requests', icon: '📝', route: RouteRegistry.ADMIN.BOOKING_REQUESTS },
    { id: 'qa-logistics', label: 'Logistics Hub', icon: '🚗', route: RouteRegistry.ADMIN.OPERATIONS.LOGISTICS_HUB },
    { id: 'qa-documents', label: 'Document Center', icon: '📁', route: RouteRegistry.ADMIN.DOCUMENT_CENTER },
    { id: 'qa-notifications', label: 'Notifications Hub', icon: '🔔', route: RouteRegistry.ADMIN.NOTIFICATIONS_HUB },
    { id: 'qa-onboarding', label: 'Staff Onboarding', icon: '🎓', route: RouteRegistry.ADMIN.ONBOARDING },
    { id: 'qa-admission', label: 'Client Admission', icon: '🏠', route: RouteRegistry.ADMIN.ADMISSION },

    // ── Security & Compliance ──
    { id: 'qa-security', label: 'Security Home', icon: '🛡️', route: RouteRegistry.ADMIN.SECURITY.HOME },
    { id: 'qa-governance', label: 'Security Governance', icon: '🔒', route: RouteRegistry.ADMIN.SECURITY.GOVERNANCE },
    { id: 'qa-forensics', label: 'Forensic Trails', icon: '🕵️', route: RouteRegistry.ADMIN.SECURITY.FORENSIC_TRAILS },
    { id: 'qa-sessions', label: 'Session Monitor', icon: '👁️', route: RouteRegistry.ADMIN.SECURITY.SESSION_MONITOR },
    { id: 'qa-threats', label: 'Threat Detection', icon: '⚠️', route: RouteRegistry.ADMIN.SECURITY.THREAT_DETECTION },
    { id: 'qa-audits', label: 'Audit Logs', icon: '📜', route: RouteRegistry.ADMIN.AUDITS },
    { id: 'qa-consent', label: 'Consent Management', icon: '✅', route: RouteRegistry.ADMIN.CONSENT.LIST },
    { id: 'qa-auth-list', label: 'Authorizations', icon: '📄', route: RouteRegistry.ADMIN.AUTHORIZATIONS.LIST },

    // ── AI & Intelligence ──
    { id: 'qa-ai', label: 'AI Home', icon: '🤖', route: RouteRegistry.ADMIN.AI.HOME },
    { id: 'qa-insights', label: 'AI Insights', icon: '💡', route: RouteRegistry.ADMIN.AI_INSIGHTS },
    { id: 'qa-predictive', label: 'Predictive Analytics', icon: '📡', route: RouteRegistry.ADMIN.AI.PREDICTIVE_ANALYTICS },
    { id: 'qa-churn', label: 'Churn Risk', icon: '📉', route: RouteRegistry.ADMIN.AI.CHURN_RISK },
    { id: 'qa-autopilot', label: 'AutoPilot', icon: '✈️', route: RouteRegistry.ADMIN.AUTOPILOT },

    // ── Admin & Config ──
    { id: 'qa-reports', label: 'Reports & Export', icon: '📈', route: RouteRegistry.ADMIN.REPORTS },
    { id: 'qa-settings', label: 'Settings', icon: '⚙️', route: RouteRegistry.ADMIN.SETTINGS },
    { id: 'qa-content', label: 'Content Manager', icon: '✏️', route: RouteRegistry.ADMIN.CONTENT },
    { id: 'qa-locations', label: 'Locations', icon: '📍', route: RouteRegistry.ADMIN.LOCATIONS },
    { id: 'qa-services', label: 'Services', icon: '🏷️', route: RouteRegistry.ADMIN.SERVICES },
    { id: 'qa-roles', label: 'Role Editor', icon: '🔑', route: RouteRegistry.ADMIN.ROLE_EDITOR },
    { id: 'qa-cron', label: 'Cron Home', icon: '⏰', route: RouteRegistry.ADMIN.CRON_HOME },
    { id: 'qa-webhooks', label: 'Webhooks', icon: '🪝', route: RouteRegistry.ADMIN.WEBHOOKS.LIST },
    { id: 'qa-erp', label: 'Supply Chain Hub', icon: '📦', route: RouteRegistry.ADMIN.ERP.INVENTORY },
    { id: 'qa-ref-data', label: 'Reference Data', icon: '🗂️', route: RouteRegistry.ADMIN.REFERENCE_DATA },
];

const RECENT_KEY = 'pc-cmd-recent';
const MAX_RECENT = 5;

function getRecent(): { label: string; route: string; icon: string; time: number }[] {
    try { return JSON.parse(localStorage.getItem(RECENT_KEY) || '[]'); } catch { return []; }
}

function pushRecent(label: string, route: string, icon: string) {
    const list = getRecent().filter(r => r.route !== route);
    list.unshift({ label, route, icon, time: Date.now() });
    localStorage.setItem(RECENT_KEY, JSON.stringify(list.slice(0, MAX_RECENT)));
}

export const CommandPalette: React.FC = () => {
    const [isOpen, setIsOpen] = useState(false);
    const [query, setQuery] = useState('');
    const [results, setResults] = useState<SearchResult[]>([]);
    const [selectedIndex, setSelectedIndex] = useState(0);
    const [recent, setRecent] = useState(getRecent);
    const inputRef = useRef<HTMLInputElement>(null);
    const navigate = useNavigate();

    // All navigable items for keyboard support
    const allItems = (() => {
        if (query.trim()) {
            // Filter quick actions + API results
            const qLower = query.toLowerCase();
            const filteredActions = QUICK_ACTIONS.filter(a => a.label.toLowerCase().includes(qLower));
            return [
                ...filteredActions.map(a => ({ id: a.id, label: a.label, subtitle: 'Quick Action', icon: a.icon, route: a.route, type: 'action' as const })),
                ...results.map(r => ({ id: r.id, label: r.name, subtitle: r.subtitle, icon: r.type === 'patient' ? '👤' : r.type === 'staff' ? '💼' : '📋', route: r.route, type: r.type })),
            ];
        }
        return [];
    })();

    // Ctrl+K toggle
    useEffect(() => {
        const handleKeyDown = (e: KeyboardEvent) => {
            if ((e.metaKey || e.ctrlKey) && e.key === 'k') { e.preventDefault(); setIsOpen(prev => !prev); }
            if (e.key === 'Escape' && isOpen) setIsOpen(false);
        };
        window.addEventListener('keydown', handleKeyDown);
        return () => window.removeEventListener('keydown', handleKeyDown);
    }, [isOpen]);

    useEffect(() => { if (isOpen && inputRef.current) inputRef.current.focus(); }, [isOpen]);
    useEffect(() => { if (isOpen) setRecent(getRecent()); }, [isOpen]);
    useEffect(() => { setSelectedIndex(0); }, [query, results]);

    // Live search
    useEffect(() => {
        if (!isOpen || !query.trim()) { setResults([]); return; }
        const debounce = window.setTimeout(async () => {
            try {
                const res = await fetch(`/api/v1/system/data/search?q=${encodeURIComponent(query)}`);
                if (res.ok) setResults(await res.json());
            } catch (e) { console.error('Command Palette Search Error', e); }
        }, 300);
        return () => window.clearTimeout(debounce);
    }, [query, isOpen]);

    const handleSelect = useCallback((label: string, route: string, icon: string) => {
        pushRecent(label, route, icon);
        setIsOpen(false);
        setQuery('');
        navigate(route);
    }, [navigate]);

    const handleKeyNav = (e: React.KeyboardEvent) => {
        if (e.key === 'ArrowDown') { e.preventDefault(); setSelectedIndex(i => Math.min(i + 1, allItems.length - 1)); }
        if (e.key === 'ArrowUp') { e.preventDefault(); setSelectedIndex(i => Math.max(i - 1, 0)); }
        if (e.key === 'Enter' && allItems[selectedIndex]) {
            e.preventDefault();
            const item = allItems[selectedIndex];
            handleSelect(item.label, item.route, item.icon);
        }
    };

    if (!isOpen) return null;

    return (
        <div style={{
            position: 'fixed', inset: 0, backgroundColor: 'rgba(15, 23, 42, 0.5)',
            backdropFilter: 'blur(6px)', zIndex: 99999,
            display: 'flex', alignItems: 'flex-start', justifyContent: 'center', paddingTop: '10vh'
        }}>
            <div style={{
                backgroundColor: 'var(--card-bg, white)', width: '100%', maxWidth: '640px',
                borderRadius: '16px', boxShadow: '0 25px 50px -12px rgba(0,0,0,0.25)',
                overflow: 'hidden', display: 'flex', flexDirection: 'column'
            }} onClick={(e) => e.stopPropagation()}>

                {/* Search Input */}
                <div style={{ display: 'flex', alignItems: 'center', padding: '16px 24px', borderBottom: '1px solid var(--border, #E2E8F0)' }}>
                    <Search color="#94A3B8" size={22} />
                    <input data-cy="input-shared.command-palette-0"
                        ref={inputRef} value={query}
                        onChange={(e) => setQuery(e.target.value)}
                        onKeyDown={handleKeyNav}
                        placeholder="Search or jump to... (Ctrl+K)"
                        style={{ flex: 1, border: 'none', outline: 'none', fontSize: '1.1rem', padding: '0 16px', backgroundColor: 'transparent', color: 'var(--text, #0F172A)' }}
                    />
                    <button data-cy="btn-shared.command-palette-0"
                        onClick={() => setIsOpen(false)}
                        style={{ background: 'transparent', border: 'none', color: '#94A3B8', cursor: 'pointer', padding: '4px', display: 'flex' }}>
                        <X size={20} />
                    </button>
                </div>

                <div style={{ padding: '8px 0', maxHeight: '440px', overflowY: 'auto' }}>

                    {/* Empty state: show quick actions + recent */}
                    {!query.trim() && (
                        <>
                            {/* Recent Items */}
                            {recent.length > 0 && (
                                <>
                                    <div style={{ padding: '8px 24px 4px', fontSize: '0.65rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.08em', color: 'var(--text-muted, #94A3B8)', display: 'flex', alignItems: 'center', gap: '6px' }}>
                                        <Clock size={12} /> Recent
                                    </div>
                                    {recent.map((r, idx) => (
                                        <button key={`recent-${idx}`} data-cy={`btn-recent-${idx}`}
                                            onClick={() => handleSelect(r.label, r.route, r.icon)}
                                            style={{
                                                width: '100%', display: 'flex', alignItems: 'center', gap: '12px',
                                                padding: '10px 24px', border: 'none', textAlign: 'left',
                                                cursor: 'pointer', transition: 'background 0.1s',
                                                background: 'transparent', color: 'var(--text, #0F172A)',
                                            }}
                                            onMouseEnter={(e) => e.currentTarget.style.backgroundColor = 'var(--bg-elev, #F8FAFC)'}
                                            onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                                        >
                                            <span style={{ fontSize: '1rem', width: '28px', textAlign: 'center' }}>{r.icon}</span>
                                            <span style={{ fontSize: '0.85rem', fontWeight: 500 }}>{r.label}</span>
                                            <ArrowRight size={14} color="#94A3B8" style={{ marginLeft: 'auto' }} />
                                        </button>
                                    ))}
                                </>
                            )}

                            {/* Quick Actions */}
                            <div style={{ padding: '8px 24px 4px', fontSize: '0.65rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.08em', color: 'var(--text-muted, #94A3B8)', display: 'flex', alignItems: 'center', gap: '6px' }}>
                                <Zap size={12} /> Quick Actions
                            </div>
                            {QUICK_ACTIONS.map((action) => (
                                <button key={action.id} data-cy={`btn-${action.id}`}
                                    onClick={() => handleSelect(action.label, action.route, action.icon)}
                                    style={{
                                        width: '100%', display: 'flex', alignItems: 'center', gap: '12px',
                                        padding: '10px 24px', border: 'none', textAlign: 'left',
                                        cursor: 'pointer', transition: 'background 0.1s',
                                        background: 'transparent', color: 'var(--text, #0F172A)',
                                    }}
                                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = 'var(--bg-elev, #F8FAFC)'}
                                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                                >
                                    <span style={{ fontSize: '1rem', width: '28px', textAlign: 'center' }}>{action.icon}</span>
                                    <span style={{ fontSize: '0.85rem', fontWeight: 600 }}>{action.label}</span>
                                    {action.shortcut && (
                                        <span style={{ marginLeft: 'auto', fontSize: '0.7rem', fontWeight: 600, backgroundColor: 'var(--border, #E2E8F0)', padding: '2px 8px', borderRadius: '4px', color: '#475569' }}>
                                            {action.shortcut}
                                        </span>
                                    )}
                                </button>
                            ))}
                        </>
                    )}

                    {/* Search results */}
                    {query.trim() && allItems.length === 0 && (
                        <div style={{ padding: '40px 24px', textAlign: 'center', color: 'var(--text-muted, #94A3B8)' }}>
                            <div style={{ fontSize: '2rem', marginBottom: '8px', opacity: 0.4 }}>🔍</div>
                            <div style={{ fontSize: '0.9rem' }}>No results for "<strong>{query}</strong>"</div>
                            <div style={{ fontSize: '0.75rem', marginTop: '4px', opacity: 0.7 }}>Try searching by name, module, or keyword</div>
                        </div>
                    )}

                    {query.trim() && allItems.length > 0 && (
                        <ul style={{ listStyle: 'none', margin: 0, padding: 0 }}>
                            {allItems.map((item, idx) => (
                                <li key={item.id}>
                                    <button data-cy="btn-shared.command-palette-1"
                                        onClick={() => handleSelect(item.label, item.route, item.icon)}
                                        style={{
                                            width: '100%', display: 'flex', alignItems: 'center', gap: '16px',
                                            padding: '12px 24px',
                                            backgroundColor: idx === selectedIndex ? 'var(--brand-50, #EFF6FF)' : 'transparent',
                                            border: idx === selectedIndex ? '1px solid var(--brand-200, #BFDBFE)' : '1px solid transparent',
                                            borderRadius: idx === selectedIndex ? '8px' : '0',
                                            textAlign: 'left', cursor: 'pointer', transition: 'all 0.1s',
                                            margin: idx === selectedIndex ? '0 8px' : '0',
                                        }}
                                        onMouseEnter={(e) => { e.currentTarget.style.backgroundColor = 'var(--bg-elev, #F8FAFC)'; setSelectedIndex(idx); }}
                                        onMouseLeave={(e) => { if (idx !== selectedIndex) e.currentTarget.style.backgroundColor = 'transparent'; }}
                                    >
                                        <div style={{
                                            width: '36px', height: '36px', borderRadius: '8px',
                                            display: 'flex', alignItems: 'center', justifyContent: 'center',
                                            fontSize: '1.1rem',
                                            backgroundColor: item.type === 'patient' ? '#FEF2F2' : item.type === 'staff' ? '#EFF6FF' : item.type === 'action' ? '#FFFBEB' : '#F0FDF4',
                                        }}>
                                            {typeof item.icon === 'string' && item.icon.length <= 2 ? item.icon : (
                                                <>
                                                    {item.type === 'patient' && <User size={18} />}
                                                    {item.type === 'staff' && <Briefcase size={18} />}
                                                    {item.type === 'module' && <ClipboardList size={18} />}
                                                </>
                                            )}
                                        </div>
                                        <div style={{ flex: 1 }}>
                                            <div style={{ fontWeight: 700, color: 'var(--text, #0F172A)', fontSize: '0.9rem' }}>{item.label}</div>
                                            <div style={{ color: 'var(--text-muted, #64748B)', fontSize: '0.78rem' }}>{item.subtitle}</div>
                                        </div>
                                        {idx === selectedIndex && <ArrowRight size={16} color="var(--brand-500, #2563EB)" />}
                                    </button>
                                </li>
                            ))}
                        </ul>
                    )}
                </div>

                {/* Footer */}
                <div style={{ padding: '10px 24px', backgroundColor: 'var(--bg-elev, #F8FAFC)', borderTop: '1px solid var(--border, #E2E8F0)', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <span style={{ fontSize: '0.75rem', color: 'var(--text-muted, #94A3B8)', fontWeight: 600 }}>PrimeCare Command Center</span>
                    <span style={{ fontSize: '0.75rem', color: 'var(--text-muted, #94A3B8)', display: 'flex', gap: '6px', alignItems: 'center' }}>
                        <span style={{ backgroundColor: 'var(--border, #E2E8F0)', padding: '2px 6px', borderRadius: '4px', color: '#475569', fontSize: '0.7rem' }}>↑↓</span> navigate
                        <span style={{ backgroundColor: 'var(--border, #E2E8F0)', padding: '2px 6px', borderRadius: '4px', color: '#475569', fontSize: '0.7rem' }}>↵</span> select
                        <span style={{ backgroundColor: 'var(--border, #E2E8F0)', padding: '2px 6px', borderRadius: '4px', color: '#475569', fontSize: '0.7rem' }}>esc</span> close
                    </span>
                </div>
            </div>

            <div style={{ position: 'absolute', inset: 0, zIndex: -1 }} onClick={() => setIsOpen(false)} />
        </div>
    );
};
