import React, { useState } from 'react';
import { MessageCircleWarning, ThumbsUp, ThumbsDown, AlertTriangle, ShieldAlert } from 'lucide-react';

interface Review {
    id: string;
    source: 'Google' | 'Yelp' | 'Facebook';
    reviewerName: string;
    rating: number;
    content: string;
    sentimentScore: number; // 0 (toxic) to 100 (glowing)
    flaggedKeywords: string[];
    status: 'NEEDS_ATTENTION' | 'RESPONDED' | 'NO_ACTION_NEEDED';
}

export const ReviewSentimentAnalyzer: React.FC = () => {
    const [reviews, setReviews] = useState<Review[]>([
        { id: 'rev_1', source: 'Google', reviewerName: 'John Davis', rating: 5, content: 'Absolutely wonderful care for my mother. The nurses are so compassionate.', sentimentScore: 95, flaggedKeywords: [], status: 'NO_ACTION_NEEDED' },
        { id: 'rev_2', source: 'Yelp', reviewerName: 'Samantha W.', rating: 2, content: 'The caregiver was 30 minutes late on Tuesday. Unacceptable when dealing with medications.', sentimentScore: 15, flaggedKeywords: ['late', 'unacceptable'], status: 'NEEDS_ATTENTION' },
        { id: 'rev_3', source: 'Facebook', reviewerName: 'Robert L.', rating: 1, content: 'Billing department is extremely rude and overcharged me twice!', sentimentScore: 5, flaggedKeywords: ['rude', 'overcharged', 'billing'], status: 'NEEDS_ATTENTION' }
    ]);

    const handleAcknowledge = (id: string, e: React.MouseEvent) => {
        e.stopPropagation();
        setReviews(reviews.map(r => 
            r.id === id ? { ...r, status: 'RESPONDED' } : r
        ));
    };

    const getSourceColor = (source: string) => {
        switch(source) {
            case 'Google': return { bg: '#E8F0FE', color: '#1A73E8' };
            case 'Yelp': return { bg: '#FCE8E6', color: '#D93025' };
            case 'Facebook': return { bg: '#E8F4F8', color: '#1877F2' };
            default: return { bg: '#F1F5F9', color: '#64748B' };
        }
    };

    const averageSentiment = (reviews.reduce((sum, r) => sum + r.sentimentScore, 0) / reviews.length).toFixed(0);
    const criticalReviews = reviews.filter(r => r.status === 'NEEDS_ATTENTION').length;

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#FEF2F2', padding: '12px', borderRadius: '8px' }}>
                        <MessageCircleWarning size={28} color="#DC2626" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Public Sentiment Analyzer</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>NLP-driven dashboard flagging negative reviews containing toxic keywords for immediate damage control.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '16px' }}>
                    <div style={{ padding: '8px 16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', textAlign: 'center' }}>
                        <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Avg NLP Sentiment</div>
                        <div style={{ fontSize: '1.4rem', fontWeight: 900, color: Number(averageSentiment) > 70 ? '#10B981' : '#F59E0B' }}>{averageSentiment}/100</div>
                    </div>
                     <div style={{ padding: '8px 16px', backgroundColor: '#FEF2F2', borderRadius: '8px', border: '1px solid #FECACA', textAlign: 'center' }}>
                        <div style={{ fontSize: '0.75rem', color: '#991B1B', fontWeight: 700, textTransform: 'uppercase' }}>Critical Alerts</div>
                        <div style={{ fontSize: '1.4rem', fontWeight: 900, color: '#DC2626' }}>{criticalReviews}</div>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                {reviews.map(review => {
                    const srcStyle = getSourceColor(review.source);
                    const isToxic = review.sentimentScore < 40;

                    return (
                        <div key={review.id} style={{ display: 'flex', alignItems: 'flex-start', gap: '16px', padding: '20px', border: '1px solid #E2E8F0', borderRadius: '12px', backgroundColor: review.status === 'NEEDS_ATTENTION' ? '#FEF2F2' : 'white' }}>
                            <div style={{ width: '80px', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '8px' }}>
                                <div style={{ backgroundColor: srcStyle.bg, color: srcStyle.color, padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 800 }}>
                                    {review.source}
                                </div>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '2px', color: '#F59E0B' }}>
                                    <span style={{ fontWeight: 900, fontSize: '1.2rem', color: '#0F172A' }}>{review.rating}</span><Star fill="#F59E0B" size={14}/>
                                </div>
                            </div>

                            <div style={{ flex: 1, paddingLeft: '16px', borderLeft: '1px solid #E2E8F0' }}>
                                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '8px' }}>
                                    <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '1.05rem' }}>{review.reviewerName}</div>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '6px', fontSize: '0.8rem', fontWeight: 700, color: isToxic ? '#DC2626' : '#10B981' }}>
                                        {isToxic ? <ThumbsDown size={14} /> : <ThumbsUp size={14} />}
                                        Score: {review.sentimentScore}
                                    </div>
                                </div>

                                <div style={{ color: '#334155', fontSize: '0.95rem', lineHeight: 1.5, marginBottom: '12px' }}>
                                    "{review.content}"
                                </div>

                                {review.flaggedKeywords.length > 0 && (
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', flexWrap: 'wrap' }}>
                                        <span style={{ fontSize: '0.75rem', color: '#DC2626', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '4px' }}>
                                            <AlertTriangle size={12}/> FLAGGED KEYWORDS:
                                        </span>
                                        {review.flaggedKeywords.map(kw => (
                                            <span key={kw} style={{ backgroundColor: '#FEE2E2', color: '#991B1B', padding: '2px 8px', borderRadius: '12px', fontSize: '0.75rem', fontWeight: 700 }}>
                                                "{kw}"
                                            </span>
                                        ))}
                                    </div>
                                )}
                            </div>

                            <div style={{ width: '160px', paddingLeft: '16px', display: 'flex', flexDirection: 'column', justifyContent: 'center' }}>
                                {review.status === 'NEEDS_ATTENTION' ? (
                                    <button 
                                        onClick={(e) => handleAcknowledge(review.id, e)}
                                        style={{ backgroundColor: '#DC2626', color: 'white', border: 'none', borderRadius: '6px', padding: '10px 16px', fontWeight: 700, cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '6px', fontSize: '0.85rem', boxShadow: '0 2px 4px rgba(220, 38, 38, 0.2)' }}
                                    >
                                        <ShieldAlert size={16} /> Draft Response
                                    </button>
                                ) : (
                                    <div style={{ backgroundColor: '#F8FAFC', color: '#64748B', border: '1px solid #E2E8F0', borderRadius: '6px', padding: '10px 16px', fontWeight: 700, textAlign: 'center', fontSize: '0.85rem' }}>
                                        {review.status === 'RESPONDED' ? 'Resolved' : 'Ignored (Positive)'}
                                    </div>
                                )}
                            </div>
                        </div>
                    );
                })}
            </div>
        </div>
    );
};
