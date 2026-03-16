import React, { useState } from 'react';
import { Terminal, Database } from 'lucide-react';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { useApiMutation } from '@/shared/hooks/useApiMutation';
import { useDialog } from '@/shared/hooks/useDialog';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

export const ScrumMasterCopilot: React.FC = () => {
    const { t } = useTranslation();
    const { showToast } = useNotification();
    const { confirm, DialogRenderer } = useDialog();

    const schemaMutation = useApiMutation<Record<string, never>, any>('/v1/admin/developer/db-push', {
        onSuccess: (data: any) => { showToast(data?.message || 'Schema push triggered successfully.', 'success'); },
        onError: (error: any) => { showToast('Failed to push schema: ' + (error?.message || 'Unknown error'), 'error'); },
    });

    const isPushing = schemaMutation.isPending;

    const handleSchemaPush = async () => {
        if (!(await confirm('Push Schema Changes', "Are you sure you want to push pending Prisma schema changes? Note that full push requires CLI environment."))) return;
        schemaMutation.mutate({} as never);
    };

    const suggestions = [
        { text: t(ContentRegistry.SCRUM_MASTER.COPILOT.SUGGESTION_1), impact: 'High', color: '#10b981' },
        { text: t(ContentRegistry.SCRUM_MASTER.COPILOT.SUGGESTION_2), impact: 'Medium', color: '#f59e0b' },
        { text: t(ContentRegistry.SCRUM_MASTER.COPILOT.SUGGESTION_3), impact: 'Info', color: '#3b82f6' },
    ];

    return (
        <div className="sm-card" style={{
            padding: '2.5rem',
            background: 'linear-gradient(135deg, #4f46e5, #7c3aed)',
            color: 'white',
            marginBottom: '3rem',
            boxShadow: '0 20px 25px -5px rgba(79, 70, 229, 0.2), 0 10px 10px -5px rgba(79, 70, 229, 0.1)'
        }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                <div>
                    <h3 data-cy="h3-scrum-master-copilot-0" style={{ margin: '0 0 5px 0', fontSize: '1.5rem', fontWeight: 800 }}>✨ {t(ContentRegistry.SCRUM_MASTER.COPILOT.TITLE)}</h3>
                    <p style={{ margin: 0, opacity: 0.8, fontSize: '0.9rem' }}>{t(ContentRegistry.SCRUM_MASTER.COPILOT.SUBTITLE)}</p>
                </div>
                <div style={{ display: 'flex', gap: '10px' }}>
                    <button 
                        data-cy="btn-push-schema"
                        onClick={handleSchemaPush} 
                        disabled={isPushing}
                        style={{ 
                            padding: '8px 16px', 
                            background: isPushing ? 'rgba(255,255,255,0.1)' : '#10b981', 
                            border: 'none',
                            color: 'white',
                            cursor: isPushing ? 'not-allowed' : 'pointer',
                            borderRadius: '12px', 
                            fontSize: '0.75rem', 
                            fontWeight: 800 
                        }}>
                        {isPushing ? 'PUSHING...' : '⚡ PUSH SCHEMA'}
                    </button>
                    <div style={{ padding: '8px 16px', background: 'rgba(255,255,255,0.2)', borderRadius: '12px', fontSize: '0.75rem', fontWeight: 800, backdropFilter: 'blur(10px)' }}>AI PREVIEW</div>
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                {suggestions.map((s, i) => (
                    <div key={i} style={{
                        padding: '1.25rem',
                        background: 'rgba(255,255,255,0.1)',
                        borderRadius: '16px',
                        border: '1px solid rgba(255,255,255,0.1)',
                        display: 'flex',
                        justifyContent: 'space-between',
                        alignItems: 'center',
                        transition: '0.2s'
                    }}
                        onMouseEnter={e => e.currentTarget.style.background = 'rgba(255,255,255,0.15)'}
                        onMouseLeave={e => e.currentTarget.style.background = 'rgba(255,255,255,0.1)'}
                    >
                        <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                            <div style={{ width: '8px', height: '8px', borderRadius: '50%', background: s.color, boxShadow: `0 0 10px ${s.color}` }} />
                            <span style={{ fontWeight: 600, fontSize: '0.95rem' }}>{s.text}</span>
                        </div>
                        <span style={{ fontSize: '0.7rem', fontWeight: 800, opacity: 0.7 }}>IMPACT: {s.impact}</span>
                    </div>
                ))}
            </div>
            <DialogRenderer />
            </div>
    );
};
