import React, { useState } from 'react';
import { Kanban, FileText, CheckCircle2, Clock, Edit3, ShieldAlert, ArrowRight } from 'lucide-react';

interface BlogPost {
    id: string;
    title: string;
    targetKeyword: string;
    author: string;
    status: 'IDEATION' | 'DRAFTING' | 'MEDICAL_REVIEW' | 'LEGAL_REVIEW' | 'PUBLISHED';
    dueDate: string;
}

export const BlogContentCalendar: React.FC = () => {
    const [posts, setPosts] = useState<BlogPost[]>([
        { id: '1', title: '5 Early Warning Signs of Dementia', targetKeyword: 'dementia care signs', author: 'Sarah J.', status: 'IDEATION', dueDate: '2023-11-20' },
        { id: '2', title: 'Cost of 24/7 At-Home Care vs Nursing Homes', targetKeyword: 'at home care costs', author: 'Marcus C.', status: 'DRAFTING', dueDate: '2023-11-22' },
        { id: '3', title: 'Fall Prevention Checklist for Winter', targetKeyword: 'senior fall prevention winter', author: 'Clinician Team', status: 'MEDICAL_REVIEW', dueDate: '2023-11-25' },
        { id: '4', title: 'Navigating Medicare Part A for Respite Care', targetKeyword: 'medicare respite care', author: 'Legal Team', status: 'LEGAL_REVIEW', dueDate: '2023-11-28' },
        { id: '5', title: 'The Ultimate Guide to Hiring a Caregiver', targetKeyword: 'how to hire a caregiver', author: 'Sarah J.', status: 'PUBLISHED', dueDate: '2023-11-01' }
    ]);

    const columns: { id: BlogPost['status'], title: string, color: string }[] = [
        { id: 'IDEATION', title: 'Ideation', color: '#64748B' },
        { id: 'DRAFTING', title: 'Drafting', color: '#3B82F6' },
        { id: 'MEDICAL_REVIEW', title: 'Medical Review', color: '#F59E0B' },
        { id: 'LEGAL_REVIEW', title: 'Legal Review', color: '#DC2626' },
        { id: 'PUBLISHED', title: 'Published', color: '#10B981' }
    ];

    const movePost = (id: string, newStatus: BlogPost['status']) => {
        setPosts(posts.map(p => p.id === id ? { ...p, status: newStatus } : p));
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F8FAFC', padding: '12px', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                        <Kanban size={28} color="#475569" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>SEO Content Publishing Pipeline</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Kanban board enforcing medical and legal clearances before organic SEO content is pushed live.</p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '16px', overflowX: 'auto', paddingBottom: '16px' }}>
                {columns.map(col => {
                    const columnPosts = posts.filter(p => p.status === col.id);
                    
                    return (
                        <div key={col.id} style={{ flex: '0 0 280px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: `1px solid #E2E8F0`, display: 'flex', flexDirection: 'column', height: '100%' }}>
                            <div style={{ padding: '12px 16px', borderBottom: '1px solid #E2E8F0', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderTop: `4px solid ${col.color}`, borderTopLeftRadius: '8px', borderTopRightRadius: '8px' }}>
                                <h4 style={{ margin: 0, fontSize: '0.95rem', color: '#334155', fontWeight: 800 }}>{col.title}</h4>
                                <span style={{ backgroundColor: '#E2E8F0', color: '#475569', padding: '2px 8px', borderRadius: '12px', fontSize: '0.75rem', fontWeight: 700 }}>{columnPosts.length}</span>
                            </div>

                            <div style={{ padding: '12px', display: 'flex', flexDirection: 'column', gap: '12px', minHeight: '300px' }}>
                                {columnPosts.map(post => (
                                    <div key={post.id} style={{ backgroundColor: 'white', padding: '16px', borderRadius: '8px', border: '1px solid #CBD5E1', boxShadow: '0 1px 3px rgba(0,0,0,0.05)', display: 'flex', flexDirection: 'column' }}>
                                        <div style={{ fontSize: '0.75rem', color: '#0284C7', fontWeight: 800, marginBottom: '6px', textTransform: 'uppercase' }}>
                                            [SEO] {post.targetKeyword}
                                        </div>
                                        <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '0.95rem', marginBottom: '12px', lineHeight: 1.3 }}>
                                            {post.title}
                                        </div>
                                        
                                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: 'auto', paddingTop: '12px', borderTop: '1px dashed #E2E8F0' }}>
                                            <div style={{ fontSize: '0.75rem', color: '#64748B', display: 'flex', alignItems: 'center', gap: '4px' }}>
                                                <Clock size={12}/> {new Date(post.dueDate).toLocaleDateString(undefined, { month: 'short', day: 'numeric' })}
                                            </div>
                                            <div style={{ fontSize: '0.75rem', color: '#475569', fontWeight: 600 }}>
                                                {post.author}
                                            </div>
                                        </div>

                                        {/* Action buttons (simplified for visualization) */}
                                        <div style={{ display: 'flex', justifyContent: 'flex-end', marginTop: '12px', gap: '8px' }}>
                                            {col.id === 'IDEATION' && <button onClick={() => movePost(post.id, 'DRAFTING')} style={{ background: 'none', border: 'none', color: '#3B82F6', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '4px', fontSize: '0.75rem', fontWeight: 700 }}><ArrowRight size={14}/> Draft</button>}
                                            {col.id === 'DRAFTING' && <button onClick={() => movePost(post.id, 'MEDICAL_REVIEW')} style={{ background: 'none', border: 'none', color: '#F59E0B', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '4px', fontSize: '0.75rem', fontWeight: 700 }}><ArrowRight size={14}/> Med Review</button>}
                                            {col.id === 'MEDICAL_REVIEW' && <button onClick={() => movePost(post.id, 'LEGAL_REVIEW')} style={{ background: 'none', border: 'none', color: '#DC2626', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '4px', fontSize: '0.75rem', fontWeight: 700 }}><ArrowRight size={14}/> Leg Review</button>}
                                            {col.id === 'LEGAL_REVIEW' && <button onClick={() => movePost(post.id, 'PUBLISHED')} style={{ background: 'none', border: 'none', color: '#10B981', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '4px', fontSize: '0.75rem', fontWeight: 700 }}><ArrowRight size={14}/> Publish</button>}
                                        </div>
                                    </div>
                                ))}
                            </div>
                        </div>
                    );
                })}
            </div>
            
             <div style={{ marginTop: '16px', padding: '16px', backgroundColor: '#FEF2F2', borderRadius: '8px', border: '1px dashed #FECACA', fontSize: '0.85rem', color: '#991B1B', display: 'flex', gap: '8px' }}>
                <ShieldAlert size={20} style={{ flexShrink: 0 }} />
                <strong>Compliance Pipeline:</strong> Operating in healthcare requires strict oversight. Before an SEO article claiming "5 Warning Signs of Dementia" can be published to generate leads, this Kanban board physically forces a sign-off from both the Clinical Director and Legal Counsel to prevent dangerous medical liability.
            </div>
        </div>
    );
};
