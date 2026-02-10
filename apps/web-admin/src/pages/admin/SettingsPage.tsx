import React, { useState, useEffect } from 'react';
import { useNotification } from '../../App';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

export default function SettingsPage() {
    const { showToast } = useNotification();
    const [settings, setSettings] = useState({
        emailAlerts: true,
        autoAssignment: false,
        gracePeriod: '15 Minutes'
    });

    useEffect(() => {
        const saved = localStorage.getItem('adminSettings');
        if (saved) setSettings(JSON.parse(saved));
    }, []);

    const handleSave = () => {
        localStorage.setItem('adminSettings', JSON.stringify(settings));
        showToast(ContentRegistry.SETTINGS.ACTIONS.SUCCESS_SAVE, 'success');
    };

    const handleReset = () => {
        setSettings({ emailAlerts: true, autoAssignment: false, gracePeriod: '15 Minutes' });
    };

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '1rem' }}>
            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }}>{ContentRegistry.SETTINGS.TITLE}</h2>
                <p style={{ color: '#6b7280' }}>{ContentRegistry.SETTINGS.SUBTITLE}</p>
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
                            onChange={(e) => setSettings({ ...settings, emailAlerts: e.target.checked })}
                            style={{ width: '1.25rem', height: '1.25rem', accentColor: '#004d40' }}
                            data-cy="chk-email-alerts"
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
                            onChange={(e) => setSettings({ ...settings, autoAssignment: e.target.checked })}
                            style={{ width: '1.25rem', height: '1.25rem', accentColor: '#004d40' }}
                            data-cy="chk-auto-assign"
                        />
                    </div>
                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '1rem', border: '1px solid #f3f4f6', borderRadius: '0.5rem' }}>
                        <div>
                            <div style={{ fontWeight: '500' }}>{ContentRegistry.SETTINGS.SCHEDULING.GRACE_PERIOD}</div>
                            <div style={{ fontSize: '0.875rem', color: '#6b7280' }}>{ContentRegistry.SETTINGS.SCHEDULING.GRACE_DESC}</div>
                        </div>
                        <select
                            value={settings.gracePeriod}
                            onChange={(e) => setSettings({ ...settings, gracePeriod: e.target.value })}
                            style={{ padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                            data-cy="sel-grace-period"
                        >
                            <option>15 Minutes</option>
                            <option>30 Minutes</option>
                            <option>1 Hour</option>
                        </select>
                    </div>
                </div>

                <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '1rem' }}>
                    <button
                        onClick={handleReset}
                        style={{ padding: '0.75rem 1.5rem', backgroundColor: '#f3f4f6', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                        data-cy="btn-reset-settings"
                    >
                        {ContentRegistry.SETTINGS.ACTIONS.RESET}
                    </button>
                    <button
                        onClick={handleSave}
                        style={{ padding: '0.75rem 1.5rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                        data-cy="btn-save-settings"
                    >
                        {ContentRegistry.SETTINGS.ACTIONS.SAVE}
                    </button>
                </div>
            </div>
        </div>
    );
}
