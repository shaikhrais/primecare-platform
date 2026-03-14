// Profile page: API handlers and leaflet setup extracted
import L from 'leaflet';
import markerIcon from 'leaflet/dist/images/marker-icon.png';
import markerShadow from 'leaflet/dist/images/marker-shadow.png';
import { useMap } from 'react-leaflet';

// Fix for default marker icon in Leaflet + Vite
let DefaultIcon = L.icon({ iconUrl: markerIcon, shadowUrl: markerShadow, iconSize: [25, 41], iconAnchor: [12, 41] });
L.Marker.prototype.options.icon = DefaultIcon;

const API_URL = import.meta.env.VITE_API_URL;

// Helper to update map center
export function ChangeView({ center }: { center: [number, number] }) {
    const map = useMap();
    map.setView(center);
    return null;
}

export async function fetchProfile(
    role: string,
    onSuccess: (data: any) => void,
    onFallback: (user: any) => void,
    onError: (msg: string) => void
): Promise<void> {
    try {
        const token = localStorage.getItem('token');
        const endpoint = role === 'psw' ? '/v1/psw/profile' : role === 'admin' || role === 'staff' ? '/v1/user/profile' : '/v1/client/profile';
        const response = await fetch(`${API_URL}${endpoint}`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (response.ok) {
            const data = await response.json();
            onSuccess(data);
        } else if (response.status === 403 || response.status === 404) {
            const user = JSON.parse(localStorage.getItem('user') || '{}');
            onFallback({ ...user, fullName: user.fullName || user.email?.split('@')[0] });
        }
    } catch (error) {
        console.error('Failed to fetch profile', error);
        onError('Failed to load profile data');
    }
}

export async function saveProfile(
    role: string,
    profile: any,
    onSuccess: () => void,
    onError: () => void,
): Promise<void> {
    try {
        const token = localStorage.getItem('token');
        const endpoint = role === 'psw' ? '/v1/psw/profile' : '/v1/client/profile';
        const response = await fetch(`${API_URL}${endpoint}`, {
            method: 'PUT',
            headers: { 'Authorization': `Bearer ${token}`, 'Content-Type': 'application/json' },
            body: JSON.stringify(profile)
        });
        if (response.ok) onSuccess();
    } catch (error) { onError(); }
}
