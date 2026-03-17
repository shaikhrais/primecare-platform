import React from 'react';

export interface MapMarker {
    id: string;
    label: string;
    lat: number;
    lng: number;
    icon?: string;
    status?: 'active' | 'warning' | 'danger' | 'inactive';
    detail?: string;
}

interface SectionMapProps {
    markers: MapMarker[];
    title?: string;
    height?: number;
    center?: { lat: number; lng: number };
    zoom?: number;
}

const statusColors: Record<string, string> = {
    active: '#10B981', warning: '#F59E0B', danger: '#EF4444', inactive: '#9CA3AF',
};

/** Registry-driven map section — visual geolocation display with markers.
 *  Pure CSS/SVG implementation (no external map lib). Shows a styled marker board. */
export function SectionMap({ markers, title, height = 360 }: SectionMapProps) {
    // Compute bounds
    const lats = markers.map(m => m.lat);
    const lngs = markers.map(m => m.lng);
    const minLat = Math.min(...lats), maxLat = Math.max(...lats);
    const minLng = Math.min(...lngs), maxLng = Math.max(...lngs);
    const padLat = (maxLat - minLat) * 0.15 || 0.5;
    const padLng = (maxLng - minLng) * 0.15 || 0.5;

    const toX = (lng: number) => ((lng - (minLng - padLng)) / ((maxLng + padLng) - (minLng - padLng))) * 100;
    const toY = (lat: number) => (1 - ((lat - (minLat - padLat)) / ((maxLat + padLat) - (minLat - padLat)))) * 100;

    return (
        <div style={{ marginBottom: '24px' }}>
            {title && <div style={{ fontWeight: 700, marginBottom: '12px', color: 'var(--pc-text-primary)' }}>{title}</div>}
            <div style={{
                position: 'relative', height: `${height}px`, borderRadius: '14px', overflow: 'hidden',
                background: 'linear-gradient(135deg, #e0f2fe 0%, #dbeafe 30%, #ede9fe 60%, #fce7f3 100%)',
                border: '1px solid var(--pc-border-primary, #e5e7eb)',
            }}>
                {/* Grid lines */}
                <svg width="100%" height="100%" style={{ position: 'absolute', top: 0, left: 0, opacity: 0.15 }}>
                    {[20, 40, 60, 80].map(p => (
                        <React.Fragment key={p}>
                            <line x1={`${p}%`} y1="0" x2={`${p}%`} y2="100%" stroke="#64748b" strokeWidth="1" />
                            <line x1="0" y1={`${p}%`} x2="100%" y2={`${p}%`} stroke="#64748b" strokeWidth="1" />
                        </React.Fragment>
                    ))}
                </svg>

                {/* Markers */}
                {markers.map(m => {
                    const x = toX(m.lng);
                    const y = toY(m.lat);
                    const color = statusColors[m.status || 'active'];
                    return (
                        <div key={m.id} title={`${m.label}${m.detail ? ` — ${m.detail}` : ''}`} style={{
                            position: 'absolute', left: `${x}%`, top: `${y}%`,
                            transform: 'translate(-50%, -100%)', zIndex: 2,
                            display: 'flex', flexDirection: 'column', alignItems: 'center',
                            cursor: 'pointer', transition: 'transform 0.2s',
                        }}>
                            <div style={{
                                background: 'white', borderRadius: '8px', padding: '4px 10px',
                                boxShadow: '0 2px 8px rgba(0,0,0,0.15)', marginBottom: '4px',
                                fontSize: '0.7rem', fontWeight: 700, whiteSpace: 'nowrap',
                                border: `2px solid ${color}`, maxWidth: '140px', overflow: 'hidden',
                                textOverflow: 'ellipsis', color: 'var(--pc-text-primary)',
                            }}>
                                {m.icon || '📍'} {m.label}
                            </div>
                            {/* Pin */}
                            <div style={{
                                width: '14px', height: '14px', borderRadius: '50% 50% 50% 0',
                                background: color, transform: 'rotate(-45deg)',
                                boxShadow: `0 2px 6px ${color}66`,
                            }} />
                        </div>
                    );
                })}

                {/* Legend */}
                <div style={{
                    position: 'absolute', bottom: '12px', right: '12px',
                    background: 'rgba(255,255,255,0.92)', borderRadius: '8px',
                    padding: '8px 12px', fontSize: '0.65rem', display: 'flex', gap: '10px',
                    boxShadow: '0 1px 4px rgba(0,0,0,0.1)',
                }}>
                    {Object.entries(statusColors).map(([s, c]) => (
                        <span key={s} style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
                            <span style={{ width: '8px', height: '8px', borderRadius: '50%', background: c }} />
                            {s}
                        </span>
                    ))}
                    <span style={{ color: '#94a3b8' }}>({markers.length} pins)</span>
                </div>
            </div>
        </div>
    );
}
