import React, { useState } from 'react';
import { Workflow, Play, MousePointer2, Plus, ArrowRight, Settings2, Trash2, Webhook, MessageSquare, Database } from 'lucide-react';
import { useApiMutation } from '@/shared/hooks/useApiMutation';
import { useToast as useNotification } from '@/shared/hooks/useToast';

interface LogicNode {
    id: string;
    type: 'TRIGGER' | 'ACTION' | 'CONDITION';
    title: string;
    description: string;
    icon: React.ReactNode;
    state: 'CONFIGURED' | 'DRAFT';
}

export const VisualLogicBuilder: React.FC = () => {
    const [nodes, setNodes] = useState<LogicNode[]>([
        { id: 'n1', type: 'TRIGGER', title: 'Webhook Received', description: 'Stripe: PaymentIntent.Succeeded', icon: <Webhook />, state: 'CONFIGURED' },
        { id: 'n2', type: 'ACTION', title: 'Update Database', description: 'Table: Invoices -> Set Status = Paid', icon: <Database />, state: 'CONFIGURED' },
        { id: 'n3', type: 'ACTION', title: 'Push Notification', description: 'Slack: #finance-alerts', icon: <MessageSquare />, state: 'DRAFT' }
    ]);
    const [isSaving, setIsSaving] = useState(false);
    const { showToast } = useNotification();

    const handleAddNode = () => {
        setNodes(prev => [...prev, { id: `n_${Date.now()}`, type: 'ACTION', title: 'New Action', description: 'Unconfigured node', icon: <Settings2 />, state: 'DRAFT' }]);
    };

    const handleRemoveNode = (id: string) => {
        setNodes(prev => prev.filter(n => n.id !== id));
    };

    const saveMutation = useApiMutation('/platform/admin/dam/workflows/visual-logic', {
        onSuccess: () => {
            showToast('Visual logic payload translated to JSON and persisted to DB.', 'success');
            setNodes(prev => prev.map(n => ({...n, state: 'CONFIGURED'})));
        },
        onError: () => { showToast('Failed to compile syntax', 'error'); },
    });

    const handleSave = () => saveMutation.mutate({ nodes });

    const renderNode = (node: LogicNode, index: number) => {
        return (
            <React.Fragment key={node.id}>
                {index > 0 && (
                    <div style={{ height: '40px', width: '2px', backgroundColor: '#CBD5E1', margin: '0 auto', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                        <ArrowRight size={16} color="#94A3B8" style={{ transform: 'rotate(90deg)' }} />
                    </div>
                )}
                
                <div style={{ 
                    width: '320px', backgroundColor: 'white', border: `2px solid ${node.state === 'DRAFT' ? '#F59E0B' : '#E2E8F0'}`, 
                    borderRadius: '8px', padding: '16px', display: 'flex', alignItems: 'flex-start', gap: '12px',
                    boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)', position: 'relative'
                }}>
                    <div style={{ backgroundColor: node.type === 'TRIGGER' ? '#F0FDF4' : '#EFF6FF', color: node.type === 'TRIGGER' ? '#16A34A' : '#3B82F6', padding: '10px', borderRadius: '8px' }}>
                        {node.icon}
                    </div>
                    <div style={{ flex: 1 }}>
                        <div style={{ fontSize: '0.7rem', fontWeight: 800, color: '#64748B', letterSpacing: '0.5px' }}>{node.type}</div>
                        <div style={{ fontWeight: 700, color: '#0F172A', fontSize: '0.95rem', margin: '2px 0' }}>{node.title}</div>
                        <div style={{ fontSize: '0.8rem', color: '#64748B' }}>{node.description}</div>
                        
                        {node.state === 'DRAFT' && <span style={{ display: 'inline-block', marginTop: '8px', backgroundColor: '#FEF3C7', color: '#D97706', padding: '2px 6px', borderRadius: '4px', fontSize: '0.7rem', fontWeight: 700 }}>NEEDS CONFIG</span>}
                    </div>
                    <button data-cy={`dam.workflow.btn-remove-${node.id}`} onClick={() => handleRemoveNode(node.id)} style={{ background: 'transparent', border: 'none', cursor: 'pointer', color: '#94A3B8', position: 'absolute', top: '12px', right: '12px' }}>
                        <Trash2 size={16} />
                    </button>
                </div>
            </React.Fragment>
        );
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', overflow: 'hidden', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '24px', backgroundColor: '#F8FAFC', borderBottom: '1px solid #E2E8F0' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#EEF2FF', padding: '10px', borderRadius: '8px' }}>
                        <Workflow size={24} color="#4F46E5" />
                    </div>
                    <div>
                        <h3 data-cy="h3-visual-logic-builder-0" style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Visual Logic Builder</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Connect Triggers to Actions to automate backend microservices.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <button data-cy="dam.workflow.btn-test" style={{ backgroundColor: 'white', color: '#0F172A', border: '1px solid #CBD5E1', borderRadius: '8px', padding: '8px 16px', fontWeight: 600, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <Play size={16} color="#16A34A" /> Test Flow
                    </button>
                    <button 
                        data-cy="dam.workflow.btn-publish"
                        onClick={handleSave}
                        disabled={isSaving}
                        style={{ backgroundColor: '#4F46E5', color: 'white', border: 'none', borderRadius: '8px', padding: '8px 16px', fontWeight: 700, cursor: isSaving ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '6px' }}
                    >
                        <MousePointer2 size={16} /> {isSaving ? 'Compiling...' : 'Publish to Edge'}
                    </button>
                </div>
            </div>

            {/* Canvas Area */}
            <div style={{ backgroundColor: '#F1F5F9', minHeight: '500px', display: 'flex', flexDirection: 'column', alignItems: 'center', padding: '48px', position: 'relative', overflowY: 'auto', backgroundImage: 'radial-gradient(#CBD5E1 1px, transparent 1px)', backgroundSize: '24px 24px' }}>
                
                {nodes.map((node, i) => renderNode(node, i))}

                <button 
                    data-cy="dam.workflow.btn-add-node"
                    onClick={handleAddNode}
                    style={{ marginTop: '24px', backgroundColor: 'white', border: '2px dashed #94A3B8', borderRadius: '50%', width: '48px', height: '48px', display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer', color: '#64748B', transition: 'all 0.2s', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)' }}
                    title="Add Node"
                >
                    <Plus size={24} />
                </button>

            </div>
        </div>
    );
};
