import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '../../App';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

export default function SettingsPage() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [settings, setSettings] = useState({
        emailAlerts: true,
        autoAssignment: false,
        gracePeriod: '15 Minutes'
    });
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);

    useEffect(() => {
        const handleBeforeUnload = (e: BeforeUnloadEvent) => {
            if (isDirty) {
                e.preventDefault();
                e.returnValue = '';
            }
        };
        window.addEventListener('beforeunload', handleBeforeUnload);
        return () => window.removeEventListener('beforeunload', handleBeforeUnload);
    }, [isDirty]);

    useEffect(() => {
        const saved = localStorage.getItem('adminSettings');
        if (saved) setSettings(JSON.parse(saved));
    }, []);

    const handleSave = () => {
        localStorage.setItem('adminSettings', JSON.stringify(settings));
        setIsDirty(false);
        showToast(ContentRegistry.SETTINGS.ACTIONS.SUCCESS_SAVE, 'success');
    };

    const handleReset = () => {
        setSettings({ emailAlerts: true, autoAssignment: false, gracePeriod: '15 Minutes' });
        setIsDirty(true);
    };

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '1rem' }} data-cy="page.container">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', border: '1px solid #e5e7eb', maxWidth: '400px', textAlign: 'center', color: '#111827' }}>
                        <h2 style={{ marginTop: 0 }}>Unsaved Changes</h2>
                        <p style={{ opacity: 0.8, marginBottom: '24px' }}>You have unsaved configuration changes. Navigating away will discard them.</p>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => { setIsDirty(false); setShowGuard(false); }} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Discard</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}
            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }} data-cy="page.title">{ContentRegistry.SETTINGS.TITLE}</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.header">{ContentRegistry.SETTINGS.SUBTITLE}</p>
            </div>

            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                <div style={{ marginBottom: '2.5rem' }}>
                    <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1rem' }}>{ContentRegistry.SETTINGS.NOTIFICATIONS.TITLE}</h3>
                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '1rem', border: '1px solid #f3f4f6', borderRadius: '0.5rem' }}>
                        <div>
                            <div style={{ fontWeight: '500' }}>{ContentRegistry.SETTINGS.NOTIFICATIONS.EMAIL_ALERTS}</div>
                            <div style={{ fontSize: '0.875rem', color: '#6b7280' }}>{ContentRegistry.SETTINGS.NOTIFICATIONS.EMAIL_DESC}</div>
                        </div>
                        <input
                            type="checkbox"
                            checked={settings.emailAlerts}
                            onChange={(e) => { setSettings({ ...settings, emailAlerts: e.target.checked }); setIsDirty(true); }}
                            style={{ width: '1.25rem', height: '1.25rem', accentColor: '#004d40' }}
                            data-cy="form.settings.emailAlerts"
                        />
                    </div>
                </div>

                <div style={{ marginBottom: '2.5rem' }}>
                    <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1rem' }}>{ContentRegistry.SETTINGS.SCHEDULING.TITLE}</h3>
                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '1rem', border: '1px solid #f3f4f6', borderRadius: '0.5rem', marginBottom: '1rem' }}>
                        <div>
                            <div style={{ fontWeight: '500' }}>{ContentRegistry.SETTINGS.SCHEDULING.AUTO_ASSIGN}</div>
                            <div style={{ fontSize: '0.875rem', color: '#6b7280' }}>{ContentRegistry.SETTINGS.SCHEDULING.AUTO_DESC}</div>
                        </div>
                        <input
                            type="checkbox"
                            checked={settings.autoAssignment}
                            onChange={(e) => { setSettings({ ...settings, autoAssignment: e.target.checked }); setIsDirty(true); }}
                            style={{ width: '1.25rem', height: '1.25rem', accentColor: '#004d40' }}
                            data-cy="form.settings.autoAssign"
                        />
                    </div>
                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '1rem', border: '1px solid #f3f4f6', borderRadius: '0.5rem' }}>
                        <div>
                            <div style={{ fontWeight: '500' }}>{ContentRegistry.SETTINGS.SCHEDULING.GRACE_PERIOD}</div>
                            <div style={{ fontSize: '0.875rem', color: '#6b7280' }}>{ContentRegistry.SETTINGS.SCHEDULING.GRACE_DESC}</div>
                        </div>
                        <select
                            value={settings.gracePeriod}
                            onChange={(e) => { setSettings({ ...settings, gracePeriod: e.target.value }); setIsDirty(true); }}
                            style={{ padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                            data-cy="form.settings.gracePeriod"
                        >
                            <option>15 Minutes</option>
                            <option>30 Minutes</option>
                            <option>1 Hour</option>
                        </select>
                    </div>
                </div>

                <div style={{ marginBottom: '2.5rem' }}>
                    <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1rem' }}>System Administration</h3>
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                        <button
                            data-cy="btn.nav.roles"
                            onClick={() => navigate('/settings/roles')}
                            style={{ padding: '1rem', border: '1px solid #e5e7eb', borderRadius: '0.5rem', background: '#f9fafb', cursor: 'pointer', textAlign: 'left' }}
                        >
                            <div style={{ fontWeight: '600' }}>Role Permissions</div>
                            <div style={{ fontSize: '0.75rem', color: '#6b7280' }}>Define custom access grids.</div>
                        </button>
                        <button
                            data-cy="btn.nav.templates"
                            onClick={() => navigate('/settings/templates')}
                            style={{ padding: '1rem', border: '1px solid #e5e7eb', borderRadius: '0.5rem', background: '#f9fafb', cursor: 'pointer', textAlign: 'left' }}
                        >
                            <div style={{ fontWeight: '600' }}>Message Templates</div>
                            <div style={{ fontSize: '0.75rem', color: '#6b7280' }}>Edit automated notifications.</div>
                        </button>
                    </div>
                </div>

                <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '1rem' }}>
                    <button
                        onClick={handleReset}
                        style={{ padding: '0.75rem 1.5rem', backgroundColor: '#f3f4f6', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                        data-cy="form.settings.reset"
                    >
                        {ContentRegistry.SETTINGS.ACTIONS.RESET}
                    </button>
                    <button
                        onClick={handleSave}
                        style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                        data-cy="form.settings.save"
                    >
                        {ContentRegistry.SETTINGS.ACTIONS.SAVE}
                    </button>
                </div>
            </div>
        </div>
    );
}
