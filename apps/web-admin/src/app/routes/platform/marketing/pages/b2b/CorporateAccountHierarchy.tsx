import React, { useState } from 'react';
import { Network, Building2, Building, ChevronRight, ChevronDown, CheckCircle2, ShieldAlert } from 'lucide-react';

interface AccountNode {
    id: string;
    type: 'CORPORATE_HQ' | 'REGIONAL_HUB' | 'LOCAL_CLINIC';
    name: string;
    contractStatus: 'ACTIVE' | 'NEGOTIATION' | 'EXPIRED';
    address?: string;
    children?: AccountNode[];
}

export const CorporateAccountHierarchy: React.FC = () => {
 // highly-nested account tree structure typical of large healthcare networks
    const [hierarchy] = useState<AccountNode[]>([
        {
            id: 'HQ_1',
            type: 'CORPORATE_HQ',
            name: 'Trinity Health Systems (National HQ)',
            contractStatus: 'ACTIVE',
            children: [
                {
                    id: 'REG_1',
                    type: 'REGIONAL_HUB',
                    name: 'Trinity Mid-West Regional',
                    contractStatus: 'ACTIVE',
                    children: [
                        { id: 'LOC_1', type: 'LOCAL_CLINIC', name: 'St. Jude Childrens Center', contractStatus: 'ACTIVE', address: '1442 West Blvd.' },
                        { id: 'LOC_2', type: 'LOCAL_CLINIC', name: 'Columbus Oncology Hub', contractStatus: 'EXPIRED', address: '992 South St.' }
                    ]
                },
                {
                    id: 'REG_2',
                    type: 'REGIONAL_HUB',
                    name: 'Trinity Eastern Seaboard',
                    contractStatus: 'NEGOTIATION',
                    children: [
                        { id: 'LOC_3', type: 'LOCAL_CLINIC', name: 'Manhattan Geriatrics', contractStatus: 'NEGOTIATION', address: '12 5th Ave.' }
                    ]
                }
            ]
        }
    ]);

    const [expandedNodes, setExpandedNodes] = useState<Set<string>>(new Set(['HQ_1', 'REG_1']));

    const toggleExpand = (id: string, e: React.MouseEvent) => {
        e.stopPropagation();
        const newExpanded = new Set(expandedNodes);
        if (newExpanded.has(id)) {
            newExpanded.delete(id);
        } else {
            newExpanded.add(id);
        }
        setExpandedNodes(newExpanded);
    };

    const getStatusIndicator = (status: string) => {
        switch(status) {
            case 'ACTIVE': return <span style={{ backgroundColor: '#DCFCE7', color: '#16A34A', padding: '2px 8px', borderRadius: '4px', fontSize: '0.7rem', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '4px' }}><CheckCircle2 size={12}/> ACTIVE MSA</span>;
            case 'NEGOTIATION': return <span style={{ backgroundColor: '#FEF9C3', color: '#CA8A04', padding: '2px 8px', borderRadius: '4px', fontSize: '0.7rem', fontWeight: 800 }}>PENDING LEGAL</span>;
            case 'EXPIRED': return <span style={{ backgroundColor: '#FEF2F2', color: '#DC2626', padding: '2px 8px', borderRadius: '4px', fontSize: '0.7rem', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '4px' }}><ShieldAlert size={12}/> EXPIRED</span>;
            default: return null;
        }
    };

    const renderTree = (nodes: AccountNode[], level: number = 0) => {
        return nodes.map(node => {
            const isExpanded = expandedNodes.has(node.id);
            const hasChildren = node.children && node.children.length > 0;
            
            return (
                <div key={node.id} style={{ marginLeft: level === 0 ? '0' : '24px', position: 'relative' }}>
                    {/* Visual connecting lines */}
                    {level > 0 && <div style={{ position: 'absolute', left: '-12px', top: '24px', width: '12px', height: '1px', backgroundColor: '#CBD5E1' }} />}
                    {level > 0 && <div style={{ position: 'absolute', left: '-12px', top: '-16px', width: '1px', bottom: hasChildren ? (isExpanded ? '0' : '24px') : '24px', backgroundColor: '#CBD5E1' }} />}

                    <div 
                        style={{ 
                            display: 'flex', 
                            alignItems: 'center', 
                            gap: '12px', 
                            padding: '12px 16px', 
                            marginTop: '8px',
                            backgroundColor: level === 0 ? '#F8FAFC' : 'white', 
                            border: '1px solid #E2E8F0', 
                            borderRadius: '8px',
                            cursor: hasChildren ? 'pointer' : 'default',
                            transition: 'all 0.2s',
                            boxShadow: level === 0 ? '0 1px 3px rgba(0,0,0,0.05)' : 'none'
                        }}
                        onClick={(e) => hasChildren && toggleExpand(node.id, e)}
                    >
                        {hasChildren ? (
                            <div style={{ color: '#64748B', display: 'flex', alignItems: 'center', justifyContent: 'center', width: '20px' }}>
                                {isExpanded ? <ChevronDown size={20} /> : <ChevronRight size={20} />}
                            </div>
                        ) : (
                            <div style={{ width: '20px' }} /> // Spacer for alignment
                        )}

                        <div style={{ backgroundColor: level === 0 ? '#1E293B' : (level === 1 ? '#64748B' : '#F1F5F9'), padding: '8px', borderRadius: '6px', color: level < 2 ? 'white' : '#64748B' }}>
                            {level === 0 ? <Network size={20} /> : (level === 1 ? <Building2 size={16} /> : <Building size={16} />)}
                        </div>

                        <div style={{ flex: 1 }}>
                            <div style={{ fontWeight: 800, color: '#0F172A', fontSize: level === 0 ? '1.1rem' : '0.95rem' }}>
                                {node.name}
                            </div>
                            {node.address && (
                                <div style={{ fontSize: '0.8rem', color: '#64748B', marginTop: '2px' }}>{node.address}</div>
                            )}
                        </div>

                        <div>
                            {getStatusIndicator(node.contractStatus)}
                        </div>
                    </div>

                    {isExpanded && hasChildren && (
                        <div style={{ paddingBottom: '8px' }}>
                            {renderTree(node.children!, level + 1)}
                        </div>
                    )}
                </div>
            );
        });
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
             <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F1F5F9', padding: '12px', borderRadius: '8px' }}>
                        <Network size={28} color="#475569" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Corporate Account Hierarchy</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Map independent clinics to their parent conglomerate to enforce Master Service Agreements.</p>
                    </div>
                </div>
            </div>

            <div style={{ backgroundColor: '#F8FAFC', padding: '24px', borderRadius: '12px', border: '1px solid #E2E8F0' }}>
                {renderTree(hierarchy)}
            </div>

            <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#EFF6FF', borderRadius: '8px', border: '1px solid #BFDBFE', fontSize: '0.85rem', color: '#1E3A8A' }}>
                <strong>Enterprise Data Integrity:</strong> When a Master Service Agreement (MSA) is negotiated at the HQ level, this recursive hierarchy ensures that all child Regional Hubs and Local Clinics automatically inherit the negotiated B2B billing rates without manual data entry.
            </div>
        </div>
    );
};
