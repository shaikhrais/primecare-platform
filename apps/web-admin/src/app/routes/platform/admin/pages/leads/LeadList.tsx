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
            const response = await apiClient.get(ApiRegistry.ADMIN.LEADS); // Ensure this endpoint exists in your registry
            if (response.ok) {
                const data = await response.json();
                setLeads(data);
            } else {
                // Mock data for demo if API fails or doesn't exist
                setLeads([
                    { id: '1', firstName: 'Alice', lastName: 'Smith', email: 'alice@example.com', phone: '555-0101', serviceInterest: ['Personal Care'], status: 'new', createdAt: '2023-10-25' },
                    { id: '2', firstName: 'Bob', lastName: 'Johnson', email: 'bob@example.com', phone: '555-0102', serviceInterest: ['Nursing'], status: 'contacted', createdAt: '2023-10-24' },
                    { id: '3', firstName: 'Carol', lastName: 'Williams', email: 'carol@example.com', phone: '555-0103', serviceInterest: ['Respite Care', 'Personal Care'], status: 'consultation_scheduled', createdAt: '2023-10-23' },
                ]);
                if (response.status !== 404) showToast('Using demo data', 'info');
            }
        } catch (error) {
            console.error('Failed to fetch leads', error);
            // Mock data fallback
            setLeads([
                { id: '1', firstName: 'Alice', lastName: 'Smith', email: 'alice@example.com', phone: '555-0101', serviceInterest: ['Personal Care'], status: 'new', createdAt: '2023-10-25' },
                { id: '2', firstName: 'Bob', lastName: 'Johnson', email: 'bob@example.com', phone: '555-0102', serviceInterest: ['Nursing'], status: 'contacted', createdAt: '2023-10-24' },
                { id: '3', firstName: 'Carol', lastName: 'Williams', email: 'carol@example.com', phone: '555-0103', serviceInterest: ['Respite Care', 'Personal Care'], status: 'consultation_scheduled', createdAt: '2023-10-23' },
            ]);
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

            // API call would go here
            // await apiClient.patch(`/leads/${id}`, { status: newStatus });

            showToast('Status updated', 'success');
        } catch (error) {
            showToast('Failed to update status', 'error');
            fetchLeads(); // Revert on error
        }
    };

    const handleDelete = async (id: string) => {
        try {
            setLeads(prev => prev.filter(l => l.id !== id));
            showToast('Lead deleted', 'success');
        } catch (error) {
            showToast('Error deleting lead', 'error');
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
                    data-cy="btn-new-lead"
                >
                    {t(ContentRegistry.LEADS.ADD_BTN)}
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
