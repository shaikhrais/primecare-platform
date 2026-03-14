// ================================================================
// PAGE IDENTITY: T66 � Lead Conversion
// Type: Tool | Owner: admin
// ================================================================
import React, { useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';

const { ApiRegistry, RouteRegistry, ButtonRegistry } = AdminRegistry;

export default function LeadConversion() {
    const { id } = useParams<{ id: string }>();
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [loading, setLoading] = useState(false);

    // TanStack Query: cached leads list, derive name from query data
    const { data: leads = [] } = useRegistryQuery<any[]>(ApiRegistry.ADMIN.LEADS, {
        queryKey: ['admin', 'leads'],
        staleTime: 60_000,
    });
    const lead = leads.find((l: any) => l.id === id);
    const leadName = lead ? `${lead.firstName} ${lead.lastName}` : 'Loading...';

    const handleConvert = async () => {
        setLoading(true);
        try {
            const apiPath = ApiRegistry.ADMIN.LEADS_CONVERT(id!);
            const response = await apiClient.post(apiPath, {});
            
            if (!response.ok) {
                const errData = await response.json();
                throw new Error(errData.error || 'Conversion Failed');
            }

            showToast('Lead converted successfully to Client!', 'success');
            navigate(RouteRegistry.ADMIN.CUSTOMERS);
        } catch (error) {
            showToast('Failed to convert lead', 'error');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div data-cy="page.container" style={{ padding: '2rem', maxWidth: '600px', margin: '0 auto' }}>
            <div className="pc-card">
                <div className="pc-card-h">Convert Lead to Client</div>
                <div className="pc-card-b">
                    <p style={{ marginBottom: '1.5rem' }}>
                        You are about to convert <strong>{leadName}</strong> into a full platform client.
                        This will provision a user account and clinical profile.
                    </p>
                    <div style={{ display: 'flex', gap: '1rem' }}>
                        <button data-cy="btn-admin.lead-conversion-0"
                            className="btn secondary"
                            onClick={() => navigate(-1)}
                            disabled={loading}
                        >
                            Cancel
                        </button>
                        <button data-cy="btn-admin.lead-conversion-1"
                            className="btn primary"
                            onClick={handleConvert}
                            disabled={loading}
                            style={{ flex: 1 }}
                        >
                            {loading ? 'Converting...' : (getButtonById('btn-adm-leads-convert')?.label || 'Confirm Conversion')}
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
}
