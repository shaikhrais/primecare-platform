import React, { useState } from 'react';
import { Heart, X, Sparkles, HandHeart } from 'lucide-react';

interface PersonalityTrait {
    id: string;
    label: string;
    description: string;
    icon: any;
}

export const PersonalityMatcher: React.FC = () => {
    const traits: PersonalityTrait[] = [
        { id: 't1', label: 'Chatty & Outgoing', description: 'Enjoys long conversations and sharing stories.', icon: Sparkles },
        { id: 't2', label: 'Quiet & Focused', description: 'Prefers a calm environment with minimal small talk.', icon: HandHeart },
        { id: 't3', label: 'Dog Lover', description: 'Comfortable around large or energetic pets.', icon: Heart }
    ];

    const [currentIndex, setCurrentIndex] = useState(0);
    const [preferences, setPreferences] = useState<Record<string, 'Y' | 'N'>>({});

    const handleSwipe = (traitId: string, choice: 'Y' | 'N') => {
        setPreferences(prev => ({ ...prev, [traitId]: choice }));
        
 // Timeout for simple animation 
        setTimeout(() => {
            setCurrentIndex(prev => prev + 1);
        }, 300);
    };

    if (currentIndex >= traits.length) {
        return (
            <div style={{ padding: '24px', backgroundColor: '#F0FDF4', borderRadius: '12px', border: '1px solid #BBF7D0', textAlign: 'center' }}>
                <Heart size={32} color="#16A34A" fill="#16A34A" style={{ marginBottom: '12px' }} />
                <h3 data-cy="h3-client.personality-matcher-0" style={{ margin: 0, color: '#14532D', fontSize: '1.2rem' }}>Preferences Saved!</h3>
                <p style={{ margin: '8px 0 0 0', color: '#166534', fontSize: '0.9rem' }}>
                    We've updated your patient profile. Our dispatcher will prioritize caregivers matching these traits.
                </p>
            </div>
        );
    }

    const currentTrait = traits[currentIndex];
    const Icon = currentTrait.icon;

    return (
        <div style={{ backgroundColor: '#F8FAFC', borderRadius: '16px', padding: '24px', border: '1px solid #E2E8F0', marginTop: '16px', overflow: 'hidden', position: 'relative' }}>
            <div style={{ textAlign: 'center', marginBottom: '20px' }}>
                <h3 data-cy="h3-client.personality-matcher-1" style={{ margin: 0, fontSize: '1.1rem', color: '#64748B', textTransform: 'uppercase', letterSpacing: '1px' }}>Caregiver Matcher</h3>
                <div style={{ fontSize: '0.8rem', color: '#94A3B8', marginTop: '4px' }}>{currentIndex + 1} of {traits.length}</div>
            </div>

            <div style={{ 
                backgroundColor: 'white', borderRadius: '20px', padding: '32px 20px', 
                boxShadow: '0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1)',
                display: 'flex', flexDirection: 'column', alignItems: 'center', textAlign: 'center',
                transition: 'transform 0.3s ease-out'
            }}>
                <div style={{ backgroundColor: '#F0F9FF', padding: '20px', borderRadius: '50%', marginBottom: '16px' }}>
                    <Icon size={48} color="#0EA5E9" />
                </div>
                <h4 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>{currentTrait.label}</h4>
                <p style={{ margin: '12px 0 0 0', color: '#64748B', fontSize: '0.95rem', lineHeight: '1.5' }}>
                    "{currentTrait.description}"
                </p>
            </div>

            <div style={{ display: 'flex', justifyContent: 'center', gap: '24px', marginTop: '24px' }}>
                <button data-cy="btn-client.personality-matcher-0" 
                    onClick={() => handleSwipe(currentTrait.id, 'N')}
                    style={{ 
                        width: '60px', height: '60px', borderRadius: '50%', backgroundColor: 'white', 
                        border: '2px solid #FECACA', display: 'flex', alignItems: 'center', justifyContent: 'center',
                        cursor: 'pointer', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)'
                    }}
                >
                    <X size={28} color="#EF4444" />
                </button>
                <button data-cy="btn-client.personality-matcher-1" 
                    onClick={() => handleSwipe(currentTrait.id, 'Y')}
                    style={{ 
                        width: '60px', height: '60px', borderRadius: '50%', backgroundColor: 'white', 
                        border: '2px solid #BBF7D0', display: 'flex', alignItems: 'center', justifyContent: 'center',
                        cursor: 'pointer', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)'
                    }}
                >
                    <Heart size={28} color="#22C55E" />
                </button>
            </div>
        </div>
    );
};
