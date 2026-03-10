import React, { useState, useEffect, useRef } from 'react';
import { Camera, Heart, Stethoscope, Clock } from 'lucide-react';

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

const MOCK_FEED: FeedItem[] = [
    {
        id: '1',
        type: 'photo',
        authorName: 'Sarah Jenkins',
        authorRole: 'RN',
        timestamp: '10 mins ago',
        content: 'John was in great spirits today! We went for a short walk in the garden after lunch.',
        imageUrl: 'https://images.unsplash.com/photo-1516302752625-fcc3c50ae61f?q=80&w=800&auto=format&fit=crop'
    },
    {
        id: '2',
        type: 'vitals',
        authorName: 'System Logger',
        authorRole: 'Device Sync',
        timestamp: '15 mins ago',
        content: 'End of visit vitals recorded.',
        vitals: { bp: '120/80', hr: '72 bpm', temp: '98.6 °F' }
    },
    {
        id: '3',
        type: 'note',
        authorName: 'Sarah Jenkins',
        authorRole: 'RN',
        timestamp: '2 hours ago',
        content: 'Administered afternoon medications. John complained of mild joint pain, applying heat pad.'
    }
];

export const CareUpdatesFeed: React.FC = () => {
    const [posts, setPosts] = useState<FeedItem[]>(MOCK_FEED);
    const [isLoading, setIsLoading] = useState(false);
    const bottomRef = useRef<HTMLDivElement>(null);

    // Mocking an IntersectionObserver for infinite scrolling
    useEffect(() => {
        const observer = new IntersectionObserver((entries) => {
            if (entries[0].isIntersecting && !isLoading) {
                // Simulate fetching older posts
                setIsLoading(true);
                setTimeout(() => {
                    const olderPost: FeedItem = {
                        id: `old-${Date.now()}`,
                        type: 'note',
                        authorName: 'Mark D.',
                        authorRole: 'PSW',
                        timestamp: 'Yesterday at 4:30 PM',
                        content: 'Finished meal prep for the week. Kitchen is cleaned and locked up.'
                    };
                    setPosts(prev => [...prev, olderPost]);
                    setIsLoading(false);
                }, 1500);
            }
        });

        if (bottomRef.current) {
            observer.observe(bottomRef.current);
        }

        return () => observer.disconnect();
    }, [isLoading]);

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

                    {/* Action Bar (Mocking social engagement) */}
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
