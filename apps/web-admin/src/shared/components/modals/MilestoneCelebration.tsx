import React, { useState, useEffect } from 'react';
import { Award, X } from 'lucide-react';

export const MilestoneCelebration: React.FC = () => {
    // In a real application, this would listen to a global event/context (e.g., useNotification)
    // For demonstration, we'll auto-trigger it after a short delay on the Family Home
    const [isOpen, setIsOpen] = useState(false);

    useEffect(() => {
        const timer = setTimeout(() => {
            setIsOpen(true);
        }, 3000);
        return () => clearTimeout(timer);
    }, []);

    if (!isOpen) return null;

    return (
        <div style={{
            position: 'fixed', inset: 0,
            zIndex: 99999, // Absolute highest z-index
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            pointerEvents: 'none' // Let clicks pass through the confetti overlay background
        }}>
            
            {/* Pure CSS Confetti Implementation (To avoid forcing a heavy Canvas/react-confetti install) */}
            <div className="confetti-container" style={{ position: 'absolute', inset: 0, overflow: 'hidden' }}>
                {[...Array(50)].map((_, i) => (
                    <div key={i} className={`confetti piece-${i}`}></div>
                ))}
            </div>

            {/* Modal Card */}
            <div style={{ 
                backgroundColor: 'white', 
                borderRadius: '24px', 
                padding: '48px', 
                textAlign: 'center', 
                maxWidth: '500px',
                boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.5)',
                position: 'relative',
                pointerEvents: 'auto', // Re-enable pointer events for the modal itself
                animation: 'bounce-in 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55)'
            }}>
                
                <button data-cy="btn-shared.milestone-celebration-0" onClick={() => setIsOpen(false)} style={{ position: 'absolute', top: '16px', right: '16px', background: 'none', border: 'none', cursor: 'pointer', color: '#94A3B8' }}>
                    <X size={24} />
                </button>

                <div style={{ backgroundColor: '#FEF3C7', width: '100px', height: '100px', borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center', margin: '0 auto 24px auto', border: '4px solid #F59E0B' }}>
                    <Award size={48} color="#D97706" />
                </div>
                
                <h2 data-cy="h2-shared.milestone-celebration-0" style={{ fontSize: '2.5rem', fontWeight: 900, color: '#0F172A', margin: '0 0 16px 0', lineHeight: 1.1 }}>
                    Care Goal Reached!
                </h2>
                
                <p style={{ fontSize: '1.25rem', color: '#475569', margin: '0 0 32px 0', lineHeight: '1.6' }}>
                    <strong style={{ color: '#0F172A' }}>John</strong> has officially graduated from Physical Therapy! No further assisted mobility sessions are required.
                </p>

                <button data-cy="btn-shared.milestone-celebration-1" onClick={() => setIsOpen(false)} style={{ backgroundColor: '#10B981', color: 'white', border: 'none', borderRadius: '12px', padding: '16px 32px', fontSize: '1.25rem', fontWeight: 800, cursor: 'pointer', width: '100%', boxShadow: '0 4px 6px -1px rgba(16, 185, 129, 0.4)' }}>
                    AWESOME!
                </button>
            </div>

            <style>{`
                @keyframes bounce-in {
                    0% { transform: scale(0.5); opacity: 0; }
                    80% { transform: scale(1.05); opacity: 1; }
                    100% { transform: scale(1); opacity: 1; }
                }

                .confetti {
                    position: absolute;
                    width: 10px;
                    height: 20px;
                    background-color: #F87171;
                    opacity: 0;
                    top: -20px;
                }

                ${[...Array(50)].map((_, i) => {
                    const left = Math.random() * 100;
                    const duration = Math.random() * 3 + 2;
                    const delay = Math.random() * 2;
                    const color = ['#F87171', '#60A5FA', '#34D399', '#FBBF24', '#A78BFA'][Math.floor(Math.random() * 5)];
                    return `
                        .piece-${i} {
                            left: ${left}%;
                            background-color: ${color};
                            animation: fall ${duration}s ${delay}s linear forwards;
                        }
                    `;
                }).join('')}

                @keyframes fall {
                    0% { transform: translateY(-20px) rotate(0deg); opacity: 1; }
                    100% { transform: translateY(100vh) rotate(720deg); opacity: 0; }
                }
            `}</style>
        </div>
    );
};
