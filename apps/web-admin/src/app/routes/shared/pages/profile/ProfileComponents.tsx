// ProfilePage: UnsavedChangesGuard and LocationMapPreview sub-components extracted
import React from 'react';
import { MapContainer, TileLayer, Marker } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import { ChangeView } from './profileHelpers';

interface UnsavedChangesGuardProps {
    onLeave: () => void;
    onStay: () => void;
}

export const UnsavedChangesGuard: React.FC<UnsavedChangesGuardProps> = ({ onLeave, onStay }) => (
    <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'var(--pc-bg-overlay)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
        <div style={{ background: 'var(--pc-surface-card)', padding: '32px', borderRadius: 'var(--pc-radius-lg)', border: '1px solid var(--pc-border-primary)', maxWidth: '400px', textAlign: 'center', color: 'var(--pc-text-primary)', boxShadow: 'var(--pc-shadow-xl)' }}>
            <h2 data-cy="h2-shared.index-0" style={{ marginTop: 0 }}>Unsaved Changes</h2>
            <p style={{ opacity: 0.8, marginBottom: '24px' }}>You have unsaved changes. Navigating away will discard them. Would you like to stay and save?</p>
            <div style={{ display: 'flex', gap: '16px' }}>
                <button data-cy="guard.unsaved.leave" onClick={onLeave} style={{ flex: 1, padding: '12px', borderRadius: 'var(--pc-radius-md)', border: '1px solid var(--pc-border-secondary)', background: 'transparent', cursor: 'pointer', color: 'var(--pc-text-primary)' }}>Leave</button>
                <button data-cy="guard.unsaved.stay" onClick={onStay} style={{ flex: 1, padding: '12px', borderRadius: 'var(--pc-radius-md)', border: 'none', background: 'var(--pc-primary-dark)', color: 'var(--pc-text-on-primary)', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
            </div>
        </div>
    </div>
);

interface LocationMapPreviewProps {
    lat: number | undefined;
    lng: number | undefined;
    role: string;
}

export const LocationMapPreview: React.FC<LocationMapPreviewProps> = ({ lat, lng, role }) => (
    <div style={{ gridColumn: 'span 2', marginTop: '1rem' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.5rem' }}>
            <label style={{ fontSize: '0.875rem', fontWeight: '500', color: 'var(--pc-text-primary)' }}>Location Verification</label>
            <span style={{ fontSize: '0.75rem', padding: '2px 8px', borderRadius: 'var(--pc-radius-full)', backgroundColor: lat ? 'var(--pc-info-bg)' : 'var(--pc-warning-bg)', color: lat ? 'var(--pc-info)' : 'var(--pc-warning)', fontWeight: 600 }}>
                {lat ? '📍 Coordinate Synced' : '⏳ Pending Sync'}
            </span>
        </div>
        <div style={{ height: '200px', width: '100%', borderRadius: 'var(--pc-radius-md)', overflow: 'hidden', border: '1px solid var(--pc-border-primary)' }}>
            <MapContainer center={[lat || 43.6532, lng || -79.3832]} zoom={13} style={{ height: '100%', width: '100%' }} scrollWheelZoom={false}>
                <TileLayer attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors' url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
                {lat && lng && (<><Marker position={[lat, lng]} /><ChangeView center={[lat, lng]} /></>)}
            </MapContainer>
        </div>
        <p style={{ fontSize: '0.75rem', color: 'var(--pc-text-tertiary)', marginTop: '0.5rem' }}>
            we use this for coordinate verification and secure {role === 'psw' ? 'check-ins' : 'visit security'}.
        </p>
    </div>
);

