import React from 'react';
import { Users, ExternalLink } from 'lucide-react';

interface Node {
    id: string;
    label: string;
    role: string;
    x: number;
    y: number;
}

interface Edge {
    source: string;
    target: string;
    weight: number; // Represents how many times they covered for each other
}

export const YearbookGraph: React.FC = () => {
    // Mock Data simulating a force-directed graph (D3 style)
    const nodes: Node[] = [
        { id: 'n1', label: 'Sarah (RN)', role: 'RN', x: 50, y: 50 },
        { id: 'n2', label: 'Michael', role: 'PSW', x: 20, y: 30 },
        { id: 'n3', label: 'Elena', role: 'PSW', x: 80, y: 30 },
        { id: 'n4', label: 'David', role: 'PSW', x: 20, y: 70 },
        { id: 'n5', label: 'Jessica', role: 'PSW', x: 80, y: 70 },
    ];

    const edges: Edge[] = [
        { source: 'n1', target: 'n2', weight: 3 },
        { source: 'n1', target: 'n3', weight: 5 },
        { source: 'n2', target: 'n4', weight: 1 },
        { source: 'n3', target: 'n5', weight: 8 },
        { source: 'n4', target: 'n1', weight: 2 },
    ];

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
             <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                    <div style={{ backgroundColor: '#F3E8FF', padding: '8px', borderRadius: '8px' }}>
                        <Users size={20} color="#9333EA" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Agency Yearbook</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.85rem' }}>Visualizing shift-coverage tribal loyalty.</p>
                    </div>
                </div>
                <button style={{ backgroundColor: 'transparent', border: '1px solid #E2E8F0', padding: '6px 12px', borderRadius: '6px', fontSize: '0.8rem', fontWeight: 600, color: '#475569', display: 'flex', alignItems: 'center', gap: '4px', cursor: 'pointer' }}>
                    Expand View <ExternalLink size={14} />
                </button>
            </div>

            <div style={{ width: '100%', height: '300px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', position: 'relative', overflow: 'hidden' }}>
                <svg width="100%" height="100%" viewBox="0 0 100 100" preserveAspectRatio="none">
                    {/* Render Edges */}
                    {edges.map((edge, idx) => {
                        const src = nodes.find(n => n.id === edge.source)!;
                        const tgt = nodes.find(n => n.id === edge.target)!;
                        return (
                            <line 
                                key={`e${idx}`} 
                                x1={src.x} y1={src.y} 
                                x2={tgt.x} y2={tgt.y} 
                                stroke="#CBD5E1" 
                                strokeWidth={Math.max(1, edge.weight / 2)} 
                            />
                        );
                    })}

                    {/* Render Nodes */}
                    {nodes.map(node => (
                        <g key={node.id} transform={`translate(${node.x}, ${node.y})`}>
                            <circle r="6" fill={node.role === 'RN' ? '#4F46E5' : '#0EA5E9'} stroke="white" strokeWidth="2" />
                            <text 
                                x="0" y="12" 
                                textAnchor="middle" 
                                fontSize="4" 
                                fill="#475569" 
                                fontWeight="700"
                            >
                                {node.label}
                            </text>
                        </g>
                    ))}
                </svg>
            </div>
            
            <p style={{ marginTop: '16px', fontSize: '0.8rem', color: '#64748B', lineHeight: '1.5', textAlign: 'center' }}>
                Thicker lines indicate team members who frequently cover sick calls for each other. Fostering these connections improves overall retention by 14%.
            </p>
        </div>
    );
};
