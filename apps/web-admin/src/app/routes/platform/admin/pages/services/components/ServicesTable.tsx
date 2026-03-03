import React from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

const { ContentRegistry } = AdminRegistry;

interface Service {
    id: string;
    name: string;
    description: string;
    hourlyRate: number;
    category: string;
}

interface ServicesTableProps {
    services: Service[];
    loading: boolean;
    onEdit: (service: Service) => void;
    onDelete: (id: string) => void;
}

export function ServicesTable({
    services,
    loading,
    onEdit,
    onDelete
}: ServicesTableProps) {
    const { t } = useTranslation();

    return (
        <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }} data-cy="tbl-services">
                <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                    <tr>
                        <th style={{ padding: '1rem', fontWeight: '600' }} data-cy="tbl-services-header-name">{t(ContentRegistry.SERVICES.TABLE.NAME)}</th>
                        <th style={{ padding: '1rem', fontWeight: '600' }} data-cy="tbl-services-header-category">{t(ContentRegistry.SERVICES.TABLE.CATEGORY)}</th>
                        <th style={{ padding: '1rem', fontWeight: '600' }} data-cy="tbl-services-header-rate">{t(ContentRegistry.SERVICES.TABLE.RATE)}</th>
                        <th style={{ padding: '1rem', fontWeight: '600' }} data-cy="tbl-services-header-desc">{t(ContentRegistry.SERVICES.TABLE.DESC)}</th>
                        <th style={{ padding: '1rem', fontWeight: '600' }} data-cy="tbl-services-header-actions">{t(ContentRegistry.SERVICES.TABLE.ACTIONS)}</th>
                    </tr>
                </thead>
                <tbody>
                    {loading ? (
                        <tr><td colSpan={5} style={{ padding: '3rem', textAlign: 'center' }}>{t(ContentRegistry.SERVICES.TABLE.LOADING)}</td></tr>
                    ) : services.length > 0 ? (
                        services.map((service) => (
                            <tr key={service.id} style={{ borderBottom: '1px solid #f3f4f6' }} data-cy={`row-service-${service.id}`}>
                                <td style={{ padding: '1rem', fontWeight: '500' }} data-cy="service-name">{service.name}</td>
                                <td style={{ padding: '1rem' }}>
                                    <span style={{ backgroundColor: '#f3f4f6', padding: '0.25rem 0.5rem', borderRadius: '0.25rem', fontSize: '0.75rem' }} data-cy="service-category">{service.category}</span>
                                </td>
                                <td style={{ padding: '1rem', fontWeight: '600' }} data-cy="service-rate">${service.hourlyRate}/hr</td>
                                <td style={{ padding: '1rem', color: '#6b7280', fontSize: '0.875rem', maxWidth: '300px' }} data-cy="service-desc">{service.description}</td>
                                <td style={{ padding: '1rem' }}>
                                    <button
                                        data-cy={`btn-edit-service-${service.id}`}
                                        onClick={() => onEdit(service)}
                                        style={{ color: '#004d40', background: 'none', border: 'none', cursor: 'pointer', marginRight: '1rem', fontWeight: '500' }}
                                    >
                                        {t(ContentRegistry.COMMON.EDIT)}
                                    </button>
                                    <button
                                        data-cy={`btn-delete-service-${service.id}`}
                                        onClick={() => onDelete(service.id)}
                                        style={{ color: '#dc2626', background: 'none', border: 'none', cursor: 'pointer', fontWeight: '500' }}
                                    >
                                        {t(ContentRegistry.COMMON.DELETE)}
                                    </button>
                                </td>
                            </tr>
                        ))
                    ) : (
                        <tr><td colSpan={5} style={{ padding: '3rem', textAlign: 'center' }}>{t(ContentRegistry.SERVICES.TABLE.EMPTY)}</td></tr>
                    )}
                </tbody>
            </table>
        </div>
    );
}
