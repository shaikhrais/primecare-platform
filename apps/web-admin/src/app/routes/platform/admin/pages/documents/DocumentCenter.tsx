import React, { useState, useEffect } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { useTranslation } from 'react-i18next';

export default function DocumentCenter() {
    const { showToast } = useNotification();
    const { t } = useTranslation();
    const [documents, setDocuments] = useState<any[]>([]);

    useEffect(() => {
        setDocuments([
            { id: '1', pswName: 'Jane Smith', docType: 'VSS (Vulnerable Sector Screen)', status: 'pending_review', uploadedAt: '2026-03-08', expiresAt: '2027-03-08' },
            { id: '2', pswName: 'Maria Garcia', docType: 'CPR Certification', status: 'approved', uploadedAt: '2026-02-15', expiresAt: '2027-02-15' },
            { id: '3', pswName: 'James Wilson', docType: 'Clinical License', status: 'rejected', uploadedAt: '2026-03-01', expiresAt: null },
            { id: '4', pswName: 'Sarah Johnson', docType: 'COVID-19 Vaccination Record', status: 'approved', uploadedAt: '2026-01-10', expiresAt: null },
            { id: '5', pswName: 'Robert Chen', docType: 'First Aid Certificate', status: 'pending_review', uploadedAt: '2026-03-07', expiresAt: '2027-03-07' },
        ]);
    }, []);

    const statusBadge = (s: string) => {
        const map: Record<string, { color: string; label: string }> = {
            pending_review: { color: '#F59E0B', label: `⏳ ${t('admin.pending_review', { defaultValue: 'Pending Review' })}` },
            approved: { color: '#10B981', label: `✅ ${t('admin.approved', { defaultValue: 'Approved' })}` },
            rejected: { color: '#EF4444', label: `❌ ${t('admin.rejected', { defaultValue: 'Rejected' })}` },
        };
        const { color, label } = map[s] || { color: '#6B7280', label: s };
        return <span style={{ color, fontWeight: '600', fontSize: '13px' }}>{label}</span>;
    };

    return (
        <div style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }} data-cy="page.container">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: 'var(--brand-50)', padding: '16px', borderRadius: '12px', fontSize: '32px', border: '1px solid var(--brand-100)' }}>📁</div>
                    <div>
                        <h1 style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: 'var(--text-100)' }} data-cy="page.title">
                            {t('admin.document_center_title', { defaultValue: 'Document Management Center' })}
                        </h1>
                        <p style={{ color: 'var(--text-300)', margin: '4px 0 0 0' }}>
                            {t('admin.document_center_subtitle', { defaultValue: 'Upload, verify, and manage PSW credentials, certifications, and compliance documents. Generates presigned upload/download URLs.' })}
                        </p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '20px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.total_documents', { defaultValue: 'Total Documents' })}</div><div style={{ fontSize: '28px', fontWeight: '800', color: 'var(--text-100)', marginTop: '4px' }}>{documents.length}</div></div>
                <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.pending_review', { defaultValue: 'Pending Review' })}</div><div style={{ fontSize: '28px', fontWeight: '800', color: '#F59E0B', marginTop: '4px' }}>{documents.filter(d => d.status === 'pending_review').length}</div></div>
                <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.rejected', { defaultValue: 'Rejected' })}</div><div style={{ fontSize: '28px', fontWeight: '800', color: '#EF4444', marginTop: '4px' }}>{documents.filter(d => d.status === 'rejected').length}</div></div>
            </div>

            <div className="pc-card" style={{ padding: '0', overflow: 'hidden' }}>
                <div className="pc-card-h">{t('admin.document_registry', { defaultValue: 'Document Registry' })}</div>
                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead style={{ backgroundColor: 'var(--bg-200)', borderBottom: '1px solid var(--border)' }}>
                        <tr>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.provider', { defaultValue: 'Provider' })}</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.document_type', { defaultValue: 'Document Type' })}</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.status', { defaultValue: 'Status' })}</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.uploaded', { defaultValue: 'Uploaded' })}</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.actions', { defaultValue: 'Actions' })}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {documents.map(d => (
                            <tr key={d.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '600', color: 'var(--text-100)' }}>{d.pswName}</td>
                                <td style={{ padding: '16px 24px', fontSize: '14px', color: 'var(--text-300)' }}>{d.docType}</td>
                                <td style={{ padding: '16px 24px' }}>{statusBadge(d.status)}</td>
                                <td style={{ padding: '16px 24px', fontSize: '13px', color: 'var(--text-300)' }}>{d.uploadedAt}</td>
                                <td style={{ padding: '16px 24px', display: 'flex', gap: '6px' }}>
                                    <button className="btn secondary" data-cy={`btn-download-${d.id}`} style={{ fontSize: '11px', padding: '4px 8px' }} onClick={() => showToast(t('admin.generating_download', { defaultValue: `Generating download link for ${d.docType}...`, docType: d.docType }), 'info')}>📥 {t('admin.download', { defaultValue: 'Download' })}</button>
                                    {d.status === 'pending_review' && <><button className="btn primary" data-cy={`btn-approve-${d.id}`} style={{ fontSize: '11px', padding: '4px 8px' }} onClick={() => showToast(t('admin.document_approved', { defaultValue: `${d.docType} approved for ${d.pswName}`, docType: d.docType, pswName: d.pswName }), 'success')}>✅ {t('admin.approve', { defaultValue: 'Approve' })}</button><button className="btn secondary" data-cy={`btn-reject-${d.id}`} style={{ fontSize: '11px', padding: '4px 8px', color: '#EF4444' }} onClick={() => showToast(t('admin.document_rejected', { defaultValue: `${d.docType} rejected for ${d.pswName}`, docType: d.docType, pswName: d.pswName }), 'warning')}>❌ {t('admin.reject', { defaultValue: 'Reject' })}</button></>}
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
