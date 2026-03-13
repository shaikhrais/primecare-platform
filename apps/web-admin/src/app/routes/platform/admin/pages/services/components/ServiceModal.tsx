import React, { useState, useEffect } from 'react';

interface ServiceModalProps {
    isOpen: boolean;
    onClose: () => void;
    onSubmit: (data: any) => Promise<void>;
    initialData?: any;
    submitting: boolean;
}

export const ServiceModal: React.FC<ServiceModalProps> = ({ isOpen, onClose, onSubmit, initialData, submitting }) => {
    const [formData, setFormData] = useState({
        name: '',
        code: '',
        hourlyRate: '',
        description: ''
    });

    useEffect(() => {
        if (isOpen) {
            if (initialData) {
                setFormData({
                    name: initialData.name || '',
                    code: initialData.code || '',
                    hourlyRate: initialData.hourlyRate || '',
                    description: initialData.description || ''
                });
            } else {
                setFormData({ name: '', code: '', hourlyRate: '', description: '' });
            }
        }
    }, [isOpen, initialData]);

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        await onSubmit(formData);
    };

    if (!isOpen) return null;

    return (
        <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 50 }}>
            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', width: '90%', maxWidth: '500px' }}>
                <h3 data-cy="h3-admin.service-modal-0" style={{ marginTop: 0, fontSize: '1.25rem', fontWeight: 'bold' }}>
                    {initialData ? 'Edit Service' : 'Create New Service'}
                </h3>

                <form data-cy="form-admin.service-modal" onSubmit={handleSubmit} style={{ marginTop: '1.5rem', display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Service Name</label>
                        <input data-cy="input-admin.service-modal-0"
                            required
                            type="text"
                            value={formData.name}
                            onChange={(e) => setFormData(prev => ({ ...prev, name: e.target.value }))}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                        <div>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Service Code</label>
                            <input data-cy="input-admin.service-modal-1"
                                required
                                type="text"
                                value={formData.code}
                                onChange={(e) => setFormData(prev => ({ ...prev, code: e.target.value.toUpperCase() }))}
                                placeholder="e.g. VIS-01"
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                            />
                        </div>
                        <div>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Hourly Rate ($)</label>
                            <input data-cy="input-admin.service-modal-2"
                                required
                                type="number"
                                step="0.01"
                                min="0"
                                value={formData.hourlyRate}
                                onChange={(e) => setFormData(prev => ({ ...prev, hourlyRate: e.target.value }))}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                            />
                        </div>
                    </div>

                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Description</label>
                        <textarea data-cy="textarea-admin.service-modal"
                            rows={3}
                            value={formData.description}
                            onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>

                    <div style={{ display: 'flex', gap: '1rem', marginTop: '1rem' }}>
                        <button data-cy="btn-admin.service-modal-0"
                            type="button"
                            onClick={onClose}
                            style={{ flex: 1, padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', backgroundColor: 'transparent', cursor: 'pointer' }}
                        >
                            Cancel
                        </button>
                        <button data-cy="btn-admin.service-modal-1"
                            type="submit"
                            disabled={submitting}
                            style={{ flex: 2, padding: '0.75rem', borderRadius: '0.5rem', border: 'none', backgroundColor: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer', opacity: submitting ? 0.7 : 1 }}
                        >
                            {submitting ? 'Saving...' : (initialData ? 'Update Service' : 'Create Service')}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
};
