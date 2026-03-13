import React, { useState, useEffect } from 'react';
import { Award, X } from 'lucide-react';
// import Confetti from 'react-confetti'; // Assumed dependency

export const MilestoneCelebrator: React.FC = () => {
    const [isVisible, setIsVisible] = useState(false);
    const [windowDimension, setWindowDimension] = useState({ width: window.innerWidth, height: window.innerHeight });

    useEffect(() => {
        // Check user's hire date against today's date
        const isAnniversary = true; // Would be: (new Date(user.hireDate).getMonth() === new Date().getMonth() && new Date().getDay() === new Date().getDay())

        if (isAnniversary) {
            // Slight delay so the dashboard loads first
            const timer = setTimeout(() => setIsVisible(true), 1500);
            return () => clearTimeout(timer);
        }

        const detectSize = () => {
            setWindowDimension({ width: window.innerWidth, height: window.innerHeight });
        };
        window.addEventListener('resize', detectSize);
        return () => window.removeEventListener('resize', detectSize);
    }, []);

    if (!isVisible) return null;

    return (
        <div style={{
            position: 'fixed',
            top: 0, left: 0, right: 0, bottom: 0,
            backgroundColor: 'rgba(15, 23, 42, 0.8)',
            zIndex: 9999,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center'
        }}>
            {/* 
              <Confetti 
                  width={windowDimension.width} 
                  height={windowDimension.height} 
                  recycle={false} 
                  numberOfPieces={500} 
                  gravity={0.15}
              /> 
            */}

            <div style={{
                backgroundColor: 'white',
                borderRadius: '16px',
                padding: '40px',
                width: '90%',
                maxWidth: '450px',
                textAlign: 'center',
                position: 'relative',
                boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.25)',
                animation: 'slideUp 0.5s cubic-bezier(0.16, 1, 0.3, 1)'
            }}>
                <button data-cy="btn-rn.milestone-celebrator-0" 
                    onClick={() => setIsVisible(false)}
                    style={{ position: 'absolute', top: '16px', right: '16px', background: 'none', border: 'none', cursor: 'pointer', color: '#94A3B8' }}
                >
                    <X size={24} />
                </button>

                <div style={{ 
                    backgroundColor: '#FEF3C7', 
                    width: '80px', height: '80px', 
                    borderRadius: '50%', 
                    display: 'flex', alignItems: 'center', justifyContent: 'center',
                    margin: '0 auto 20px auto',
                    boxShadow: '0 0 0 8px #FFFBEB'
                }}>
                    <Award size={40} color="#D97706" />
                </div>

                <h2 data-cy="h2-rn.milestone-celebrator-0" style={{ margin: '0 0 8px 0', color: '#0F172A', fontSize: '1.8rem', fontWeight: 900 }}>Happy Work Anniversary!</h2>
                
                <p style={{ margin: 0, color: '#475569', fontSize: '1rem', lineHeight: '1.6' }}>
                    It's been exactly <strong style={{ color: '#0F172A' }}>2 years</strong> since you joined PrimeCare. 
                    Your dedication and hard work do not go unnoticed.
                </p>

                <div style={{ marginTop: '24px', backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '8px', border: '1px solid #E2E8F0', display: 'flex', justifyContent: 'space-around' }}>
                     <div>
                         <div style={{ fontSize: '1.5rem', fontWeight: 800, color: '#0F172A' }}>412</div>
                         <div style={{ fontSize: '0.75rem', color: '#64748B', textTransform: 'uppercase', fontWeight: 700 }}>Shifts Covered</div>
                     </div>
                     <div style={{ width: '1px', backgroundColor: '#CBD5E1' }}></div>
                     <div>
                         <div style={{ fontSize: '1.5rem', fontWeight: 800, color: '#0F172A' }}>4.9<span style={{ fontSize: '1rem', color: '#94A3B8' }}>/5</span></div>
                         <div style={{ fontSize: '0.75rem', color: '#64748B', textTransform: 'uppercase', fontWeight: 700 }}>Avg Rating</div>
                     </div>
                </div>

                <button data-cy="btn-rn.milestone-celebrator-1" 
                    onClick={() => setIsVisible(false)}
                    style={{ 
                        width: '100%', padding: '14px', backgroundColor: '#0F172A', color: 'white', 
                        border: 'none', borderRadius: '8px', fontWeight: 700, fontSize: '1.05rem', 
                        cursor: 'pointer', marginTop: '24px', transition: 'background-color 0.2s'
                    }}
                >
                    Claim 500 Bonus Care Coins!
                </button>
            </div>
            <style>{`
                @keyframes slideUp {
                    from { opacity: 0; transform: translateY(40px); }
                    to { opacity: 1; transform: translateY(0); }
                }
            `}</style>
        </div>
    );
};
