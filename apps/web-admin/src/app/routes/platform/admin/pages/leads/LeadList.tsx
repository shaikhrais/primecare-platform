import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';

// Components
import { LeadsTable } from './components/LeadsTable';
import { useTranslation } from 'react-i18next';

const { ApiRegistry, ContentRegistry, RouteRegistry } = AdminRegistry;

interface Lead {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
    phone: string;
    serviceInterest: string[];
    status: 'new' | 'contacted' | 'consultation_scheduled' | 'converted' | 'lost';
    createdAt: string;
    notes?: string;
}

export default function LeadsPage() {
    const { t } = useTranslation();
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [leads, setLeads] = useState<Lead[]>([]);
    const [loading, setLoading] = useState(true);
    const [searchTerm, setSearchTerm] = useState('');

    const fetchLeads = async () => {
        setLoading(true);
        try {
            const response = await apiClient.get(ApiRegistry.ADMIN.LEADS);
            if (response.ok) {
                const data = await response.json();
                setLeads(data);
            } else {
                setLeads([]);
            }
        } catch (error) {
            console.error('Failed to fetch leads', error);
            setLeads([]);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchLeads();
    }, []);

    const handleStatusChange = async (id: string, newStatus: Lead['status']) => {
        try {
            // Optimistic update
            setLeads(prev => prev.map(l => l.id === id ? { ...l, status: newStatus } : l));

            // API call logic would be here
            // await apiClient.patch(`${ApiRegistry.ADMIN.LEADS}/${id}`, { status: newStatus });

            showToast(t(ContentRegistry.LEADS.MESSAGES.SUCCESS_UPDATE), 'success');
        } catch (error) {
            showToast(t(ContentRegistry.LEADS.MESSAGES.ERROR_UPDATE), 'error');
            fetchLeads(); // Revert on error
        }
    };

    const handleDelete = async (id: string) => {
        if (!confirm(t(ContentRegistry.MODALS.CONFIRM_DELETE.TITLE))) return;
        try {
            setLeads(prev => prev.filter(l => l.id !== id));
            showToast(t(ContentRegistry.LEADS.MESSAGES.SUCCESS_DELETE), 'success');
        } catch (error) {
            showToast(t(ContentRegistry.LEADS.MESSAGES.ERROR_DELETE), 'error');
        }
    };

    return (
        <div style={{ padding: '2rem' }} data-cy="page.container">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h2 style={{ fontSize: '1.75rem', fontWeight: 'bold', margin: 0 }}>{t(ContentRegistry.LEADS.TITLE)}</h2>
                    <p style={{ color: '#6b7280', marginTop: '0.25rem' }}>{t(ContentRegistry.LEADS.SUBTITLE)}</p>
                </div>
                <button
                    onClick={() => navigate(RouteRegistry.ADMIN.LEADS_NEW)}
                    style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}
                    data-cy="btn-adm-leads-new"
                >
                    {AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-adm-admission-new')?.label || t(ContentRegistry.LEADS.ADD_BTN)}
                </button>
            </div>

            <div style={{ marginBottom: '1.5rem', maxWidth: '400px' }}>
                <input
                    type="text"
                    placeholder={t(ContentRegistry.LEADS.SEARCH_PLACEHOLDER)}
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                    data-cy="inp-search"
                />
            </div>

            <LeadsTable
                leads={leads}
                loading={loading}
                searchTerm={searchTerm}
                onStatusChange={handleStatusChange}
                onDelete={handleDelete}
            />
        </div>
    );
}
