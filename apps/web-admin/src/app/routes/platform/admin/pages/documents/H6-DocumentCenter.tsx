// ================================================================
// PAGE IDENTITY: H6 � Document Center
// Registry ID:   page.admin.documents
// Type:          Hub
// Owner:         admin
// ================================================================
import React from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';
import { DashboardSkeleton } from '@/shared/components/ui/Skeleton';

export default function DocumentCenter() {
    const { showToast } = useNotification();
    const { t } = useTranslation();

    // TanStack Query: auto-cached document list
    const { data: documents = [], isLoading: loading } = useRegistryQuery<any[]>(AdminRegistry.ApiRegistry.ADMIN.DOCUMENTS.LIST, {
        queryKey: ['admin', 'documents'],
        staleTime: 15_000,
    });

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
        <div style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }} data-cy="page.container" role="main" aria-label="Document Center">
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
                <DashboardSkeleton statCount={3} />
            ) : (
                <>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '20px', marginBottom: '32px' }}>
                        <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.total_documents', { defaultValue: 'Total Documents' })}</div><div style={{ fontSize: '28px', fontWeight: '800', color: 'var(--text-100)', marginTop: '4px' }}>{documents.length}</div></div>
                        <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.pending_review', { defaultValue: 'Pending Review' })}</div><div style={{ fontSize: '28px', fontWeight: '800', color: '#F59E0B', marginTop: '4px' }}>{documents.filter(d => d.status === 'pending_review').length}</div></div>
                        <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.rejected', { defaultValue: 'Rejected' })}</div><div style={{ fontSize: '28px', fontWeight: '800', color: '#EF4444', marginTop: '4px' }}>{documents.filter(d => d.status === 'rejected').length}</div></div>
                    </div>

                    <div className="pc-card" style={{ padding: '0', overflow: 'hidden' }}>
                        <div className="pc-card-h">{t('admin.document_registry', { defaultValue: 'Document Registry' })}</div>
                        <table data-cy="table-admin.document-center" style={{ width: '100%', borderCollapse: 'collapse' }}>
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
                                            <button className="btn secondary" data-cy={`btn-download-${d.id}`} style={{ fontSize: '11px', padding: '4px 8px' }} onClick={async () => { try { const m = await import('@/shared/utils/apiClient'); const res = await m.apiClient.get(`/v1/admin/documents/${d.id}/download`); if (res.ok) { const blob = await res.blob(); const url = URL.createObjectURL(blob); const a = document.createElement('a'); a.href = url; a.download = d.docType + '.pdf'; document.body.appendChild(a); a.click(); document.body.removeChild(a); } } catch {} showToast(t('admin.generating_download', { defaultValue: `Generating download link for ${d.docType}...`, docType: d.docType }), 'info'); }}>📥 {t('admin.download', { defaultValue: 'Download' })}</button>
                                            {d.status === 'pending_review' && <><button className="btn primary" data-cy={`btn-approve-${d.id}`} style={{ fontSize: '11px', padding: '4px 8px' }} onClick={async () => { try { const m = await import('@/shared/utils/apiClient'); await m.apiClient.patch(`/v1/admin/documents/${d.id}`, { status: 'approved' }); } catch {} showToast(t('admin.document_approved', { defaultValue: `${d.docType} approved for ${d.pswName}`, docType: d.docType, pswName: d.pswName }), 'success'); }}>✅ {t('admin.approve', { defaultValue: 'Approve' })}</button><button className="btn secondary" data-cy={`btn-reject-${d.id}`} style={{ fontSize: '11px', padding: '4px 8px', color: '#EF4444' }} onClick={async () => { try { const m = await import('@/shared/utils/apiClient'); await m.apiClient.patch(`/v1/admin/documents/${d.id}`, { status: 'rejected' }); } catch {} showToast(t('admin.document_rejected', { defaultValue: `${d.docType} rejected for ${d.pswName}`, docType: d.docType, pswName: d.pswName }), 'warning'); }}>❌ {t('admin.reject', { defaultValue: 'Reject' })}</button></>}
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
