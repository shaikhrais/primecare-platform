// ================================================================
// PAGE IDENTITY: H6 � Document Center
// Registry ID:   page.admin.documents
// Type:          Hub
// Owner:         admin
// ================================================================
import React, { useState, useEffect } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';

export default function DocumentCenter() {
    const { showToast } = useNotification();
    const { t } = useTranslation();
    const [documents, setDocuments] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchDocuments();
    }, []);

    const fetchDocuments = async () => {
        setLoading(true);
        try {
            const response = await apiClient.get(AdminRegistry.ApiRegistry.ADMIN.DOCUMENTS.LIST);
            if (response.ok) {
                const data = await response.json();
                setDocuments(data);
            }
        } catch (error) {
            console.error('Failed to fetch documents', error);
        } finally {
            setLoading(false);
        }
    };

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

            {loading ? (
                <div style={{ padding: '64px 0', textAlign: 'center', color: 'var(--text-300)' }}>
                    <div style={{ display: 'inline-block', width: '32px', height: '32px', border: '3px solid var(--brand-100)', borderTopColor: 'var(--brand-500)', borderRadius: '50%', animation: 'spin 1s linear infinite', marginBottom: '16px' }}></div>
                    <style>{`@keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }`}</style>
                    <div>{t('admin.loading_data', { defaultValue: 'Loading secure data...' })}</div>
                </div>
            ) : (
                <>
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
                </>
            )}
        </div>
    );
}
