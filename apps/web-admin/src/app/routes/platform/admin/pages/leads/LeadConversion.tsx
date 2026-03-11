import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';

const { ApiRegistry, RouteRegistry, ButtonRegistry } = AdminRegistry;

export default function LeadConversion() {
    const { id } = useParams<{ id: string }>();
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [loading, setLoading] = useState(false);
    const [leadName, setLeadName] = useState('Loading...');

    useEffect(() => {
 // fetch or actual fetch if needed
        setLeadName('John Doe'); // Placeholder
    }, [id]);

    const handleConvert = async () => {
        setLoading(true);
        try {
            const apiPath = ApiRegistry.ADMIN.LEADS_CONVERT(id!);
 // of API call
            // const response = await apiClient.post(apiPath, {});

            showToast('Lead converted successfully to Client!', 'success');
            navigate(RouteRegistry.ADMIN.CUSTOMERS);
        } catch (error) {
            showToast('Failed to convert lead', 'error');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{ padding: '2rem', maxWidth: '600px', margin: '0 auto' }}>
            <div className="pc-card">
                <div className="pc-card-h">Convert Lead to Client</div>
                <div className="pc-card-b">
                    <p style={{ marginBottom: '1.5rem' }}>
                        You are about to convert <strong>{leadName}</strong> into a full platform client.
                        This will provision a user account and clinical profile.
                    </p>
                    <div style={{ display: 'flex', gap: '1rem' }}>
                        <button
                            className="btn secondary"
                            onClick={() => navigate(-1)}
                            disabled={loading}
                        >
                            Cancel
                        </button>
                        <button
                            className="btn primary"
                            onClick={handleConvert}
                            disabled={loading}
                            style={{ flex: 1 }}
                        >
                            {loading ? 'Converting...' : (ButtonRegistry.find((b: any) => b.id === 'btn-adm-leads-convert')?.label || 'Confirm Conversion')}
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
}
