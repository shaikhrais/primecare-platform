import React, { useState, useEffect, useRef } from 'react';
import { Camera, Heart, Stethoscope, Clock } from 'lucide-react';

import { apiClient } from '@/shared/utils/apiClient';

interface FeedItem {
    id: string;
    type: 'note' | 'photo' | 'vitals';
    authorName: string;
    authorRole: string;
    timestamp: string;
    content: string;
    imageUrl?: string;
    vitals?: { bp: string, hr: string, temp: string };
}

export const CareUpdatesFeed: React.FC = () => {
    const [posts, setPosts] = useState<FeedItem[]>([]);
    const [isLoading, setIsLoading] = useState(true);
    const bottomRef = useRef<HTMLDivElement>(null);

    useEffect(() => {
        const fetchFeed = async () => {
            try {
                // Hardcoding demo client ID for testing
                const response: any = await apiClient.get('/v1/client/family/feed/demo-client-1');

                // Map real db entries to FeedItems
                const mappedEntries: FeedItem[] = response.recentEntries?.map((entry: any) => ({
                    id: entry.id,
                    type: 'note', 
                    authorName: 'PrimeCare Staff', // Await relation joins to get actual worker names
                    authorRole: 'PSW / RN', 
                    timestamp: new Date().toLocaleDateString(), // timestamp structure to UI
                    content: entry.activities || 'Routine care visit completed.',
                })) || [];

                setPosts(mappedEntries);
            } catch (error) {
                console.error('Failed to fetch family feed:', error);
            } finally {
                setIsLoading(false);
            }
        };

        fetchFeed();
    }, []);

    return (
        <section style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '16px', padding: '24px', display: 'flex', flexDirection: 'column', gap: '24px', maxHeight: '800px', overflowY: 'auto' }}>
            <h2 style={{ fontSize: '1.5rem', fontWeight: 900, color: '#0F172A', margin: 0, position: 'sticky', top: '-24px', backgroundColor: 'rgba(255,255,255,0.9)', backdropFilter: 'blur(8px)', padding: '24px 0', borderBottom: '1px solid #F1F5F9', zIndex: 10 }}>Care Feed</h2>
            
            {posts.map(post => (
                <article key={post.id} style={{ borderBottom: '1px solid #F1F5F9', paddingBottom: '24px', display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    
                    {/* Header */}
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                            <div style={{ width: '40px', height: '40px', borderRadius: '50%', backgroundColor: '#E0E7FF', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#4F46E5', fontWeight: 800 }}>
                                {post.authorName.charAt(0)}
                            </div>
                            <div>
                                <div style={{ fontWeight: 800, color: '#0F172A' }}>{post.authorName}</div>
                                <div style={{ fontSize: '0.85rem', color: '#64748B' }}>{post.authorRole}</div>
                            </div>
                        </div>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '6px', fontSize: '0.85rem', color: '#94A3B8' }}>
                            <Clock size={14} /> {post.timestamp}
                        </div>
                    </div>

                    {/* Rich Content Area */}
                    {post.type === 'photo' && post.imageUrl && (
                        <div style={{ borderRadius: '12px', overflow: 'hidden', border: '1px solid #E2E8F0' }}>
                           <img src={post.imageUrl} alt="Care update" style={{ width: '100%', height: 'auto', display: 'block' }} loading="lazy" /> 
                        </div>
                    )}

                    {post.type === 'vitals' && post.vitals && (
                        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '12px', backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '12px', border: '1px dashed #CBD5E1' }}>
                            <div>
                                <div style={{ fontSize: '0.75rem', fontWeight: 800, color: '#64748B', textTransform: 'uppercase' }}>Blood Pressure</div>
                                <div style={{ fontSize: '1.25rem', fontWeight: 900, color: '#EF4444' }}>{post.vitals.bp}</div>
                            </div>
                            <div>
                                <div style={{ fontSize: '0.75rem', fontWeight: 800, color: '#64748B', textTransform: 'uppercase' }}>Heart Rate</div>
                                <div style={{ fontSize: '1.25rem', fontWeight: 900, color: '#F59E0B' }}>{post.vitals.hr}</div>
                            </div>
                            <div>
                                <div style={{ fontSize: '0.75rem', fontWeight: 800, color: '#64748B', textTransform: 'uppercase' }}>Temperature</div>
                                <div style={{ fontSize: '1.25rem', fontWeight: 900, color: '#10B981' }}>{post.vitals.temp}</div>
                            </div>
                        </div>
                    )}

                    {/* Text Content */}
                    <div style={{ color: '#334155', lineHeight: '1.6', fontSize: '1rem' }}>
                        {post.content}
                    </div>

                    {/* Action Bar ( social engagement) */}
                    <div style={{ display: 'flex', gap: '16px', color: '#94A3B8' }}>
                        <button style={{ background: 'none', border: 'none', display: 'flex', alignItems: 'center', gap: '6px', cursor: 'pointer', color: 'inherit', fontWeight: 700 }} title="Acknowledge">
                            <Heart size={18} /> Acknowledge
                        </button>
                    </div>

                </article>
            ))}

            {/* Intersection Target */}
            <div ref={bottomRef} style={{ height: '50px', display: 'flex', justifyContent: 'center', alignItems: 'center', color: '#94A3B8' }}>
                {isLoading ? 'Loading older updates...' : 'You caught up!'}
            </div>
        </section>
    );
};
