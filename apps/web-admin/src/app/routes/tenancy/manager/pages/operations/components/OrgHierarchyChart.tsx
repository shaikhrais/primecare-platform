import React, { useState } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { User, Activity, AlertTriangle, Briefcase, TrendingDown, Users } from 'lucide-react';

// Node Data structure for an Org Chart
interface OrgNode {
    id: string;
    name: string;
    role: string;
    kpi: number; // e.g. Staff retention score 0-100
    children?: OrgNode[];
}

const ORG_DATA: OrgNode = {
    id: 'root',
    name: 'Eleanor Vance',
    role: 'Operations Director',
    kpi: 92,
    children: [
        {
            id: 'mgr1',
            name: 'Robert Chase',
            role: 'Clinical Manager (North)',
            kpi: 88,
            children: [
                { id: 'rn1', name: 'James Reynolds', role: 'RN Supervisor', kpi: 95 },
                { id: 'rn2', name: 'Alisha Patel', role: 'RN Supervisor', kpi: 76 }
            ]
        },
        {
            id: 'mgr2',
            name: 'Susan Lee',
            role: 'Clinical Manager (South)',
            kpi: 62, // Flagged for burnout/retention issues
            children: [
                { id: 'rn3', name: 'David Kim', role: 'RN Supervisor', kpi: 81 },
                { id: 'rn4', name: 'Maria Garcia', role: 'RN Supervisor', kpi: 55 }
            ]
        }
    ]
};

// SVG Node Component
const NodeBox: React.FC<{ node: OrgNode, isRoot?: boolean, onClick: (n: OrgNode) => void }> = ({ node, isRoot, onClick }) => {
    
    const getKpiColor = (score: number) => {
        if (score >= 85) return '#10B981';
        if (score >= 70) return '#F59E0B';
        return '#EF4444';
    };

    const isCritical = node.kpi < 70;

    return (
        <div 
            onClick={() => onClick(node)}
            style={{ 
                width: '180px', 
                backgroundColor: 'white', 
                border: `2px solid ${isRoot ? '#6366F1' : isCritical ? '#EF4444' : '#CBD5E1'}`, 
                borderRadius: '12px', 
                padding: '12px',
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                boxShadow: isCritical ? '0 0 15px rgba(239, 68, 68, 0.3)' : '0 4px 6px -1px rgba(0, 0, 0, 0.1)',
                cursor: 'pointer',
                transition: 'transform 0.2s',
                zIndex: 10
            }}
            onMouseEnter={e => e.currentTarget.style.transform = 'translateY(-2px) scale(1.02)'}
            onMouseLeave={e => e.currentTarget.style.transform = 'translateY(0) scale(1)'}
        >
            <div style={{ backgroundColor: isRoot ? '#EEF2FF' : '#F1F5F9', padding: '8px', borderRadius: '50%', marginBottom: '8px' }}>
                <User size={24} color={isRoot ? '#6366F1' : '#64748B'} />
            </div>
            <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '0.9rem', textAlign: 'center' }}>{node.name}</div>
            <div style={{ color: '#64748B', fontSize: '0.75rem', textAlign: 'center', marginBottom: '8px' }}>{node.role}</div>
            
            <div style={{ display: 'flex', alignItems: 'center', gap: '4px', backgroundColor: '#F8FAFC', padding: '4px 8px', borderRadius: '4px', width: '100%', justifyContent: 'center' }}>
                <Activity size={12} color={getKpiColor(node.kpi)} />
                <span style={{ fontSize: '0.8rem', fontWeight: 800, color: getKpiColor(node.kpi) }}>
                    Vol {node.kpi}%
                </span>
            </div>
        </div>
    );
};

export const OrgHierarchyChart: React.FC = () => {
    const { showToast } = useNotification();
    const [selectedNode, setSelectedNode] = useState<OrgNode | null>(null);

    // Suggestion 30 & 28 integration: Re-assignment flow and burnout visibility
    const handleNodeClick = (node: OrgNode) => {
        setSelectedNode(node);
        showToast(`Viewing telemetery for ${node.name}`, 'info');
    };

    return (
        <div style={{ backgroundColor: '#F8FAFC', padding: '32px', borderRadius: '16px', border: '1px solid #E2E8F0', display: 'flex', flexDirection: 'column', gap: '24px', overflowX: 'auto', minHeight: '500px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div>
                    <h2 data-cy="h2-manager.org-hierarchy-chart-0" style={{ fontSize: '1.25rem', fontWeight: 800, margin: '0 0 4px 0', color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <Users color="#6366F1" /> Hierarchy & Burnout Topology
                    </h2>
                    <p style={{ color: '#64748B', margin: 0, fontSize: '0.9rem' }}>Visualizing management lines and cascading retention risk.</p>
                </div>
            </div>

            <div style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', position: 'relative', paddingTop: '20px' }}>
                
                {/* CSS/SVG Lines for the Tree */}
                <svg style={{ position: 'absolute', inset: 0, width: '100%', height: '100%', zIndex: 0, pointerEvents: 'none' }}>
                    {/* Root to Managers */}
                    <path d="M 50% 120 L 50% 160 L 25% 160 L 25% 180" fill="none" stroke="#CBD5E1" strokeWidth="2" />
                    <path d="M 50% 120 L 50% 160 L 75% 160 L 75% 180" fill="none" stroke="#CBD5E1" strokeWidth="2" />
                    
                    {/* Manager 1 to RNs */}
                    <path d="M 25% 300 L 25% 340 L 15% 340 L 15% 360" fill="none" stroke="#CBD5E1" strokeWidth="2" />
                    <path d="M 25% 300 L 25% 340 L 35% 340 L 35% 360" fill="none" stroke="#CBD5E1" strokeWidth="2" />

                    {/* Manager 2 to RNs */}
                    <path d="M 75% 300 L 75% 340 L 65% 340 L 65% 360" fill="none" stroke="#EF4444" strokeWidth="2" strokeDasharray="4" />
                    <path d="M 75% 300 L 75% 340 L 85% 340 L 85% 360" fill="none" stroke="#EF4444" strokeWidth="2" strokeDasharray="4" />
                </svg>

                {/* Level 1: Root */}
                <div style={{ marginBottom: '60px', position: 'relative' }}>
                    <NodeBox node={ORG_DATA} isRoot onClick={handleNodeClick} />
                </div>

                {/* Level 2: Managers */}
                <div style={{ display: 'flex', width: '100%', justifyContent: 'space-around', marginBottom: '60px', position: 'relative' }}>
                    {ORG_DATA.children?.map(manager => (
                        <div key={manager.id} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                            <NodeBox node={manager} onClick={handleNodeClick} />
                        </div>
                    ))}
                </div>

                {/* Level 3: Supervisors */}
                <div style={{ display: 'flex', width: '100%', justifyContent: 'space-around', position: 'relative' }}>
                    <div style={{ display: 'flex', width: '50%', justifyContent: 'space-around' }}>
                        {ORG_DATA.children?.[0].children?.map(rn => <NodeBox key={rn.id} node={rn} onClick={handleNodeClick} />)}
                    </div>
                    <div style={{ display: 'flex', width: '50%', justifyContent: 'space-around' }}>
                        {ORG_DATA.children?.[1].children?.map(rn => <NodeBox key={rn.id} node={rn} onClick={handleNodeClick} />)}
                    </div>
                </div>
            </div>

            {selectedNode && (
                <div style={{ backgroundColor: '#1E293B', color: 'white', padding: '16px', borderRadius: '12px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: 'auto' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                        <Briefcase size={24} color="#94A3B8" />
                        <div>
                            <div style={{ fontWeight: 800 }}>{selectedNode.name}</div>
                            <div style={{ color: '#94A3B8', fontSize: '0.85rem' }}>{selectedNode.role}</div>
                        </div>
                    </div>

                    <div style={{ display: 'flex', gap: '24px' }}>
                        <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-end' }}>
                            <span style={{ color: '#94A3B8', fontSize: '0.75rem', textTransform: 'uppercase' }}>Volume Cap</span>
                            <span style={{ fontWeight: 800, color: selectedNode.kpi < 70 ? '#EF4444' : '#10B981' }}>{selectedNode.kpi}%</span>
                        </div>
                        {selectedNode.kpi < 70 && (
                            <button data-cy="btn-manager.org-hierarchy-chart-0" style={{ backgroundColor: '#DC2626', color: 'white', border: 'none', padding: '8px 16px', borderRadius: '6px', fontWeight: 800, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                <TrendingDown size={16} /> Intervene
                            </button>
                        )}
                    </div>
                </div>
            )}
        </div>
    );
};
