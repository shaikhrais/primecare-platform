import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { useDialog } from '@/shared/hooks/useDialog';
// import { apiClient } from '@/shared/utils/apiClient'; // Assuming this exists or using fetch

const API_URL = import.meta.env.VITE_API_URL;

export default function LocationsList() {
    const { confirm, DialogRenderer } = useDialog();
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [locations, setLocations] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchLocations = async () => {
            try {
                const token = localStorage.getItem('token');
                // In real implementation: const res = await fetch(`${API_URL}/v1/admin/locations`, ...);

 // fetch for now as backend might not have data
                setTimeout(() => {
                    setLocations([
                        { id: '1', name: 'Downtown Clinic', manager: 'Sarah Connor', capacity: 50, status: 'Active' },
                        { id: '2', name: 'Westside Care Center', manager: 'James Miller', capacity: 30, status: 'Active' },
                        { id: '3', name: 'North End Hub', manager: 'Pending', capacity: 20, status: 'Inactive' }
                    ]);
                    setLoading(false);
                }, 500);

            } catch (error) {
                console.error(error);
                showToast('Failed to load locations', 'error');
                setLoading(false);
            }
        };

        fetchLocations();
    }, []);

    return (
        <div style={{ padding: '2rem' }} data-cy="locations-list-page">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827', margin: 0 }} data-cy="page.title">Care Locations</h2>
                    <p style={{ color: '#6b7280', margin: '0.25rem 0 0 0' }} data-cy="page.subtitle">Manage facilities, clinics, and operating hubs.</p>
                </div>
                <button
                    data-cy="btn-add-location"
                    onClick={() => navigate('/locations/new')}
                    style={{ padding: '0.625rem 1.25rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}
                >
                    + Add Location
                </button>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.5rem', boxShadow: '0 1px 3px 0 rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table data-cy="table-admin.list" style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                    <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                        <tr>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Facility Name</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Manager</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Capacity</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Status</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {loading ? (
                            <>{[1,2,3].map(i => <tr key={i}><td colSpan={5} style={{ padding: '0.75rem' }}><div style={{ height: '14px', borderRadius: '6px', background: 'linear-gradient(90deg, var(--pc-bg-tertiary,#F3F4F6) 25%, var(--pc-bg-secondary,#E5E7EB) 50%, var(--pc-bg-tertiary,#F3F4F6) 75%)', backgroundSize: '200% 100%', animation: 'pcShimmer 1.5s ease-in-out infinite', width: `${90 - i * 15}%` }} /></td></tr>)}</>
                        ) : locations.length > 0 ? (
                            locations.map((loc) => (
                                <tr key={loc.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                    <td style={{ padding: '1rem', color: '#111827', fontWeight: 500 }}>{loc.name}</td>
                                    <td style={{ padding: '1rem', color: '#4b5563' }}>{loc.manager}</td>
                                    <td style={{ padding: '1rem', color: '#4b5563' }}>{loc.capacity}</td>
                                    <td style={{ padding: '1rem' }}>
                                        <span style={{
                                            padding: '0.25rem 0.625rem',
                                            borderRadius: '9999px',
                                            backgroundColor: loc.status === 'Active' ? '#dcfce7' : '#f3f4f6',
                                            color: loc.status === 'Active' ? '#166534' : '#374151',
                                            fontWeight: '600',
                                            fontSize: '0.75rem'
                                        }}>
                                            {loc.status}
                                        </span>
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        <button data-cy="btn-admin.list-0"
                                            onClick={() => navigate(`/locations/${loc.id}`)}
                                            style={{ color: '#004d40', fontWeight: '500', border: 'none', background: 'none', cursor: 'pointer', marginRight: '1rem' }}
                                        >
                                            Edit
                                        </button>
                                        <button data-cy="btn-admin.list-1"
                                            onClick={async () => {
                                                if (!(await confirm('Delete Location', `Delete "${loc.name}"? This action cannot be undone.`))) return;
                                                try {
                                                    const token = localStorage.getItem('token');
                                                    await fetch(`${API_URL}/v1/admin/locations/${loc.id}`, { method: 'DELETE', headers: { 'Authorization': `Bearer ${token}` } });
                                                    setLocations(prev => prev.filter(l => l.id !== loc.id));
                                                    showToast(`Location "${loc.name}" deleted`, 'success');
                                                } catch { showToast('Failed to delete location', 'error'); }
                                            }}
                                            style={{ color: '#991b1b', fontWeight: '500', border: 'none', background: 'none', cursor: 'pointer' }}
                                        >
                                            Delete
                                        </button>
                                    </td>
                                </tr>
                            ))
                        ) : (
                            <tr><td colSpan={5} style={{ padding: '2rem', textAlign: 'center', color: '#6b7280' }}>No locations found.</td></tr>
                        )}
                    </tbody>
                </table>
            </div>
        <DialogRenderer />
            </div>
    );
}
