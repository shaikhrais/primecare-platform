import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import 'leaflet/dist/leaflet.css';
import { fetchProfile as apiFetchProfile, saveProfile } from './profileHelpers';
import { UnsavedChangesGuard, LocationMapPreview } from './ProfileComponents';

export default function ProfilePage() {
    const { showToast } = useNotification();
    const [profile, setProfile] = useState<any>({ user: {} });
    const [loading, setLoading] = useState(true);
    const [saving, setSaving] = useState(false);
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const navigate = useNavigate();

    const user = JSON.parse(localStorage.getItem('user') || '{}');
    const role = user.role;

    // Unsaved changes guard (Native)
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

    const loadProfile = async () => {
        setLoading(true);
        await apiFetchProfile(
            role,
            (data) => setProfile(data),
            (fallback) => setProfile(fallback),
            (msg) => showToast(msg, 'error')
        );
        setLoading(false);
    };

    useEffect(() => { loadProfile(); }, []);

    const handleSave = async (e: React.FormEvent) => {
        e.preventDefault();
        setSaving(true);
        await saveProfile(
            role, profile,
            () => { showToast('Profile updated successfully!', 'success'); setIsDirty(false); },
            () => showToast('Failed to update profile', 'error')
        );
        setSaving(false);
    };

    if (loading) return <div style={{ padding: '2rem', textAlign: 'center' }}>Loading profile...</div>;

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '1rem' }} data-cy="form.profile.page">
            {showGuard && <UnsavedChangesGuard onLeave={() => navigate(-1)} onStay={() => setShowGuard(false)} />}

            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }} data-cy="page.title">Account Profile</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Manage your personal information and preferences.</p>
            </div>

            <form data-cy="form-shared.index" onSubmit={handleSave} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', color: '#374151', marginBottom: '0.5rem' }}>Full Name</label>
                        <input
                            data-cy="form.profile.fullname"
                            type="text"
                            value={profile.fullName || ''}
                            onChange={(e) => {
                                setProfile({ ...profile, fullName: e.target.value });
                                setIsDirty(true);
                            }}
                            style={{ width: '100%', padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                        />
                    </div>

                    {role === 'psw' ? (
                        <div style={{ gridColumn: 'span 2' }}>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', color: '#374151', marginBottom: '0.5rem' }}>Professional Bio</label>
                            <textarea
                                data-cy="form.profile.bio"
                                value={profile.bio || ''}
                                onChange={(e) => {
                                    setProfile({ ...profile, bio: e.target.value });
                                    setIsDirty(true);
                                }}
                                rows={4}
                                style={{ width: '100%', padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                            />
                        </div>
                    ) : (
                        <>
                            <div>
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', color: '#374151', marginBottom: '0.5rem' }}>Address</label>
                                <input
                                    data-cy="form.profile.address"
                                    type="text"
                                    value={profile.addressLine1 || ''}
                                    onChange={(e) => {
                                        setProfile({ ...profile, addressLine1: e.target.value });
                                        setIsDirty(true);
                                    }}
                                    style={{ width: '100%', padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                                />
                            </div>
                            <div>
                                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', color: '#374151', marginBottom: '0.5rem' }}>City</label>
                                <input
                                    data-cy="form.profile.city"
                                    type="text"
                                    value={profile.city || ''}
                                    onChange={(e) => {
                                        setProfile({ ...profile, city: e.target.value });
                                        setIsDirty(true);
                                    }}
                                    style={{ width: '100%', padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                                />
                            </div>
                        </>
                    )}

                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', color: '#374151', marginBottom: '0.5rem' }}>Email (Unchangeable)</label>
                        <input
                            data-cy="form.profile.email.readonly"
                            type="email"
                            value={profile.user?.email || ''}
                            disabled
                            style={{ width: '100%', padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #e5e7eb', backgroundColor: '#f9fafb' }}
                        />
                    </div>
                    <div>
                        <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', color: '#374151', marginBottom: '0.5rem' }}>Phone</label>
                        <input
                            data-cy="form.profile.phone.readonly"
                            type="text"
                            value={profile.user?.phone || ''}
                            disabled
                            style={{ width: '100%', padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #e5e7eb', backgroundColor: '#f9fafb' }}
                        />
                    </div>

                    {(role === 'client' || role === 'psw') && (
                        <LocationMapPreview lat={profile.lat} lng={profile.lng} role={role} />
                    )}
                </div>

                <div style={{ marginTop: '2rem', display: 'flex', justifyContent: 'flex-end' }}>
                    <button
                        data-cy="form.profile.save"
                        type="submit"
                        disabled={saving}
                        style={{
                            padding: '0.75rem 1.5rem',
                            backgroundColor: '#004d40',
                            color: 'white',
                            border: 'none',
                            borderRadius: '0.5rem',
                            fontWeight: '600',
                            cursor: 'pointer',
                            opacity: saving ? 0.7 : 1
                        }}
                    >
                        {saving ? 'Saving...' : 'Save Changes'}
                    </button>
                </div>
            </form>
        </div>
    );
}
