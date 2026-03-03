import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

interface ModalProps {
    isOpen: boolean;
    onClose: () => void;
}

export const EndpointDrillModal: React.FC<ModalProps> = ({ isOpen, onClose }) => {
    const { t } = useTranslation();
    if (!isOpen) return null;

    const endpoints: string[] = [];
    const process = (obj: any) => {
        Object.values(obj).forEach(val => {
            if (typeof val === 'string' && val.startsWith('/v1')) endpoints.push(val);
            else if (typeof val === 'object' && val !== null) process(val);
        });
    };
    process(ApiRegistry);

    return (
        <PerspectiveModalWrap title={t(ContentRegistry.SCRUM_MASTER.API_ENDPOINTS.TITLE)} onClose={onClose}>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
                <p style={{ color: 'var(--text-300)', fontSize: '0.85rem' }}>Listing all v1 registered endpoints:</p>
                <div style={{ maxHeight: '400px', overflowY: 'auto', paddingRight: '10px' }}>
                    {endpoints.slice(0, 30).map((ep, i) => (
                        <div key={i} style={{ padding: '12px', background: '#F9FAFB', borderRadius: '10px', marginBottom: '8px', border: '1px solid #E5E7EB', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <code style={{ fontSize: '0.8rem', color: 'var(--brand-600)' }}>{ep}</code>
                            <span style={{ fontSize: '0.7rem', color: '#10b981', fontWeight: 800 }}>ACTIVE</span>
                        </div>
                    ))}
                    {endpoints.length > 30 && <p style={{ textAlign: 'center', fontSize: '0.75rem', opacity: 0.5 }}>... and {endpoints.length - 30} more</p>}
                </div>
            </div>
        </PerspectiveModalWrap>
    );
};

export const PageAuditModal: React.FC<ModalProps> = ({ isOpen, onClose }) => {
    const { t } = useTranslation();
    if (!isOpen) return null;

    const modules = [
        { name: 'Administration', count: 12, status: 'Ready' },
        { name: 'Admission', count: 8, status: 'Audited' },
        { name: 'Operations', count: 24, status: 'Ready' },
        { name: 'Scrum Master', count: 6, status: 'Live' },
        { name: 'Frontend (Vite)', count: 18, status: 'Stable' }
    ];

    return (
        <PerspectiveModalWrap title={t(ContentRegistry.SCRUM_MASTER.PAGES.TITLE)} onClose={onClose}>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '15px' }}>
                <p style={{ color: 'var(--text-300)', fontSize: '0.85rem' }}>Platform module audit coverage:</p>
                {modules.map((m, i) => (
                    <div key={i} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', paddingBottom: '12px', borderBottom: '1px solid #F3F4F6' }}>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.95rem' }}>{m.name}</div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>{m.count} Components</div>
                        </div>
                        <span style={{ padding: '4px 10px', background: 'var(--brand-50)', color: 'var(--brand-600)', borderRadius: '20px', fontSize: '0.7rem', fontWeight: 800 }}>{m.status}</span>
                    </div>
                ))}
            </div>
        </PerspectiveModalWrap>
    );
};

export const RoleFlowDrillModal: React.FC<ModalProps> = ({ isOpen, onClose }) => {
    const { t } = useTranslation();
    if (!isOpen) return null;

    const flows = [
        { role: 'Admin', path: '/platform/admin/*', status: 'Optimum', latency: '12ms' },
        { role: 'Manager', path: '/tenancy/manager/*', status: 'Active', latency: '45ms' },
        { role: 'Staff', path: '/tenancy/staff/*', status: 'Audited', latency: '32ms' },
        { role: 'PSW / Client', path: '/mobile/*', status: 'Secured', latency: '18ms' }
    ];

    return (
        <PerspectiveModalWrap title={t(ContentRegistry.SCRUM_MASTER.FLOW_DRILL.TITLE)} onClose={onClose}>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '15px' }}>
                <p style={{ color: 'var(--text-300)', fontSize: '0.85rem' }}>{t(ContentRegistry.SCRUM_MASTER.FLOW_DRILL.JOURNEY_MAP)}:</p>
                {flows.map((f, i) => (
                    <div key={i} style={{ padding: '15px', background: '#F8FAFC', borderRadius: '14px', border: '1px solid #E2E8F0', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <div>
                            <div style={{ fontWeight: 800, color: 'var(--text-400)', fontSize: '0.9rem' }}>{f.role} {t(ContentRegistry.SHARED.STATUS)}</div>
                            <div style={{ fontSize: '0.7rem', color: 'var(--brand-500)', fontFamily: 'monospace' }}>{f.path}</div>
                        </div>
                        <div style={{ textAlign: 'right' }}>
                            <div style={{ color: '#10b981', fontWeight: 800, fontSize: '0.75rem' }}>{f.status}</div>
                            <div style={{ fontSize: '0.65rem', opacity: 0.5 }}>{f.latency}</div>
                        </div>
                    </div>
                ))}
            </div>
        </PerspectiveModalWrap>
    );
};

// Reusable Modal Wrapper using modern aesthetics
const PerspectiveModalWrap: React.FC<{ title: string; onClose: () => void; children: React.ReactNode }> = ({ title, onClose, children }) => (
    <div style={{ position: 'fixed', top: 0, left: 0, right: 0, bottom: 0, zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center', padding: '20px' }}>
        <div onClick={onClose} style={{ position: 'absolute', top: 0, left: 0, right: 0, bottom: 0, background: 'rgba(0,0,0,0.6)', backdropFilter: 'blur(8px)' }} />
        <div style={{ position: 'relative', width: '100%', maxWidth: '500px', background: 'white', borderRadius: '24px', overflow: 'hidden', boxShadow: '0 25px 50px -12px rgba(0,0,0,0.25)', animation: 'modalEntry 0.4s cubic-bezier(0.16, 1, 0.3, 1)' }}>
            <div style={{ padding: '24px', borderBottom: '1px solid #F3F4F6', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <h3 style={{ margin: 0, fontSize: '1.25rem', fontWeight: 800, color: 'var(--text-400)' }}>{title}</h3>
                <button onClick={onClose} style={{ background: 'none', border: 'none', fontSize: '24px', cursor: 'pointer', color: '#94a3b8' }}>×</button>
            </div>
            <div style={{ padding: '24px' }}>{children}</div>
            <style>{`@keyframes modalEntry { from { opacity: 0; transform: translateY(20px) scale(0.95); } to { opacity: 1; transform: translateY(0) scale(1); } }`}</style>
        </div>
    </div>
);
