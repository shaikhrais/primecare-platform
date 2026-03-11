import React from 'react';
import { Target, CheckCircle, Flag } from 'lucide-react';

interface Milestone {
    id: string;
    title: string;
    completed: boolean;
}

export const CareJourneyMap: React.FC = () => {
 // a physical therapy recovery journey
    const journey: Milestone[] = [
        { id: '1', title: 'Initial Assessment', completed: true },
        { id: '2', title: 'Stand Unassisted', completed: true },
        { id: '3', title: 'Walk 10 Steps', completed: false }, // Current Goal
        { id: '4', title: 'Climb 5 Stairs', completed: false },
        { id: '5', title: 'Full Independence', completed: false }
    ];

    const currentStepIndex = journey.findIndex(m => !m.completed);
    
    // Draw an exaggerated winding SVG path (resembling a road/climb)
    const renderPath = () => {
        return (
            <svg style={{ position: 'absolute', inset: 0, width: '100%', height: '100%', pointerEvents: 'none', zIndex: 0 }} xmlns="http://www.w3.org/2000/svg">
                <path 
                    className="journey-road-base"
                    d="M 50 400 Q 150 400 150 300 T 250 200 T 350 100 T 450 50" 
                    fill="none" 
                    stroke="#E2E8F0" 
                    strokeWidth="16" 
                    strokeLinecap="round" 
                />
                
                {/* dynamic progress bar along the curve */}
                {/* CSS handles the dash-offset mapping to progress visually */}
                <path 
                    className="journey-road-progress"
                    d="M 50 400 Q 150 400 150 300 T 250 200 T 350 100 T 450 50" 
                    fill="none" 
                    stroke="#3B82F6" 
                    strokeWidth="16" 
                    strokeLinecap="round" 
                    style={{
                        strokeDasharray: '600',
                        strokeDashoffset: currentStepIndex === -1 ? '0' : `${600 - (currentStepIndex * 150)}`, // Rough estimate for the bezier length
                        transition: 'stroke-dashoffset 2s ease-in-out'
                    }}
                />
            </svg>
        );
    };

    return (
        <section style={{ backgroundColor: '#F8FAFC', borderRadius: '16px', border: '2px solid #E2E8F0', padding: '32px', position: 'relative', overflow: 'hidden' }}>
            <h2 style={{ fontSize: '1.75rem', fontWeight: 900, color: '#0F172A', margin: '0 0 8px 0', zIndex: 1, position: 'relative' }}>Your Care Journey</h2>
            <p style={{ fontSize: '1.2rem', color: '#64748B', margin: '0 0 32px 0', zIndex: 1, position: 'relative' }}>Tracking your physical therapy goals.</p>
            
            <div style={{ position: 'relative', height: '420px', width: '100%' }}>
                {renderPath()}

                {/* Nodes mapped roughly over the bezier curve manually for this static demonstration */}
                <div style={{ position: 'absolute', inset: 0, zIndex: 1 }}>
                    <div className="journey-node" style={{ left: '50px', top: '400px', transform: 'translate(-50%, -50%)' }}>
                        <NodeIcon completed={journey[0].completed} />
                        <span className="node-label">Assessment</span>
                    </div>
                    
                    <div className="journey-node" style={{ left: '150px', top: '300px', transform: 'translate(-50%, -50%)' }}>
                        <NodeIcon completed={journey[1].completed} />
                        <span className="node-label">Stand</span>
                    </div>

                    <div className="journey-node" style={{ left: '250px', top: '200px', transform: 'translate(-50%, -50%)' }}>
                        <NodeIcon completed={journey[2].completed} isActive={true} />
                        <span className="node-label">Walk</span>
                    </div>

                    <div className="journey-node" style={{ left: '350px', top: '100px', transform: 'translate(-50%, -50%)' }}>
                        <NodeIcon completed={journey[3].completed} />
                        <span className="node-label">Stairs</span>
                    </div>

                    <div className="journey-node" style={{ left: '450px', top: '50px', transform: 'translate(-50%, -50%)' }}>
                        <div style={{ backgroundColor: 'white', border: '4px solid #10B981', borderRadius: '50%', padding: '12px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                            <Flag size={32} color="#10B981" />
                        </div>
                        <span className="node-label" style={{ fontWeight: 900, fontSize: '1.2rem', color: '#10B981' }}>Graduation!</span>
                    </div>
                </div>
            </div>

            <style>{`
                .journey-node {
                    position: absolute;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    gap: 12px;
                }
                .node-label {
                    background-color: white;
                    padding: 4px 12px;
                    border-radius: 8px;
                    border: 2px solid #E2E8F0;
                    font-weight: 800;
                    font-size: 1.1rem;
                    color: #334155;
                    white-space: nowrap;
                    box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
                }
            `}</style>
        </section>
    );
};

const NodeIcon = ({ completed, isActive }: { completed: boolean; isActive?: boolean }) => {
    if (completed) {
        return (
            <div style={{ backgroundColor: '#3B82F6', borderRadius: '50%', padding: '8px', zIndex: 2, border: '4px solid white', boxShadow: '0 0 0 2px #3B82F6' }}>
                <CheckCircle size={28} color="white" />
            </div>
        );
    }
    
    if (isActive) {
        return (
            <div style={{ backgroundColor: 'white', borderRadius: '50%', padding: '12px', zIndex: 2, border: '6px solid #F59E0B', animation: 'bounce 2s infinite' }}>
                <Target size={32} color="#F59E0B" />
                <style>{`
                    @keyframes bounce {
                        0%, 100% { transform: translateY(0); }
                        50% { transform: translateY(-10px); }
                    }
                `}</style>
            </div>
        );
    }

    return (
        <div style={{ width: '24px', height: '24px', backgroundColor: '#CBD5E1', borderRadius: '50%', border: '4px solid white', zIndex: 2 }}></div>
    );
};
