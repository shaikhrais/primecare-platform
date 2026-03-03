import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

export default function DatabaseSchemaAudit() {
    const { t } = useTranslation();

    const models = [
        { name: 'User', fields: 'id, email, password, roles, tenantId', relations: 'Tenant, Profile', status: 'In Sync' },
        { name: 'Tenant', fields: 'id, name, domain, settings, createdAt', relations: 'Users, Clients, Staff', status: 'In Sync' },
        { name: 'ClientProfile', fields: 'id, userId, medicalHistory, carePlanId', relations: 'User, CarePlan, Bookings', status: 'In Sync' },
        { name: 'Shift', fields: 'id, pswId, startTime, endTime, status, location', relations: 'PSW, Client, VisitLogs', status: 'Structural Change Pending' },
        { name: 'VisitLog', fields: 'id, shiftId, checkInAt, checkOutAt, gpsData', relations: 'Shift', status: 'In Sync' },
    ];

    return (
        <div data-cy="database-schema-audit-page">
            <div style={{ marginBottom: '2.5rem' }}>
                <h1 style={{ margin: '0 0 8px 0', fontSize: '32px', fontWeight: 800, color: 'var(--text-100)' }}>
                    {t(ContentRegistry.SCRUM_MASTER.DATABASE_SCHEMA.TITLE)}
                </h1>
                <p style={{ margin: 0, color: 'var(--text-300)', fontSize: '1.1rem' }}>
                    {t(ContentRegistry.SCRUM_MASTER.DATABASE_SCHEMA.SUBTITLE)}
                </p>
            </div>

            <div className="pc-card" style={{ padding: 0, overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                    <thead style={{ backgroundColor: '#f8fafc', color: '#64748b', fontSize: '0.85rem' }}>
                        <tr>
                            <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.SCRUM_MASTER.DATABASE_SCHEMA.MODEL_NAME)}</th>
                            <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.SCRUM_MASTER.DATABASE_SCHEMA.CORE_FIELDS)}</th>
                            <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.SCRUM_MASTER.DATABASE_SCHEMA.RELATIONS)}</th>
                            <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.SCRUM_MASTER.DATABASE_SCHEMA.SYNC_STATUS)}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {models.map((model, idx) => (
                            <tr key={idx} style={{ borderBottom: '1px solid var(--border)' }}>
                                <td style={{ padding: '1.2rem 1.5rem', fontWeight: 700, color: 'var(--text-100)' }}>
                                    {model.name}
                                </td>
                                <td style={{ padding: '1.2rem 1.5rem', fontFamily: 'monospace', fontSize: '0.85rem', color: '#475569' }}>
                                    {model.fields}
                                </td>
                                <td style={{ padding: '1.2rem 1.5rem', color: 'var(--brand-600)', fontWeight: 600, fontSize: '0.85rem' }}>
                                    {model.relations}
                                </td>
                                <td style={{ padding: '1.2rem 1.5rem' }}>
                                    <span style={{
                                        backgroundColor: model.status === 'In Sync' ? '#ecfdf5' : '#fff1f2',
                                        color: model.status === 'In Sync' ? '#059669' : '#e11d48',
                                        padding: '4px 10px', borderRadius: '20px', fontSize: '0.75rem', fontWeight: 700
                                    }}>
                                        {model.status}
                                    </span>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>

            <div style={{ marginTop: '2.5rem', padding: '2rem', backgroundColor: '#f1f5f9', borderRadius: '16px', border: '1px solid #e2e8f0' }}>
                <h3 style={{ margin: '0 0 1rem 0', color: '#1e293b' }}>🧠 {t(ContentRegistry.SHARED.ARCHITECTURE_INSIGHT)}</h3>
                <p style={{ margin: 0, color: '#475569', lineHeight: 1.6, fontSize: '0.95rem' }}>
                    {t(ContentRegistry.SCRUM_MASTER.DATABASE_SCHEMA.INSIGHT)}
                </p>
            </div>
        </div>
    );
}
