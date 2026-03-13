import React, { useState } from 'react';
import { ThumbsUp, ThumbsDown } from 'lucide-react';
import { useNotification } from '@/shared/context/NotificationContext';

export const PostVisitRatingModal: React.FC = () => {
    const { showToast } = useNotification();
    const [isOpen, setIsOpen] = useState(true);

    if (!isOpen) return null;

    const handleRate = (positive: boolean) => {
        setIsOpen(false);
        showToast(
            positive 
            ? 'Thank you! We will let your nurse know you had a great visit.' 
            : 'Thank you for the feedback. A care coordinator will reach out to you shortly.', 
            positive ? 'success' : 'info'
        );
    };

    return (
        <div style={{
            position: 'fixed', inset: 0,
            backgroundColor: 'rgba(15, 23, 42, 0.9)', // Very dark slate for intense contrast
            backdropFilter: 'blur(8px)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            zIndex: 99999, // Absolute top
            padding: '24px'
        }} data-cy="modal-post-visit-rating">
            <div style={{ 
                backgroundColor: 'white', 
                borderRadius: '24px', // Softer radii for seniors
                padding: '48px 32px', 
                maxWidth: '600px', 
                width: '100%', 
                boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.7)', 
                textAlign: 'center',
                animation: 'slide-up 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275)' 
            }}>
                <h2 data-cy="h2-shared.post-visit-rating-modal-0" style={{ fontSize: '2.5rem', fontWeight: 900, color: '#0F172A', margin: '0 0 16px 0', lineHeight: 1.2 }}>
                    How was your visit with <span style={{ color: '#3B82F6' }}>Sarah</span> today?
                </h2>
                
                <p style={{ fontSize: '1.5rem', color: '#475569', marginBottom: '48px' }}>
                    Tap one of the buttons below.
                </p>

                <div style={{ display: 'flex', gap: '24px', justifyContent: 'center' }}>
                    {/* Massive Hit Areas (> 120px) */}
                    <button 
                        data-cy="rating.btn-good"
                        onClick={() => handleRate(true)}
                        style={{ 
                            flex: 1, 
                            backgroundColor: '#F0FDF4', 
                            border: '4px solid #22C55E', 
                            borderRadius: '32px', 
                            padding: '48px 24px', 
                            cursor: 'pointer',
                            display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '16px',
                            transition: 'transform 0.1s ease',
                            boxShadow: '0 10px 15px -3px rgba(34, 197, 94, 0.3)'
                        }}
                        onMouseDown={e => e.currentTarget.style.transform = 'scale(0.95)'}
                        onMouseUp={e => e.currentTarget.style.transform = 'scale(1)'}
                    >
                        <ThumbsUp size={80} color="#22C55E" />
                        <span style={{ fontSize: '2rem', fontWeight: 900, color: '#15803D' }}>Good</span>
                    </button>

                    <button 
                         data-cy="rating.btn-bad"
                         onClick={() => handleRate(false)}
                         style={{ 
                             flex: 1, 
                             backgroundColor: '#FEF2F2', 
                             border: '4px solid #EF4444', 
                             borderRadius: '32px', 
                             padding: '48px 24px', 
                             cursor: 'pointer',
                             display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '16px',
                             transition: 'transform 0.1s ease',
                             boxShadow: '0 10px 15px -3px rgba(239, 68, 68, 0.3)'
                         }}
                         onMouseDown={e => e.currentTarget.style.transform = 'scale(0.95)'}
                         onMouseUp={e => e.currentTarget.style.transform = 'scale(1)'}
                    >
                        <ThumbsDown size={80} color="#EF4444" />
                        <span style={{ fontSize: '2rem', fontWeight: 900, color: '#B91C1C' }}>Bad</span>
                    </button>
                </div>
            </div>

            <style>{`
                @keyframes slide-up {
                    0% { transform: translateY(100px); opacity: 0; }
                    100% { transform: translateY(0); opacity: 1; }
                }
            `}</style>
        </div>
    );
};
