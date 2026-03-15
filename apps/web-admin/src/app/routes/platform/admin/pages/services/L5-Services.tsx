// ================================================================
// PAGE IDENTITY: L5 � Service Catalog
// Registry ID:   page.admin.services
// Type:          List
// Owner:         admin
// ================================================================
import React, { useState, useEffect } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

// Components
import { ServicesTable } from './components/ServicesTable';
import { ServiceFormModal } from './components/ServiceFormModal';
import { useDialog } from '@/shared/hooks/useDialog';

const { ContentRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

interface Service {
    id: string;
    name: string;
    description: string;
    hourlyRate: number;
    category: string;
}

export default function ServicesPage() {
    const { confirm, DialogRenderer } = useDialog();
    const { t } = useTranslation();
    const { showToast } = useNotification();
    const [services, setServices] = useState<Service[]>([]);
    const [loading, setLoading] = useState(true);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [currentService, setCurrentService] = useState<Partial<Service>>({});

    const fetchServices = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}/v1/admin/services`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setServices(data);
            }
        } catch (error) {
            console.error('Failed to fetch services');
            showToast(t(ContentRegistry.SERVICES.MESSAGES.ERROR_LOAD), 'error');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchServices();
    }, []);

    const handleSave = async (updatedService: Partial<Service>) => {
        try {
            const token = localStorage.getItem('token');
            const method = updatedService.id ? 'PUT' : 'POST';
            const url = updatedService.id
                ? `${API_URL}/v1/admin/services/${updatedService.id}`
                : `${API_URL}/v1/admin/services`;

            const response = await fetch(url, {
                method,
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(updatedService)
            });

            if (response.ok) {
                showToast(updatedService.id ? t(ContentRegistry.SERVICES.MESSAGES.SUCCESS_UPDATE) : t(ContentRegistry.SERVICES.MESSAGES.SUCCESS_CREATE), 'success');
                setIsModalOpen(false);
                fetchServices();
            } else {
                showToast(t(ContentRegistry.SERVICES.MESSAGES.ERROR_SAVE), 'error');
            }
        } catch (error) {
            showToast(t(ContentRegistry.SERVICES.MESSAGES.ERROR_SAVE), 'error');
        }
    };

    const handleDelete = async (id: string) => {
        if (!(await confirm('Delete Service', t(ContentRegistry.SERVICES.MESSAGES.CONFIRM_DELETE)))) return;
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}/v1/admin/services/${id}`, {
                method: 'DELETE',
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                fetchServices();
                showToast(t(ContentRegistry.SERVICES.MESSAGES.SUCCESS_DELETE), 'success');
            } else {
                showToast(t(ContentRegistry.SERVICES.MESSAGES.ERROR_DELETE), 'error');
            }
        } catch (error) {
            showToast(t(ContentRegistry.SERVICES.MESSAGES.ERROR_DELETE), 'error');
        }
    };

    return (
        <div role="main" aria-label="Services" style={{ padding: '1rem' }} data-cy="form.service.page">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }} data-cy="page.header">
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }} data-cy="page.title">{t(ContentRegistry.SERVICES.TITLE)}</h2>
                    <p style={{ color: '#6b7280', margin: '0.25rem 0 0 0' }} data-cy="page.subtitle">{t(ContentRegistry.SERVICES.SUBTITLE)}</p>
                </div>
                <button
                    data-cy="btn.service.add"
                    onClick={() => { setCurrentService({}); setIsModalOpen(true); }}
                    style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                >
                    {t(ContentRegistry.SERVICES.ADD_BTN)}
                </button>
            </div>

            <ServicesTable
                services={services}
                loading={loading}
                onEdit={(service) => { setCurrentService(service); setIsModalOpen(true); }}
                onDelete={handleDelete}
            />

            <ServiceFormModal
                isOpen={isModalOpen}
                onClose={() => setIsModalOpen(false)}
                onSave={handleSave}
                service={currentService}
            />
        <DialogRenderer />
            </div>
    );
}
