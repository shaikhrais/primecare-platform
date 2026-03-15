// ================================================================
// PAGE IDENTITY: H19 � Wizard Hub
// Type: Hub | Owner: admin
// ================================================================
import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function WizardHub() {
    const { t } = useTranslation();
    const navigate = useNavigate();

    const wizards = [
        {
            title: t(ContentRegistry.WIZARD_HUB.STRATEGY.TITLE),
            desc: t(ContentRegistry.WIZARD_HUB.STRATEGY.DESC),
            action: t(ContentRegistry.WIZARD_HUB.STRATEGY.ACTION),
            route: RouteRegistry.ADMIN.BUSINESS_MODEL_WIZARD,
            icon: '🚀',
            color: '#4f46e5'
        },
        {
            title: t(ContentRegistry.WIZARD_HUB.STAFF.TITLE),
            desc: t(ContentRegistry.WIZARD_HUB.STAFF.DESC),
            action: t(ContentRegistry.WIZARD_HUB.STAFF.ACTION),
            route: RouteRegistry.ADMIN.STAFF_ONBOARDING,
            icon: '🛡️',
            color: '#004d40'
        },
        {
            title: t(ContentRegistry.WIZARD_HUB.CLIENT.TITLE),
            desc: t(ContentRegistry.WIZARD_HUB.CLIENT.DESC),
            action: t(ContentRegistry.WIZARD_HUB.CLIENT.ACTION),
            route: RouteRegistry.ADMIN.CARE_PLAN_WIZARD,
            icon: '📋',
            color: '#0284c7'
        },
        {
            title: t(ContentRegistry.WIZARD_HUB.FINANCE.TITLE),
            desc: t(ContentRegistry.WIZARD_HUB.FINANCE.DESC),
            action: t(ContentRegistry.WIZARD_HUB.FINANCE.ACTION),
            route: RouteRegistry.ADMIN.REVENUE_WIZARD,
            icon: '💰',
            color: '#059669'
        }
    ];

    return (
        <div data-cy="page.container" role="main" aria-label="Wizard Hub" style={{ maxWidth: '1000px', margin: '2rem auto', padding: '0 1rem' }}>
            <div style={{ marginBottom: '3rem', textAlign: 'center' }}>
                <h1 data-cy="page.title" style={{ fontSize: '2.5rem', fontWeight: '800', color: '#111827', marginBottom: '0.5rem' }}>
                    {t(ContentRegistry.WIZARD_HUB.TITLE)}
                </h1>
                <p style={{ fontSize: '1.125rem', color: '#6b7280' }}>
                    {t(ContentRegistry.WIZARD_HUB.SUBTITLE)}
                </p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '2rem' }}>
                {wizards.map((w, idx) => (
                    <div key={idx} style={{
                        background: 'white',
                        borderRadius: '1.5rem',
                        padding: '2.5rem',
                        border: '1px solid #e5e7eb',
                        boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)',
                        display: 'flex',
                        flexDirection: 'column',
                        alignItems: 'center',
                        textAlign: 'center',
                        transition: 'transform 0.2s, box-shadow 0.2s',
                    }}
                        onMouseOver={e => {
                            e.currentTarget.style.transform = 'translateY(-4px)';
                            e.currentTarget.style.boxShadow = '0 10px 15px -3px rgba(0, 0, 0, 0.1)';
                        }}
                        onMouseOut={e => {
                            e.currentTarget.style.transform = 'translateY(0)';
                            e.currentTarget.style.boxShadow = '0 4px 6px -1px rgba(0, 0, 0, 0.05)';
                        }}
                    >
                        <div style={{
                            fontSize: '3rem',
                            marginBottom: '1.5rem',
                            width: '80px',
                            height: '80px',
                            background: `${w.color}10`,
                            borderRadius: '1rem',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center'
                        }}>
                            {w.icon}
                        </div>
                        <h2 data-cy="h2-admin.wizard-hub-0" style={{ fontSize: '1.5rem', fontWeight: '800', marginBottom: '0.75rem', color: '#111827' }}>{w.title}</h2>
                        <p style={{ color: '#6b7280', marginBottom: '2rem', flex: 1 }}>{w.desc}</p>
                        <button data-cy="btn-admin.wizard-hub-0"
                            onClick={() => navigate(w.route)}
                            style={{
                                width: '100%',
                                padding: '0.875rem',
                                background: w.color,
                                color: 'white',
                                fontWeight: 'bold',
                                borderRadius: '1rem',
                                border: 'none',
                                cursor: 'pointer',
                                transition: 'opacity 0.2s'
                            }}
                            onMouseOver={e => e.currentTarget.style.opacity = '0.9'}
                            onMouseOut={e => e.currentTarget.style.opacity = '1'}
                        >
                            {w.action}
                        </button>
                    </div>
                ))}
            </div>
        </div>
    );
}
