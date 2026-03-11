import React, { useState } from 'react';
import { History, GitCommit, Search, RefreshCcw, FileJson, CheckCircle2 } from 'lucide-react';

interface WorkflowCommit {
    id: string;
    hash: string;
    description: string;
    author: string;
    timestamp: string;
    isActive: boolean;
}

export const WorkflowVersionControl: React.FC = () => {
    const [commits, setCommits] = useState<WorkflowCommit[]>([
        { id: '1', hash: '8f4c2e1', description: 'Added Slack notification on Stripe webhook failure', author: 'dam.manager@primecare.com', timestamp: '1 hour ago', isActive: true },
        { id: '2', hash: '3a9b7d5', description: 'Updated Checkr threshold logic', author: 'system.auto', timestamp: '2 days ago', isActive: false },
        { id: '3', hash: 'e5f1a9c', description: 'Initial CRM logic tree setup', author: 'dam.manager@primecare.com', timestamp: '1 week ago', isActive: false }
    ]);
    const [isReverting, setIsReverting] = useState(false);
    const [selectedCommit, setSelectedCommit] = useState<WorkflowCommit | null>(null);

    const handleRevert = (commit: WorkflowCommit) => {
        setIsReverting(true);
        setTimeout(() => {
            setCommits(prev => prev.map(c => ({
                ...c,
                isActive: c.id === commit.id
            })));
            setIsReverting(false);
            setSelectedCommit(null);
            alert(`Visual Workflow Engine successfully rolled back to commit [${commit.hash}].`);
        }, 1500);
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#F8FAFC', padding: '10px', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                        <History size={24} color="#475569" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Workflow Version Control</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Track and rollback changes made inside your visual logic trees.</p>
                    </div>
                </div>

                <div style={{ position: 'relative' }}>
                    <Search size={16} color="#94A3B8" style={{ position: 'absolute', left: '10px', top: '10px' }} />
                    <input 
                        type="text" 
                        placeholder="Search commits..." 
                        style={{ padding: '8px 12px 8px 32px', borderRadius: '6px', border: '1px solid #CBD5E1', outline: 'none', width: '250px' }}
                    />
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px' }}>
                {/* Timeline view */}
                <div style={{ flex: 2, display: 'flex', flexDirection: 'column', gap: '0', position: 'relative' }}>
                    {/* Vertical timeline line */}
                    <div style={{ position: 'absolute', top: '24px', bottom: '24px', left: '32px', width: '2px', backgroundColor: '#E2E8F0', zIndex: 0 }} />

                    {commits.map((commit, index) => (
                        <div key={commit.id} style={{ display: 'flex', gap: '16px', position: 'relative', zIndex: 1, marginBottom: '20px' }}>
                            <div style={{ width: '64px', display: 'flex', justifyContent: 'center', paddingTop: '12px' }}>
                                <div style={{ 
                                    width: '16px', height: '16px', borderRadius: '50%', 
                                    backgroundColor: commit.isActive ? '#10B981' : 'white',
                                    border: `3px solid ${commit.isActive ? '#10B981' : '#CBD5E1'}`,
                                    boxShadow: commit.isActive ? '0 0 0 4px #D1FAE5' : 'none'
                                }} />
                            </div>

                            <div 
                                onClick={() => setSelectedCommit(commit)}
                                style={{ 
                                    flex: 1, border: `1px solid ${selectedCommit?.id === commit.id ? '#3B82F6' : '#E2E8F0'}`, 
                                    borderRadius: '8px', padding: '16px', cursor: 'pointer',
                                    backgroundColor: selectedCommit?.id === commit.id ? '#EFF6FF' : 'white',
                                    transition: 'all 0.2s'
                                }}
                            >
                                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '8px' }}>
                                    <div style={{ fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                        {commit.description}
                                        {commit.isActive && <span style={{ backgroundColor: '#D1FAE5', color: '#065F46', padding: '2px 6px', borderRadius: '4px', fontSize: '0.65rem' }}>ACTIVE RECORD</span>}
                                    </div>
                                    <div style={{ fontSize: '0.75rem', color: '#64748B', fontFamily: 'monospace', backgroundColor: '#F1F5F9', padding: '2px 6px', borderRadius: '4px' }}>
                                        {commit.hash}
                                    </div>
                                </div>
                                
                                <div style={{ display: 'flex', alignItems: 'center', gap: '16px', fontSize: '0.8rem', color: '#64748B' }}>
                                    <span style={{ display: 'flex', alignItems: 'center', gap: '4px' }}><GitCommit size={14} /> {commit.author}</span>
                                    <span>•</span>
                                    <span>{commit.timestamp}</span>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>

                {/* Inspection Panel */}
                <div style={{ flex: 1, backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', padding: '20px', display: 'flex', flexDirection: 'column' }}>
                    {selectedCommit ? (
                        <>
                            <div style={{ fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px', borderBottom: '1px solid #E2E8F0', paddingBottom: '16px', marginBottom: '16px' }}>
                                <FileJson size={18} color="#3B82F6" /> Snapshot Details
                            </div>

                            <div style={{ marginBottom: '24px' }}>
                                <div style={{ fontSize: '0.8rem', color: '#64748B', textTransform: 'uppercase', marginBottom: '4px' }}>Commit Target</div>
                                <div style={{ color: '#0F172A', fontWeight: 700 }}>Global Layout & Ruleset</div>
                            </div>

                            <div style={{ marginBottom: '24px' }}>
                                <div style={{ fontSize: '0.8rem', color: '#64748B', textTransform: 'uppercase', marginBottom: '4px' }}>Diff Summary</div>
                                <ul style={{ margin: 0, paddingLeft: '16px', color: '#475569', fontSize: '0.85rem' }}>
                                    <li>Modified 1 Webhook Trigger</li>
                                    <li>Added 1 Output Action</li>
                                    <li>Removed 0 Logic Nodes</li>
                                </ul>
                            </div>

                            {!selectedCommit.isActive && (
                                <button 
                                    onClick={() => handleRevert(selectedCommit)}
                                    disabled={isReverting}
                                    style={{ 
                                        marginTop: 'auto', backgroundColor: 'white', color: '#DC2626', border: '1px solid #FECACA', 
                                        borderRadius: '6px', padding: '12px', fontWeight: 700, cursor: isReverting ? 'wait' : 'pointer', 
                                        display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px',
                                        boxShadow: '0 1px 2px rgba(0,0,0,0.05)'
                                    }}
                                >
                                    {isReverting ? <RefreshCcw size={16} className="animate-spin" /> : <History size={16} />}
                                    {isReverting ? 'Restoring Snapshot...' : 'Revert to this Commit'}
                                </button>
                            )}

                            {selectedCommit.isActive && (
                                <div style={{ marginTop: 'auto', backgroundColor: '#F0FDF4', color: '#16A34A', border: '1px solid #BBF7D0', borderRadius: '6px', padding: '12px', fontSize: '0.85rem', fontWeight: 700, display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px' }}>
                                    <CheckCircle2 size={16} /> Currently Live Configuration
                                </div>
                            )}
                        </>
                    ) : (
                        <div style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', color: '#64748B', textAlign: 'center' }}>
                            <History size={40} color="#CBD5E1" style={{ marginBottom: '16px' }} />
                            <p style={{ margin: 0, fontSize: '0.9rem' }}>Select a historical commit from the timeline to view its JSON diff or initiate a rollback.</p>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};
