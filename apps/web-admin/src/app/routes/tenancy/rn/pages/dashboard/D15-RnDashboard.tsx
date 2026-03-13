// ================================================================
// PAGE IDENTITY: D15 � RN Dashboard
// Type: Dashboard | Owner: rn
// ================================================================
import React, { useState } from 'react';
import { useAuth } from '@/shared/context/AuthContext';
import { ClinicalSplitView } from './components/ClinicalSplitView';
import { AdmissionAssessment } from '../assessments/components/AdmissionAssessment';
import { ScribeAI } from '../assessments/components/ScribeAI';
import { SignaturePad } from '../assessments/components/SignaturePad';
import { VitalSparkline } from '@/shared/components/charts/VitalSparkline';
import { AlertTriangle, Activity, Pill, User, Wand2, Pen } from 'lucide-react';
import { AdminRegistry } from 'prime-care-shared';

export const Dashboard: React.FC = () => {
    const { user } = useAuth();
    const [activeAssessment, setActiveAssessment] = useState<string | null>('pat_123');
    const [showScribe, setShowScribe] = useState(false);
    const [showPad, setShowPad] = useState(false);

    // Patient Context Sidebar Content
    const SidebarContext = () => (
        <>
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', borderBottom: '1px solid #E2E8F0', paddingBottom: '16px' }}>
                <div style={{ width: '48px', height: '48px', backgroundColor: '#CBD5E1', borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <User size={24} color="#475569" />
                </div>
                <div>
                    <h2 data-cy="h2-rn.rn-dashboard-0" style={{ margin: 0, fontSize: '1.2rem', fontWeight: 800, color: '#0F172A' }}>Beatrice Morrison</h2>
                    <div style={{ color: '#64748B', fontSize: '0.85rem', fontWeight: 600 }}>DOB: 1942-08-15 (84F)</div>
                </div>
            </div>

            <div>
                <h3 data-cy="h3-rn.rn-dashboard-0" style={{ fontSize: '0.75rem', fontWeight: 800, textTransform: 'uppercase', color: '#94A3B8', letterSpacing: '1px', marginBottom: '8px', display: 'flex', alignItems: 'center', gap: '6px' }}>
                    <Activity size={14} /> Vital Trends
                </h3>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                    {/* Suggestion 13: High-density inline sparklines */}
                    <VitalSparkline label="Systolic BP" data={[135, 142, 138, 145, 150, 160, 165]} currentValue={165} unit="mmHg" color="#EF4444" />
                    <VitalSparkline label="Heart Rate" data={[72, 75, 74, 80, 85, 82, 88]} currentValue={88} unit="bpm" color="#3B82F6" />
                </div>
            </div>

            <div>
                <h3 data-cy="h3-rn.rn-dashboard-1" style={{ fontSize: '0.75rem', fontWeight: 800, textTransform: 'uppercase', color: '#94A3B8', letterSpacing: '1px', marginBottom: '8px', display: 'flex', alignItems: 'center', gap: '6px' }}>
                    <AlertTriangle size={14} /> Active Alerts
                </h3>
                <div style={{ backgroundColor: '#FEF2F2', borderLeft: '4px solid #EF4444', padding: '12px', borderRadius: '0 8px 8px 0', fontSize: '0.85rem' }}>
                    <strong style={{ color: '#991B1B' }}>Allergy: PENICILLIN</strong><br />
                    <span style={{ color: '#B91C1C' }}>Reaction: Anaphylaxis</span>
                </div>
            </div>

            <div style={{ flex: 1 }}>
                <h3 data-cy="h3-rn.rn-dashboard-2" style={{ fontSize: '0.75rem', fontWeight: 800, textTransform: 'uppercase', color: '#94A3B8', letterSpacing: '1px', marginBottom: '8px', display: 'flex', alignItems: 'center', gap: '6px' }}>
                    <Pill size={14} /> Current Meds
                </h3>
                <ul style={{ margin: 0, paddingLeft: '20px', fontSize: '0.85rem', color: '#334155', display: 'flex', flexDirection: 'column', gap: '6px' }}>
                    <li>Metoprolol 50mg PO Daily</li>
                    <li>Lisinopril 10mg PO Daily</li>
                    <li>Atorvastatin 40mg PO QHS</li>
                </ul>
            </div>
        </>
    );

    return (
        <div data-cy="page.container" style={{ padding: '0 24px 24px 24px', maxWidth: '1400px', margin: '0 auto', boxSizing: 'border-box' }}>
            <div style={{ marginBottom: '1.5rem', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end' }}>
                <div>
                    <h1 style={{ margin: '0 0 4px 0', fontSize: '28px', fontWeight: 900, color: '#0F172A' }}>Clinical Review Hub</h1>
                    <p style={{ margin: 0, color: '#64748B', fontWeight: 600 }}>{user?.email || 'RN'} • Tablet Layout Optimized</p>
                </div>
                {activeAssessment && (
                    <div style={{ display: 'flex', gap: '12px' }}>
                        <button data-cy="btn-rn.rn-dashboard-0" 
                            onClick={() => setShowScribe(true)}
                            style={{ backgroundColor: '#EEF2FF', color: '#4F46E5', border: '1px solid #C7D2FE', padding: '10px 16px', borderRadius: '8px', cursor: 'pointer', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '8px' }}
                        >
                            <Wand2 size={18} /> Auto-Scribe SOAPIER
                        </button>
                        <button data-cy="btn-rn.rn-dashboard-1" 
                            onClick={() => setShowPad(true)}
                            style={{ backgroundColor: '#10B981', color: 'white', border: 'none', padding: '10px 16px', borderRadius: '8px', cursor: 'pointer', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '8px', boxShadow: '0 4px 6px -1px rgba(16, 185, 129, 0.3)' }}
                        >
                            <Pen size={18} /> Sign Assessment
                        </button>
                    </div>
                )}
            </div>

            {/* Suggestion 10: Split-Screen Charting */}
            <ClinicalSplitView
                sidebarContent={<SidebarContext />}
                mainContent={
                    activeAssessment ? (
                        <AdmissionAssessment patientId={activeAssessment} onComplete={() => setActiveAssessment(null)} />
                    ) : (
                        <div style={{ display: 'flex', height: '100%', alignItems: 'center', justifyContent: 'center', backgroundColor: '#F8FAFC', borderRadius: '12px', color: '#94A3B8', fontWeight: 600 }}>
                            Select a task from the roster to begin charting.
                        </div>
                    )
                }
            />

            {/* Modals placed at layout root level */}
            {showScribe && (
                <ScribeAI 
                    onClose={() => setShowScribe(false)} 
                    onSaveNotes={(data) => {
                        console.log("Attached AI Notes:", data);
                        setShowScribe(false);
                    }} 
                />
            )}

            {showPad && (
                <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 9999, padding: '24px' }}>
                    <div style={{ width: '100%', maxWidth: '700px' }}>
                        <SignaturePad 
                            onCancel={() => setShowPad(false)} 
                            onSign={(base64) => {
                                console.log("Saved base64 signature... length: ", base64.length);
                                setShowPad(false);
                            }} 
                        />
                    </div>
                </div>
            )}
        </div>
    );
};

export default Dashboard;
