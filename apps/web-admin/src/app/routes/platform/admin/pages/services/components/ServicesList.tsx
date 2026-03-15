import React from 'react';
import { useDialog } from '@/shared/hooks/useDialog';

interface Service {
    id: string;
    name: string;
    code: string;
    hourlyRate: number;
    description?: string;
}

interface ServicesListProps {
    services: Service[];
    searchTerm: string;
    loading: boolean;
    onEdit: (service: Service) => void;
    onDelete: (id: string) => void;
}

export const ServicesList: React.FC<ServicesListProps> = ({ services, searchTerm, loading, onEdit, onDelete }) => {
    const { confirm, DialogRenderer } = useDialog();
    const filteredServices = services.filter(s =>
        s.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        s.code.toLowerCase().includes(searchTerm.toLowerCase())
    );

    return (
        <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }} data-cy="tbl.services">
                <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                    <tr>
                        <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>Service Name</th>
                        <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>Code</th>
                        <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>Rate ($/hr)</th>
                        <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>Description</th>
                        <th style={{ padding: '1rem', fontWeight: '600', color: '#374151', textAlign: 'right' }}>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {loading ? (
                        <tr>
                            <td colSpan={5} style={{ padding: '2rem', textAlign: 'center', color: '#6b7280' }}>Loading services...</td>
                        </tr>
                    ) : filteredServices.length > 0 ? (
                        filteredServices.map((service) => (
                            <tr key={service.id} style={{ borderBottom: '1px solid #f3f4f6' }} data-cy={`row-service-${service.id}`}>
                                <td style={{ padding: '1rem', fontWeight: '500', color: '#111827' }}>{service.name}</td>
                                <td style={{ padding: '1rem', color: '#4b5563', fontFamily: 'monospace' }}>{service.code}</td>
                                <td style={{ padding: '1rem', color: '#059669', fontWeight: '600' }}>${service.hourlyRate.toFixed(2)}</td>
                                <td style={{ padding: '1rem', color: '#6b7280', maxWidth: '300px', whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                                    {service.description || '-'}
                                </td>
                                <td style={{ padding: '1rem', textAlign: 'right' }}>
                                    <button
                                        onClick={() => onEdit(service)}
                                        style={{ marginRight: '0.75rem', color: '#4f46e5', background: 'none', border: 'none', cursor: 'pointer', fontWeight: '500' }}
                                        data-cy={`btn-edit-${service.id}`}
                                    >
                                        Edit
                                    </button>
                                    <button
                                        onClick={() => {
                                            confirm('Delete Service', 'Are you sure you want to delete this service? This action cannot be undone.').then(ok => { if (ok) onDelete(service.id); });
                                        }}
                                        style={{ color: '#ef4444', background: 'none', border: 'none', cursor: 'pointer', fontWeight: '500' }}
                                        data-cy={`btn-delete-${service.id}`}
                                    >
                                        Delete
                                    </button>
                                </td>
                            </tr>
                        ))
                    ) : (
                        <tr>
                            <td colSpan={5} style={{ padding: '2rem', textAlign: 'center', color: '#6b7280' }}>
                                {searchTerm ? 'No services match your search.' : 'No services found. create one to get started.'}
                            </td>
                        </tr>
                    )}
                </tbody>
            </table>
            <DialogRenderer />
        </div>
    );
};
