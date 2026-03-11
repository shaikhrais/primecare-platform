import React, { useState } from 'react';
import { Users, Filter, Send, Mail, CheckSquare, Square, Tag } from 'lucide-react';

interface Subscriber {
    id: string;
    email: string;
    name: string;
    segment: 'B2B_HOSPITAL' | 'B2C_DEMENTIA_FAMILY' | 'B2C_GENERAL_LEAD' | 'COMMUNITY_PARTNER';
    engagementScore: 'HIGH' | 'MEDIUM' | 'LOW';
    lastOpened: string;
    status: 'SUBSCRIBED' | 'UNSUBSCRIBED' | 'BOUNCED';
}

import { apiClient } from '@/shared/utils/apiClient';

export const NewsletterSubscriberDb: React.FC = () => {
    const [subscribers, setSubscribers] = useState<Subscriber[]>([]);
    const [loading, setLoading] = useState(true);

    React.useEffect(() => {
        const fetchSubscribers = async () => {
            try {
                const res = await apiClient.get('/v1/system/marketing/subscribers');
                if (res.ok) {
                    const data = await res.json();
                    setSubscribers(data);
                }
            } catch (error) {
                console.error("Failed to load subscribers", error);
            } finally {
                setLoading(false);
            }
        };
        fetchSubscribers();
    }, []);

    const [selectedSegment, setSelectedSegment] = useState<string>('ALL');

    const handleSegmentFilter = (segment: string) => {
        setSelectedSegment(segment);
    };

    const getSegmentBadge = (segment: Subscriber['segment']) => {
        switch(segment) {
            case 'B2B_HOSPITAL': return <span style={{ backgroundColor: '#E0F2FE', color: '#0284C7', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 800 }}>B2B Hospital Ref</span>;
            case 'B2C_DEMENTIA_FAMILY': return <span style={{ backgroundColor: '#F3E8FF', color: '#9333EA', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 800 }}>B2C Dementia Family</span>;
            case 'B2C_GENERAL_LEAD': return <span style={{ backgroundColor: '#F1F5F9', color: '#475569', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 800 }}>B2C General Lead</span>;
            case 'COMMUNITY_PARTNER': return <span style={{ backgroundColor: '#FEF9C3', color: '#CA8A04', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 800 }}>Community Partner</span>;
        }
    };

    const filteredSubscribers = selectedSegment === 'ALL' ? subscribers : subscribers.filter(s => s.segment === selectedSegment);
    const activeSubscribers = filteredSubscribers.filter(s => s.status === 'SUBSCRIBED').length;

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F8FAFC', padding: '12px', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                        <Users size={28} color="#475569" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Newsletter Subscriber Database</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Segment audiences to ensure highly relevant, high-converting email newsletter blasts.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <button style={{ backgroundColor: '#0284C7', color: 'white', border: 'none', borderRadius: '8px', padding: '10px 16px', fontWeight: 800, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.95rem' }}>
                        <Mail size={18}/> Draft Campaign to Segment
                    </button>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px' }}>
                {/* Sidebar Filters */}
                <div style={{ flex: '0 0 250px', display: 'flex', flexDirection: 'column', gap: '8px' }}>
                    <div style={{ fontSize: '0.8rem', color: '#64748B', fontWeight: 800, textTransform: 'uppercase', marginBottom: '8px', display: 'flex', alignItems: 'center', gap: '6px' }}><Filter size={14}/> Segment Filters</div>
                    
                    {['ALL', 'B2B_HOSPITAL', 'B2C_DEMENTIA_FAMILY', 'B2C_GENERAL_LEAD', 'COMMUNITY_PARTNER'].map(segment => (
                        <div 
                            key={segment}
                            onClick={() => handleSegmentFilter(segment)}
                            style={{ padding: '12px 16px', borderRadius: '8px', backgroundColor: selectedSegment === segment ? '#EFF6FF' : 'transparent', color: selectedSegment === segment ? '#1D4ED8' : '#475569', fontWeight: selectedSegment === segment ? 800 : 600, cursor: 'pointer', border: `1px solid ${selectedSegment === segment ? '#BFDBFE' : 'transparent'}` }}
                        >
                            {segment.replace(/_/g, ' ')}
                        </div>
                    ))}

                    <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                        <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Available Contacts</div>
                        <div style={{ fontSize: '1.8rem', fontWeight: 900, color: '#0284C7' }}>{activeSubscribers}</div>
                    </div>
                </div>

                {/* Data Table */}
                <div style={{ flex: 1 }}>
                     <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.95rem' }}>
                        <thead>
                            <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                                <th style={{ padding: '12px', width: '40px' }}><Square size={16} color="#94A3B8" /></th>
                                <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Contact Name / Email</th>
                                <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Audience Segment</th>
                                <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>Engagement</th>
                                <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            {loading ? <tr><td colSpan={5} style={{ padding: '24px', textAlign: 'center', color: '#64748B' }}>Loading subscriber database...</td></tr> : filteredSubscribers.map(sub => (
                                <tr key={sub.id} style={{ borderBottom: '1px solid #E2E8F0', opacity: sub.status === 'BOUNCED' ? 0.6 : 1 }}>
                                    <td style={{ padding: '16px 12px', verticalAlign: 'middle' }}><Square size={16} color="#CBD5E1" /></td>
                                    
                                    <td style={{ padding: '16px 12px', verticalAlign: 'middle' }}>
                                        <div style={{ fontWeight: 800, color: '#0F172A', marginBottom: '2px' }}>{sub.name}</div>
                                        <div style={{ fontSize: '0.85rem', color: '#64748B' }}>{sub.email}</div>
                                    </td>
                                    
                                    <td style={{ padding: '16px 12px', verticalAlign: 'middle' }}>
                                        {getSegmentBadge(sub.segment)}
                                    </td>

                                    <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'center' }}>
                                        {sub.engagementScore === 'HIGH' && <span style={{ color: '#16A34A', fontWeight: 700, fontSize: '0.8rem' }}>HIGH (Opened {sub.lastOpened})</span>}
                                        {sub.engagementScore === 'MEDIUM' && <span style={{ color: '#F59E0B', fontWeight: 700, fontSize: '0.8rem' }}>MED (Opened {sub.lastOpened})</span>}
                                        {sub.engagementScore === 'LOW' && <span style={{ color: '#94A3B8', fontWeight: 700, fontSize: '0.8rem' }}>LOW (Opened {sub.lastOpened})</span>}
                                    </td>

                                    <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'right' }}>
                                        {sub.status === 'SUBSCRIBED' && <span style={{ color: '#10B981', fontWeight: 800, fontSize: '0.8rem' }}>ACTIVE</span>}
                                        {sub.status === 'UNSUBSCRIBED' && <span style={{ color: '#DC2626', fontWeight: 800, fontSize: '0.8rem' }}>OPTED OUT</span>}
                                        {sub.status === 'BOUNCED' && <span style={{ color: '#991B1B', fontWeight: 800, fontSize: '0.8rem' }}>HARD BOUNCE</span>}
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>
            
             <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px dashed #CBD5E1', fontSize: '0.85rem', color: '#475569' }}>
                <strong>Segmentation Strategy:</strong> You should never send a B2B "Medical Supply Chain Update" newsletter to a B2C family who is looking for Alzheimers care. This tool forces marketing managers to slice the database into logical segments, ensuring open rates stay high and unsubscribe rates stay low.
            </div>
        </div>
    );
};
