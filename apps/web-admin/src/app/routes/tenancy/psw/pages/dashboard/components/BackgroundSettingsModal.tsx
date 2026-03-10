import React, { useState } from 'react';
import { Settings, DownloadCloud, Navigation, ArrowRightLeft, RadioReceiver } from 'lucide-react';
import { useNotification } from '@/shared/context/NotificationContext';

export const BackgroundSettingsModal: React.FC<{ onClose: () => void }> = ({ onClose }) => {
    const { showToast } = useNotification();
    const [prefetch, setPrefetch] = useState(true);
    const [bgLocation, setBgLocation] = useState(false);
    const [smsFallback, setSmsFallback] = useState(true);

    return (
        <div style={{ position: 'fixed', inset: 0, zIndex: 9999, display: 'flex', alignItems: 'center', justifyContent: 'center', backgroundColor: 'rgba(0,0,0,0.6)' }}>
            <div style={{ backgroundColor: '#fff', borderRadius: '16px', width: '100%', maxWidth: '400px', padding: '24px' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                    <h2 style={{ margin: 0, fontSize: '1.25rem', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <Settings size={20} /> App Settings
                    </h2>
                    <button onClick={onClose} style={{ border: 'none', background: 'none', fontSize: '1.5rem', cursor: 'pointer', color: '#6B7280' }}>×</button>
                </div>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>

                    {/* Suggestion 14: Pre-fetching */}
                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                        <div style={{ flex: 1 }}>
                            <div style={{ fontWeight: 700, display: 'flex', alignItems: 'center', gap: '6px' }}>
                                <DownloadCloud size={16} color="#3B82F6" /> Pre-Fetch Itineraries
                            </div>
                            <div style={{ fontSize: '0.85rem', color: '#6B7280', marginTop: '4px' }}>Download the next 48 hours of Care Plans overnight while on Wi-Fi.</div>
                        </div>
                        <label style={{ display: 'flex', alignItems: 'center', cursor: 'pointer' }}>
                            <input type="checkbox" checked={prefetch} onChange={(e) => { setPrefetch(e.target.checked); showToast('Pre-Fetch setting updated', 'success'); }} style={{ width: '20px', height: '20px', cursor: 'pointer' }} />
                        </label>
                    </div>

                    {/* Suggestion 16: Background Geolocation */}
                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                        <div style={{ flex: 1 }}>
                            <div style={{ fontWeight: 700, display: 'flex', alignItems: 'center', gap: '6px' }}>
                                <Navigation size={16} color="#10B981" /> Background GPS (EVV)
                            </div>
                            <div style={{ fontSize: '0.85rem', color: '#6B7280', marginTop: '4px' }}>Allow location tracking to warm up EVV coordinates before you press check-in.</div>
                        </div>
                        <label style={{ display: 'flex', alignItems: 'center', cursor: 'pointer' }}>
                            <input type="checkbox" checked={bgLocation} onChange={(e) => { setBgLocation(e.target.checked); showToast('Background GPS active', 'success'); }} style={{ width: '20px', height: '20px', cursor: 'pointer' }} />
                        </label>
                    </div>

                    {/* Suggestion 20: SMS Fallback */}
                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                        <div style={{ flex: 1 }}>
                            <div style={{ fontWeight: 700, display: 'flex', alignItems: 'center', gap: '6px' }}>
                                <RadioReceiver size={16} color="#8B5CF6" /> SMS Check-In Fallback
                            </div>
                            <div style={{ fontSize: '0.85rem', color: '#6B7280', marginTop: '4px' }}>If internet is completely dead, send EVV check-ins via hidden SMS.</div>
                        </div>
                        <label style={{ display: 'flex', alignItems: 'center', cursor: 'pointer' }}>
                            <input type="checkbox" checked={smsFallback} onChange={(e) => { setSmsFallback(e.target.checked); showToast('SMS Fallback enabled', 'success'); }} style={{ width: '20px', height: '20px', cursor: 'pointer' }} />
                        </label>
                    </div>

                </div>

                <div style={{ marginTop: '32px' }}>
                    <button onClick={onClose} style={{ width: '100%', padding: '12px', backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '8px', cursor: 'pointer', fontWeight: 700 }}>
                        Save & Close
                    </button>
                </div>
            </div>
        </div>
    );
};
