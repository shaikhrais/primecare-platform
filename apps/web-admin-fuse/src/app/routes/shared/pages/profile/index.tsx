import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';

const API_URL = import.meta.env.VITE_API_URL;

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

    const fetchProfile = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            const endpoint = role === 'psw' ? '/v1/psw/profile' : role === 'admin' || role === 'staff' ? '/v1/user/profile' : '/v1/client/profile';
            const response = await fetch(`${API_URL}${endpoint}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setProfile(data);
            } else if (response.status === 403 || response.status === 404) {
                // Fallback to local user data if profile endpoint not found for this role
                setProfile({ ...user, fullName: user.fullName || user.email?.split('@')[0] });
            }
        } catch (error) {
            console.error('Failed to fetch profile', error);
            showToast('Failed to load profile data', 'error');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchProfile();
    }, []);

    const handleSave = async (e: React.FormEvent) => {
        e.preventDefault();
        setSaving(true);
        try {
            const token = localStorage.getItem('token');
            const endpoint = role === 'psw' ? '/v1/psw/profile' : '/v1/client/profile';
            const response = await fetch(`${API_URL}${endpoint}`, {
                method: 'PUT',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(profile)
            });
            if (response.ok) {
                showToast('Profile updated successfully!', 'success');
                setIsDirty(false);
            }
        } catch (error) {
            showToast('Failed to update profile', 'error');
        } finally {
            setSaving(false);
        }
    };

    if (loading) return <div style={{ padding: '2rem', textAlign: 'center' }}>Loading profile...</div>;

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '1rem' }} data-cy="form.profile.page">
            {/* Unsaved Changes Guard Dialog */}
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', border: '1px solid #e5e7eb', maxWidth: '400px', textAlign: 'center', color: '#111827' }}>
                        <h2 style={{ marginTop: 0 }}>Unsaved Changes</h2>
                        <p style={{ opacity: 0.8, marginBottom: '24px' }}>You have unsaved changes. Navigating away will discard them. Would you like to stay and save?</p>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer', color: '#374151' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }} data-cy="page.title">Account Profile</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Manage your personal information and preferences.</p>
            </div>

            <form onSubmit={handleSave} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
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
