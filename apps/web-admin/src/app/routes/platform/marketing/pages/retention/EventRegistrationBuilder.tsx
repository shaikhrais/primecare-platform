import React, { useState } from 'react';
import { Calendar, MapPin, Users, Copy, CheckCircle2, QrCode, Globe } from 'lucide-react';

export const EventRegistrationBuilder: React.FC = () => {
    const [eventName, setEventName] = useState('Senior Care Planning & Bingo Night');
    const [eventDate, setEventDate] = useState('2023-11-15T18:00');
    const [location, setLocation] = useState('Springfield Community Center');
    const [capacity, setCapacity] = useState('150');
    const [description, setDescription] = useState('Join PrimeCare for an evening of Bingo, free refreshments, and a 15-minute presentation on navigating Medicare post-hospitalization.');
    
    const [copied, setCopied] = useState(false);

    const handleCopy = () => {
        setCopied(true);
        setTimeout(() => setCopied(false), 2000);
    };

    const previewUrl = `https://primecare.org/events/${eventName.toLowerCase().replace(/[^a-z0-9]+/g, '-')}`;

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F0FDF4', padding: '12px', borderRadius: '8px', border: '1px solid #BBF7D0' }}>
                        <Calendar size={28} color="#16A34A" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Community Event Landing Page Builder</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Instantly launch RSVP pages for local events without waiting 3 weeks for an IT support ticket.</p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '32px' }}>
                {/* Form Column */}
                <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    
                    <div>
                        <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '6px' }}>Event Name</label>
                        <input 
                            type="text" 
                            value={eventName}
                            onChange={(e) => setEventName(e.target.value)}
                            style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', boxSizing: 'border-box' }}
                        />
                    </div>

                    <div style={{ display: 'flex', gap: '16px' }}>
                        <div style={{ flex: 1 }}>
                            <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '6px' }}>Date & Time</label>
                            <input 
                                type="datetime-local" 
                                value={eventDate}
                                onChange={(e) => setEventDate(e.target.value)}
                                style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', boxSizing: 'border-box' }}
                            />
                        </div>
                        <div style={{ flex: 1 }}>
                            <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '6px' }}>Max Capacity (Cutoff)</label>
                            <input 
                                type="number" 
                                value={capacity}
                                onChange={(e) => setCapacity(e.target.value)}
                                style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', boxSizing: 'border-box' }}
                            />
                        </div>
                    </div>

                    <div>
                        <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '6px' }}>Location / Venue</label>
                        <input 
                            type="text" 
                            value={location}
                            onChange={(e) => setLocation(e.target.value)}
                            style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', boxSizing: 'border-box' }}
                        />
                    </div>
                    
                    <div>
                        <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '6px' }}>Value Proposition (Why should families attend?)</label>
                        <textarea 
                            value={description}
                            onChange={(e) => setDescription(e.target.value)}
                            style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', resize: 'vertical', minHeight: '100px', fontSize: '0.95rem', boxSizing: 'border-box' }}
                        />
                    </div>

                    <button style={{ padding: '16px', backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '8px', fontSize: '1.05rem', fontWeight: 800, cursor: 'pointer', display: 'flex', justifyContent: 'center', alignItems: 'center', gap: '8px', marginTop: '8px' }}>
                        <Globe size={20} /> PUBLISH LANDING PAGE TO LIVE SITE
                    </button>
                </div>

                {/* Output Assets Column */}
                <div style={{ flex: '0 0 350px', backgroundColor: '#F8FAFC', borderRadius: '12px', padding: '24px', border: '1px solid #E2E8F0', display: 'flex', flexDirection: 'column', gap: '20px' }}>
                     
                    <div>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '8px', color: '#64748B', fontWeight: 700, textTransform: 'uppercase', fontSize: '0.8rem' }}>
                            <Globe size={14} /> Public RSVP Link
                        </div>
                        <div style={{ backgroundColor: 'white', border: '1px dashed #CBD5E1', borderRadius: '8px', padding: '12px', color: '#0F172A', wordBreak: 'break-all', fontFamily: 'monospace', fontSize: '0.9rem', marginBottom: '8px' }}>
                            {previewUrl}
                        </div>
                        <button 
                            onClick={handleCopy}
                            style={{ width: '100%', padding: '10px', backgroundColor: copied ? '#10B981' : '#E2E8F0', color: copied ? 'white' : '#334155', border: 'none', borderRadius: '6px', fontSize: '0.9rem', fontWeight: 800, cursor: 'pointer', display: 'flex', justifyContent: 'center', alignItems: 'center', gap: '6px', transition: 'all 0.2s' }}
                        >
                            {copied ? <><CheckCircle2 size={16} /> Copied</> : <><Copy size={16} /> Copy URL</>}
                        </button>
                    </div>

                    <hr style={{ borderTop: '1px dashed #CBD5E1', margin: '4px 0' }} />

                    <div>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '12px', color: '#64748B', fontWeight: 700, textTransform: 'uppercase', fontSize: '0.8rem' }}>
                            <QrCode size={14} /> Print Flyer QR Code
                        </div>
                        <div style={{ backgroundColor: 'white', border: '2px solid #E2E8F0', borderRadius: '8px', padding: '24px', display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: '150px' }}>
                            <QrCode size={100} color="#0F172A" />
                        </div>
                        <p style={{ margin: '8px 0 0 0', fontSize: '0.75rem', color: '#64748B', textAlign: 'center' }}>Download this code and paste it onto printed B2B sales brochures.</p>
                    </div>

                </div>
            </div>
        </div>
    );
};
