import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

const ClinicalCarePlans: React.FC = () => {
    const { t } = useTranslation();
    const [searchTerm, setSearchTerm] = useState('');
    const [carePlans, setCarePlans] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [isEditorOpen, setIsEditorOpen] = useState(false);
    const [selectedPlan, setSelectedPlan] = useState<any>(null);

    useEffect(() => {
        fetchPlans();
    }, []);

    const fetchPlans = async () => {
        try {
            const token = localStorage.getItem('token');
            const res = await fetch(`${import.meta.env.VITE_API_URL}${ApiRegistry.RN.CARE_PLANS}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (res.ok) {
                const data = await res.json();
                setCarePlans(data);
            }
        } catch (err) {
            console.error('Failed to fetch care plans', err);
        } finally {
            setLoading(false);
        }
    };

    const handleEdit = (plan: any) => {
        setSelectedPlan(plan);
        setIsEditorOpen(true);
    };

    const handleSave = async (updatedPlan: any) => {
        try {
            const token = localStorage.getItem('token');
            const res = await fetch(`${import.meta.env.VITE_API_URL}${ApiRegistry.RN.CARE_PLAN_REVIEW(updatedPlan.id)}`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(updatedPlan)
            });
            if (res.ok) {
                await fetchPlans();
                setIsEditorOpen(false);
            }
        } catch (err) {
            console.error('Failed to save care plan', err);
        }
    };

    return (
        <div data-cy="page.container">
            <header style={{ marginBottom: '2.5rem', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                <div>
                    <h1 style={{ margin: '0 0 6px 0', fontSize: '34px', letterSpacing: '.2px', color: 'var(--text-100)' }} data-cy="page.title">
                        {t(ContentRegistry.MENU.CARE_PLANS)}
                    </h1>
                    <p className="sub" style={{ margin: 0 }} data-cy="page.subtitle">
                        Manage clinical protocols and healthcare goals.
                    </p>
                </div>
                <button className="btn btn-primary" onClick={() => setIsEditorOpen(true)} data-cy="btn-new-plan">
                    + New Care Plan
                </button>
            </header>

            <div className="pc-card" style={{ marginBottom: '32px' }}>
                <div style={{ padding: '20px', borderBottom: '1px solid var(--card-border)' }}>
                    <input
                        type="text"
                        placeholder="Search patients or diagnoses..."
                        className="pc-input"
                        style={{ width: '100%', maxWidth: '400px' }}
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                        data-cy="search-plans"
                    />
                </div>
                <div style={{ overflowX: 'auto' }}>
                    <table style={{ width: '100%', borderCollapse: 'separate', borderSpacing: 0 }}>
                        <thead>
                            <tr style={{ background: 'rgba(255,255,255,0.02)', textAlign: 'left' }}>
                                <th style={{ padding: '16px 24px', fontSize: '11px', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '1px', color: 'var(--text-300)' }}>Client</th>
                                <th style={{ padding: '16px 24px', fontSize: '11px', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '1px', color: 'var(--text-300)' }}>Diagnoses</th>
                                <th style={{ padding: '16px 24px', fontSize: '11px', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '1px', color: 'var(--text-300)' }}>Status</th>
                                <th style={{ padding: '16px 24px', fontSize: '11px', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '1px', color: 'var(--text-300)' }}>Next Review</th>
                                <th style={{ padding: '16px 24px', textAlign: 'right' }}></th>
                            </tr>
                        </thead>
                        <tbody>
                            {loading ? (
                                <tr><td colSpan={5} style={{ padding: '40px', textAlign: 'center', color: 'var(--text-300)' }}>Loading clinical registry...</td></tr>
                            ) : carePlans.length === 0 ? (
                                <tr><td colSpan={5} style={{ padding: '40px', textAlign: 'center', color: 'var(--text-300)' }}>No care plans found.</td></tr>
                            ) : (
                                carePlans.map(plan => (
                                    <tr key={plan.id} style={{ borderTop: '1px solid var(--card-border)' }}>
                                        <td style={{ padding: '20px 24px', fontWeight: 600, color: 'var(--text-100)' }}>{plan.client?.fullName}</td>
                                        <td style={{ padding: '20px 24px' }}>
                                            <div style={{ display: 'flex', gap: '8px', flexWrap: 'wrap' }}>
                                                {plan.diagnoses?.map((d: string) => (
                                                    <span key={d} className="badge" style={{ fontSize: '10px' }}>{d}</span>
                                                ))}
                                            </div>
                                        </td>
                                        <td style={{ padding: '20px 24px' }}>
                                            <span style={{
                                                padding: '4px 10px',
                                                borderRadius: '20px',
                                                fontSize: '11px',
                                                fontWeight: 900,
                                                background: plan.status === 'active' ? 'rgba(76,175,80,0.1)' : 'rgba(255,152,0,0.1)',
                                                color: plan.status === 'active' ? '#4caf50' : '#ff9800'
                                            }}>
                                                {plan.status.toUpperCase()}
                                            </span>
                                        </td>
                                        <td style={{ padding: '20px 24px', color: 'var(--text-300)', fontSize: '13px' }}>
                                            {plan.reviewDate ? new Date(plan.reviewDate).toLocaleDateString() : 'TBD'}
                                        </td>
                                        <td style={{ padding: '20px 24px', textAlign: 'right' }}>
                                            <button className="btn btn-ghost" onClick={() => handleEdit(plan)} data-cy={`btn-edit-${plan.id}`}>Edit</button>
                                        </td>
                                    </tr>
                                ))
                            )}
                        </tbody>
                    </table>
                </div>
            </div>

            {/* Advanced Care Plan Editor Modal */}
            {isEditorOpen && (
                <div className="pc-modal-overlay" style={{ position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.8)', zIndex: 1000, display: 'flex', alignItems: 'center', justifyContent: 'center', backdropFilter: 'blur(10px)' }}>
                    <div className="pc-card bento-item animate-float" style={{ width: '90%', maxWidth: '800px', maxHeight: '90vh', overflowY: 'auto', padding: '40px' }}>
                        <h2 style={{ fontSize: '24px', fontWeight: 900, color: 'var(--text-100)', marginBottom: '8px' }}>
                            {selectedPlan ? 'Edit Clinical Protocol' : 'New Clinical Protocol'}
                        </h2>
                        <p style={{ color: 'var(--text-300)', marginBottom: '32px' }}>Define healthcare goals and nursing interventions.</p>

                        <div style={{ display: 'grid', gap: '24px' }}>
                            <div className="group">
                                <label style={{ display: 'block', fontSize: '11px', fontWeight: 900, textTransform: 'uppercase', color: 'var(--text-300)', marginBottom: '8px' }}>Diagnoses</label>
                                <input
                                    className="pc-input"
                                    defaultValue={selectedPlan?.diagnoses?.join(', ')}
                                    placeholder="e.g. Hypertension, Osteoarthritis"
                                    style={{ width: '100%' }}
                                />
                            </div>

                            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '20px' }}>
                                <div className="group">
                                    <label style={{ display: 'block', fontSize: '11px', fontWeight: 900, textTransform: 'uppercase', color: 'var(--text-300)', marginBottom: '8px' }}>Status</label>
                                    <select className="pc-input" defaultValue={selectedPlan?.status || 'active'} style={{ width: '100%' }}>
                                        <option value="active">Active</option>
                                        <option value="completed">Completed</option>
                                        <option value="archived">Archived</option>
                                    </select>
                                </div>
                                <div className="group">
                                    <label style={{ display: 'block', fontSize: '11px', fontWeight: 900, textTransform: 'uppercase', color: 'var(--text-300)', marginBottom: '8px' }}>Next Review Date</label>
                                    <input
                                        type="date"
                                        className="pc-input"
                                        defaultValue={selectedPlan?.reviewDate?.split('T')[0]}
                                        style={{ width: '100%' }}
                                    />
                                </div>
                            </div>

                            <div className="group">
                                <label style={{ display: 'block', fontSize: '11px', fontWeight: 900, textTransform: 'uppercase', color: 'var(--text-300)', marginBottom: '8px' }}>Clinical Goals</label>
                                <textarea
                                    className="pc-input"
                                    style={{ width: '100%', minHeight: '100px' }}
                                    placeholder="Describe the primary medical outcomes..."
                                    defaultValue={JSON.stringify(selectedPlan?.clinicalGoals, null, 2)}
                                />
                            </div>

                            <div className="group">
                                <label style={{ display: 'block', fontSize: '11px', fontWeight: 900, textTransform: 'uppercase', color: 'var(--text-300)', marginBottom: '8px' }}>Nursing Interventions</label>
                                <textarea
                                    className="pc-input"
                                    style={{ width: '100%', minHeight: '100px' }}
                                    placeholder="Specific tasks for PSWs/RNs..."
                                    defaultValue={JSON.stringify(selectedPlan?.interventions, null, 2)}
                                />
                            </div>
                        </div>

                        <div style={{ marginTop: '40px', display: 'flex', gap: '12px', justifyContent: 'flex-end' }}>
                            <button className="btn btn-ghost" onClick={() => setIsEditorOpen(false)}>Cancel</button>
                            <button className="btn btn-primary" onClick={() => setIsEditorOpen(false)}>Deploy Protocol</button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default ClinicalCarePlans;
