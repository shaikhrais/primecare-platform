import React, { useState, useEffect } from 'react';
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

interface ServiceFormModalProps {
    isOpen: boolean;
    onClose: () => void;
    onSave: (service: Partial<Service>) => Promise<void>;
    service: Partial<Service>;
}

export function ServiceFormModal({
    isOpen,
    onClose,
    onSave,
    service
}: ServiceFormModalProps) {
    const { t } = useTranslation();
    const [currentService, setCurrentService] = useState<Partial<Service>>(service);
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);

    useEffect(() => {
        setCurrentService(service);
        setIsDirty(false);
        setShowGuard(false);
    }, [service, isOpen]);

    const handleClose = () => {
        if (isDirty) {
            setShowGuard(true);
        } else {
            onClose();
        }
    };

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        onSave(currentService);
    };

    if (!isOpen) return null;

    return (
        <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }}>
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'absolute', inset: 0, backgroundColor: 'rgba(0,0,0,0.8)', zIndex: 1001, display: 'flex', alignItems: 'center', justifyContent: 'center', borderRadius: '1rem' }}>
                    <div style={{ background: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '350px', textAlign: 'center' }}>
                        <h4 style={{ margin: '0 0 1rem 0' }}>{t(ContentRegistry.SERVICES.FORM.DISCARD_TITLE)}</h4>
                        <p style={{ fontSize: '0.9rem', color: '#6b7280', marginBottom: '1.5rem' }}>{t(ContentRegistry.SERVICES.FORM.DISCARD_DESC)}</p>
                        <div style={{ display: 'flex', gap: '1rem' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => { setIsDirty(false); setShowGuard(false); onClose(); }} style={{ flex: 1, padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>{t(ContentRegistry.COMMON.DELETE)}</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '0.625rem', borderRadius: '0.375rem', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>{t(ContentRegistry.USERS.MODAL.STAY_BTN)}</button>
                        </div>
                    </div>
                </div>
            )}
            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '500px', width: '90%', position: 'relative' }} data-cy="modal.service.container">
                <h3 data-cy="h3-admin.service-form-modal-0" style={{ marginTop: 0 }}>{currentService.id ? t(ContentRegistry.SERVICES.FORM.TITLE_EDIT) : t(ContentRegistry.SERVICES.FORM.TITLE_CREATE)}</h3>
                <div style={{ display: 'grid', gap: '1rem', marginTop: '1.5rem' }}>
                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>{t(ContentRegistry.SERVICES.FORM.NAME_LABEL)}</label>
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
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>{t(ContentRegistry.SERVICES.FORM.RATE_LABEL)}</label>
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
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>{t(ContentRegistry.SERVICES.FORM.CATEGORY_LABEL)}</label>
                            <select
                                data-cy="modal.service.category"
                                value={currentService.category || ''}
                                onChange={(e) => { setCurrentService({ ...currentService, category: e.target.value }); setIsDirty(true); }}
                                style={{ width: '100%', padding: '0.625rem', border: '1px solid #d1d5db', borderRadius: '0.375rem' }}
                            >
                                <option value="Senior Care">{t(ContentRegistry.SERVICES.CATEGORIES.SENIOR_CARE)}</option>
                                <option value="Foot Care">{t(ContentRegistry.SERVICES.CATEGORIES.FOOT_CARE)}</option>
                                <option value="Consulting">{t(ContentRegistry.SERVICES.CATEGORIES.CONSULTING)}</option>
                                <option value="Training">{t(ContentRegistry.SERVICES.CATEGORIES.TRAINING)}</option>
                            </select>
                        </div>
                    </div>
                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>{t(ContentRegistry.SERVICES.FORM.DESC_LABEL)}</label>
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
                    <button type="button" data-cy="modal.service.close" onClick={handleClose} style={{ flex: 1, padding: '0.75rem', backgroundColor: '#f3f4f6', border: 'none', borderRadius: '0.5rem' }}>{t(ContentRegistry.SERVICES.FORM.CANCEL_BTN)}</button>
                    <button type="submit" data-cy="modal.service.save" style={{ flex: 1, padding: '0.75rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600' }}>{t(ContentRegistry.SERVICES.FORM.SAVE_BTN)}</button>
                </div>
            </form>
        </div>
    );
}
