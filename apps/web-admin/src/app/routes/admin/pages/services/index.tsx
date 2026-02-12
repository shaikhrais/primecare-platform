import React, { useState, useEffect } from 'react';
import { useNotification } from '../../App';

const API_URL = import.meta.env.VITE_API_URL;

interface Service {
    id: string;
    name: string;
    description: string;
    hourlyRate: number;
    category: string;
}

export default function ServicesPage() {
    const { showToast } = useNotification();
    const [services, setServices] = useState<Service[]>([]);
    const [loading, setLoading] = useState(true);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [currentService, setCurrentService] = useState<Partial<Service>>({});
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);

    // Unsaved changes guard (Native - for tab close)
    useEffect(() => {
        const handleBeforeUnload = (e: BeforeUnloadEvent) => {
            if (isDirty && isModalOpen) {
                e.preventDefault();
                e.returnValue = '';
            }
        };
        window.addEventListener('beforeunload', handleBeforeUnload);
        return () => window.removeEventListener('beforeunload', handleBeforeUnload);
    }, [isDirty, isModalOpen]);

    const handleCloseModal = () => {
        if (isDirty) {
            setShowGuard(true);
        } else {
            setIsModalOpen(false);
            setCurrentService({});
        }
    };

    const fetchServices = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            // Assuming this endpoint exists or we'll add it
            const response = await fetch(`${API_URL}/v1/admin/services`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setServices(data);
            }
        } catch (error) {
            console.error('Failed to fetch services');
            showToast('Failed to load services', 'error');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchServices();
    }, []);

    const handleSave = async (e: React.FormEvent) => {
        e.preventDefault();
        try {
            const token = localStorage.getItem('token');
            const method = currentService.id ? 'PUT' : 'POST';
            const url = currentService.id
                ? `${API_URL}/v1/admin/services/${currentService.id}`
                : `${API_URL}/v1/admin/services`;

            const response = await fetch(url, {
                method,
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(currentService)
            });

            if (response.ok) {
                showToast(`Service ${currentService.id ? 'updated' : 'created'} successfully!`, 'success');
                setIsModalOpen(false);
                setIsDirty(false);
                fetchServices();
            } else {
                showToast('Failed to save service', 'error');
            }
        } catch (error) {
            showToast('Error saving service', 'error');
        }
    };

    const handleDelete = async (id: string) => {
        if (!confirm('Are you sure you want to delete this service?')) return;
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}/v1/admin/services/${id}`, {
                method: 'DELETE',
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                fetchServices();
                showToast('Service deleted successfully', 'success');
            } else {
                showToast('Failed to delete service', 'error');
            }
        } catch (error) {
            showToast('Error deleting service', 'error');
        }
    };

    return (
        <div style={{ padding: '1rem' }} data-cy="form.service.page">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }} data-cy="page.header">
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }} data-cy="page.title">Services & Pricing</h2>
                    <p style={{ color: '#6b7280', margin: '0.25rem 0 0 0' }} data-cy="page.subtitle">Manage the care packages and hourly rates offered to clients.</p>
                </div>
                <button
                    data-cy="btn.service.add"
                    onClick={() => { setCurrentService({}); setIsModalOpen(true); setIsDirty(false); }}
                    style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                >
                    + Add New Service
                </button>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }} data-cy="tbl-services">
                    <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                        <tr>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Service Name</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Category</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Hourly Rate</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Description</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {loading ? (
                            <tr><td colSpan={5} style={{ padding: '3rem', textAlign: 'center' }}>Loading services...</td></tr>
                        ) : services.length > 0 ? (
                            services.map((service) => (
                                <tr key={service.id} style={{ borderBottom: '1px solid #f3f4f6' }} data-cy={`row-service-${service.id}`}>
                                    <td style={{ padding: '1rem', fontWeight: '500' }}>{service.name}</td>
                                    <td style={{ padding: '1rem' }}>
                                        <span style={{ backgroundColor: '#f3f4f6', padding: '0.25rem 0.5rem', borderRadius: '0.25rem', fontSize: '0.75rem' }}>{service.category}</span>
                                    </td>
                                    <td style={{ padding: '1rem', fontWeight: '600' }}>${service.hourlyRate}/hr</td>
                                    <td style={{ padding: '1rem', color: '#6b7280', fontSize: '0.875rem', maxWidth: '300px' }}>{service.description}</td>
                                    <td style={{ padding: '1rem' }}>
                                        <button
                                            data-cy={`btn-edit-service-${service.id}`}
                                            onClick={() => { setCurrentService(service); setIsModalOpen(true); }}
                                            style={{ color: '#004d40', background: 'none', border: 'none', cursor: 'pointer', marginRight: '1rem', fontWeight: '500' }}
                                        >
                                            Edit
                                        </button>
                                        <button
                                            data-cy={`btn-delete-service-${service.id}`}
                                            onClick={() => handleDelete(service.id)}
                                            style={{ color: '#dc2626', background: 'none', border: 'none', cursor: 'pointer', fontWeight: '500' }}
                                        >
                                            Delete
                                        </button>
                                    </td>
                                </tr>
                            ))
                        ) : (
                            <tr><td colSpan={5} style={{ padding: '3rem', textAlign: 'center' }}>No services configured.</td></tr>
                        )}
                    </tbody>
                </table>
            </div>

            {isModalOpen && (
                <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }}>
                    {showGuard && (
                        <div data-cy="guard.unsaved.dialog" style={{ position: 'absolute', inset: 0, backgroundColor: 'rgba(0,0,0,0.8)', zIndex: 1001, display: 'flex', alignItems: 'center', justifyContent: 'center', borderRadius: '1rem' }}>
                            <div style={{ background: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '350px', textAlign: 'center' }}>
                                <h4 style={{ margin: '0 0 1rem 0' }}>Discard Changes?</h4>
                                <p style={{ fontSize: '0.9rem', color: '#6b7280', marginBottom: '1.5rem' }}>You have unsaved changes in this service. Are you sure you want to close?</p>
                                <div style={{ display: 'flex', gap: '1rem' }}>
                                    <button data-cy="guard.unsaved.leave" onClick={() => { setIsDirty(false); setShowGuard(false); setIsModalOpen(false); }} style={{ flex: 1, padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Discard</button>
                                    <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '0.625rem', borderRadius: '0.375rem', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                                </div>
                            </div>
                        </div>
                    )}
                    <form onSubmit={handleSave} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '500px', width: '90%', position: 'relative' }} data-cy="modal.service.container">
                        <h3 style={{ marginTop: 0 }}>{currentService.id ? 'Edit Service' : 'Add New Service'}</h3>
                        <div style={{ display: 'grid', gap: '1rem', marginTop: '1.5rem' }}>
                            <div>
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Service Name</label>
                                <input
                                    data-cy="modal.service.name"
                                    type="text"
                                    value={currentService.name || ''}
                                    onChange={(e) => { setCurrentService({ ...currentService, name: e.target.value }); setIsDirty(true); }}
                                    style={{ width: '100%', padding: '0.625rem', border: '1px solid #d1d5db', borderRadius: '0.375rem' }}
                                    required
                                />
                            </div>
                            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                                <div>
                                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Hourly Rate ($)</label>
                                    <input
                                        data-cy="modal.service.rate"
                                        type="number"
                                        value={currentService.hourlyRate || ''}
                                        onChange={(e) => { setCurrentService({ ...currentService, hourlyRate: parseFloat(e.target.value) }); setIsDirty(true); }}
                                        style={{ width: '100%', padding: '0.625rem', border: '1px solid #d1d5db', borderRadius: '0.375rem' }}
                                        required
                                    />
                                </div>
                                <div>
                                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Category</label>
                                    <select
                                        data-cy="modal.service.category"
                                        value={currentService.category || ''}
                                        onChange={(e) => { setCurrentService({ ...currentService, category: e.target.value }); setIsDirty(true); }}
                                        style={{ width: '100%', padding: '0.625rem', border: '1px solid #d1d5db', borderRadius: '0.375rem' }}
                                    >
                                        <option value="Senior Care">Senior Care</option>
                                        <option value="Foot Care">Foot Care</option>
                                        <option value="Consulting">Consulting</option>
                                        <option value="Training">Training</option>
                                    </select>
                                </div>
                            </div>
                            <div>
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Description</label>
                                <textarea
                                    data-cy="modal.service.desc"
                                    value={currentService.description || ''}
                                    onChange={(e) => { setCurrentService({ ...currentService, description: e.target.value }); setIsDirty(true); }}
                                    rows={3}
                                    style={{ width: '100%', padding: '0.625rem', border: '1px solid #d1d5db', borderRadius: '0.375rem' }}
                                />
                            </div>
                        </div>

                        <div style={{ display: 'flex', gap: '1rem', marginTop: '2rem' }}>
                            <button type="button" data-cy="modal.service.close" onClick={handleCloseModal} style={{ flex: 1, padding: '0.75rem', backgroundColor: '#f3f4f6', border: 'none', borderRadius: '0.5rem' }}>Cancel</button>
                            <button type="submit" data-cy="modal.service.save" style={{ flex: 1, padding: '0.75rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600' }}>Save Service</button>
                        </div>
                    </form>
                </div>
            )}
        </div>
    );
}
