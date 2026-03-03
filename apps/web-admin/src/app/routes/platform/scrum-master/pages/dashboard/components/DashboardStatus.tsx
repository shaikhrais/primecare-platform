import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

interface DashboardStatusProps {
    onDrillEndpoints: () => void;
    onDrillPages: () => void;
    onDrillFlows: () => void;
}

export const DashboardStatus: React.FC<DashboardStatusProps> = ({
    onDrillEndpoints,
    onDrillPages,
    onDrillFlows
}) => {
    const { t } = useTranslation();

    // Dynamically calculate endpoint count
    const calculateApiCount = () => {
        let count = 0;
        const process = (obj: any) => {
            Object.values(obj).forEach(val => {
                if (typeof val === 'string' && val.startsWith('/v1')) count++;
                else if (typeof val === 'object' && val !== null) process(val);
            });
        };
        process(ApiRegistry);
        return count;
    };

    const apiCount = calculateApiCount();

    const cardStyle: React.CSSProperties = {
        transition: 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
        cursor: 'pointer',
        padding: '1.5rem',
        borderRadius: '24px',
        background: 'rgba(255, 255, 255, 0.03)',
        border: '1px solid rgba(255, 255, 255, 0.1)'
    };

    const handleMouseEnter = (e: React.MouseEvent<HTMLDivElement>) => {
        e.currentTarget.style.transform = 'scale(1.05)';
        e.currentTarget.style.background = 'rgba(255, 255, 255, 0.05)';
        e.currentTarget.style.borderColor = 'rgba(255, 255, 255, 0.2)';
    };

    const handleMouseLeave = (e: React.MouseEvent<HTMLDivElement>) => {
        e.currentTarget.style.transform = 'scale(1)';
        e.currentTarget.style.background = 'rgba(255, 255, 255, 0.03)';
        e.currentTarget.style.borderColor = 'rgba(255, 255, 255, 0.1)';
    };

    return (
        <div style={{ background: 'linear-gradient(135deg, #0f172a 0%, #1e293b 100%)', borderRadius: '32px', padding: '3rem', position: 'relative', overflow: 'hidden', color: 'white' }}>
            <div style={{ position: 'absolute', top: '-50px', right: '-50px', width: '200px', height: '200px', background: 'var(--brand-500)', opacity: 0.1, filter: 'blur(60px)', borderRadius: '50%' }}></div>
            <div style={{ position: 'absolute', bottom: '-50px', left: '-50px', width: '200px', height: '200px', background: '#ec4899', opacity: 0.1, filter: 'blur(60px)', borderRadius: '50%' }}></div>

            <h2 style={{ margin: '0 0 2rem 0', display: 'flex', alignItems: 'center', gap: '15px', fontSize: '2rem', fontWeight: 800 }}>
                <span>🚀</span> {t(ContentRegistry.SCRUM_MASTER.DASHBOARD.TITLE)} {t(ContentRegistry.SHARED.STATUS)}
            </h2>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))', gap: '2rem' }}>
                <div
                    style={cardStyle}
                    onMouseEnter={handleMouseEnter}
                    onMouseLeave={handleMouseLeave}
                    onClick={onDrillEndpoints}
                >
                    <div style={{ fontSize: '0.8rem', opacity: 0.6, textTransform: 'uppercase', fontWeight: 800, letterSpacing: '1px' }}>{t(ContentRegistry.SCRUM_MASTER.API_ENDPOINTS.TITLE)}</div>
                    <div style={{ fontSize: '3rem', fontWeight: 900, margin: '8px 0', background: 'linear-gradient(135deg, #fff, #94a3b8)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>{apiCount}</div>
                    <div style={{ display: 'inline-flex', alignItems: 'center', gap: '8px', padding: '4px 10px', background: 'rgba(16, 185, 129, 0.15)', color: '#34d399', borderRadius: '30px', fontSize: '0.75rem', fontWeight: 700 }}>
                        <div style={{ width: '6px', height: '6px', borderRadius: '50%', backgroundColor: '#10b981', boxShadow: '0 0 8px #10b981' }}></div>
                        100% {t(ContentRegistry.SHARED.STATUS)}
                    </div>
                </div>

                <div
                    style={cardStyle}
                    onMouseEnter={handleMouseEnter}
                    onMouseLeave={handleMouseLeave}
                    onClick={onDrillPages}
                >
                    <div style={{ fontSize: '0.8rem', opacity: 0.6, textTransform: 'uppercase', fontWeight: 800, letterSpacing: '1px' }}>{t(ContentRegistry.SCRUM_MASTER.PAGES.TITLE)}</div>
                    <div style={{ fontSize: '3rem', fontWeight: 900, margin: '8px 0', background: 'linear-gradient(135deg, #fff, #94a3b8)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>68</div>
                    <div style={{ display: 'inline-flex', alignItems: 'center', gap: '8px', padding: '4px 10px', background: 'rgba(59, 130, 246, 0.15)', color: '#60a5fa', borderRadius: '30px', fontSize: '0.75rem', fontWeight: 700 }}>
                        <div style={{ width: '6px', height: '6px', borderRadius: '50%', backgroundColor: '#3b82f6', boxShadow: '0 0 8px #3b82f6' }}></div>
                        {t(ContentRegistry.SHARED.STATUS)}
                    </div>
                </div>

                <div
                    style={cardStyle}
                    onMouseEnter={handleMouseEnter}
                    onMouseLeave={handleMouseLeave}
                    onClick={onDrillFlows}
                >
                    <div style={{ fontSize: '0.8rem', opacity: 0.6, textTransform: 'uppercase', fontWeight: 800, letterSpacing: '1px' }}>{t(ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.TITLE)}</div>
                    <div style={{ fontSize: '3rem', fontWeight: 900, margin: '8px 0', background: 'linear-gradient(135deg, #fff, #94a3b8)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>100%</div>
                    <div style={{ display: 'inline-flex', alignItems: 'center', gap: '8px', padding: '4px 10px', background: 'rgba(245, 158, 11, 0.15)', color: '#fbbf24', borderRadius: '30px', fontSize: '0.75rem', fontWeight: 700 }}>
                        <div style={{ width: '6px', height: '6px', borderRadius: '50%', backgroundColor: '#f59e0b', boxShadow: '0 0 8px #f59e0b' }}></div>
                        {t(ContentRegistry.SHARED.STATUS)}
                    </div>
                </div>
            </div>
        </div>
    );
};
