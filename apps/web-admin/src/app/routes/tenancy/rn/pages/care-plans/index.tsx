import React, { useEffect, useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './CarePlanManager.css';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

interface CarePlan {
    id: string;
    clientId: string;
    status: string;
    diagnoses: string[];
    clinicalGoals: any;
    interventions: any;
    reviewDate: string;
    client: {
        fullName: string;
    };
}

export const CarePlanManager: React.FC = () => {
    const [plans, setPlans] = useState<CarePlan[]>([]);
    const [loading, setLoading] = useState(true);
    const [selectedPlan, setSelectedPlan] = useState<CarePlan | null>(null);
    const [isModalOpen, setIsModalOpen] = useState(false);

    useEffect(() => {
        const fetchPlans = async () => {
            try {
                const response = await apiClient.get(ApiRegistry.TENANCY.RN.CARE_PLANS);
                if (Array.isArray(response)) {
                    setPlans(response);
                }
            } catch (error) {
                console.error('Failed to load care plans', error);
            } finally {
                setLoading(false);
            }
        };

        fetchPlans();
    }, []);

    const openPlan = (plan: CarePlan) => {
        setSelectedPlan(plan);
        setIsModalOpen(true);
    };

    if (loading) {
        return (
            <div className="plans-loading">
                <p>Establishing Clinical Control...</p>
            </div>
        );
    }

    return (
        <div className="care-plans-container" data-cy="care-plan-manager">
            <header className="assess-header">
                <h1 data-cy="page-title">{ContentRegistry.RN_CARE_PLAN.TITLE}</h1>
                <p data-cy="page-subtitle">{ContentRegistry.RN_CARE_PLAN.SUBTITLE}</p>
            </header>

            <div className="plan-grid">
                {plans.length > 0 ? (
                    plans.map((plan) => (
                        <div key={plan.id} className="plan-card" data-cy={`plan-card-${plan.id}`}>
                            <div className="plan-card-header">
                                <div className="plan-card-client">{plan.client?.fullName}</div>
                                <span className={`plan-card-status ${plan.status.toLowerCase()}`}>
                                    {plan.status}
                                </span>
                            </div>

                            <div className="plan-card-diagnoses">
                                {plan.diagnoses?.map((d, i) => (
                                    <span key={i} className="diag-tag">{d}</span>
                                ))}
                            </div>

                            <div className="plan-card-footer">
                                <div className="next-review">
                                    Review: <b>{new Date(plan.reviewDate).toLocaleDateString()}</b>
                                </div>
                                <button
                                    className="btn-premium"
                                    onClick={() => openPlan(plan)}
                                    data-cy={`btn-manage-${plan.id}`}
                                >
                                    Manage Plan
                                </button>
                            </div>
                        </div>
                    ))
                ) : (
                    <div className="empty-state">No active care plans identified.</div>
                )}
            </div>

            {isModalOpen && selectedPlan && (
                <div className="plan-modal" onClick={() => setIsModalOpen(false)}>
                    <div className="plan-modal-content" onClick={(e) => e.stopPropagation()}>
                        <h2 className="assess-card-title">{ContentRegistry.RN_CARE_PLAN.BUILDER_TITLE}</h2>
                        <p className="assess-card-desc">Patient: {selectedPlan.client?.fullName}</p>

                        <div style={{ marginTop: '2rem' }}>
                            <div className="form-section">
                                <label className="form-label">{ContentRegistry.RN_CARE_PLAN.FIELDS.DIAGNOSES}</label>
                                <input
                                    className="form-input"
                                    defaultValue={selectedPlan.diagnoses?.join(', ')}
                                />
                            </div>

                            <div className="form-section">
                                <label className="form-label">{ContentRegistry.RN_CARE_PLAN.FIELDS.GOALS}</label>
                                <textarea
                                    className="form-input"
                                    style={{ minHeight: '100px' }}
                                    defaultValue={typeof selectedPlan.clinicalGoals === 'string' ? selectedPlan.clinicalGoals : JSON.stringify(selectedPlan.clinicalGoals, null, 2)}
                                />
                            </div>

                            <div className="form-section">
                                <label className="form-label">{ContentRegistry.RN_CARE_PLAN.FIELDS.INTERVENTIONS}</label>
                                <textarea
                                    className="form-input"
                                    style={{ minHeight: '100px' }}
                                    defaultValue={typeof selectedPlan.interventions === 'string' ? selectedPlan.interventions : JSON.stringify(selectedPlan.interventions, null, 2)}
                                />
                            </div>
                        </div>

                        <div className="builder-controls">
                            <button className="btn btn-ghost" onClick={() => setIsModalOpen(false)}>Cancel</button>
                            <button className="btn-premium" data-cy="btn-save-plan">
                                {AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-rn-careplan-verify')?.label || 'Verify Care Plan'}
                            </button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default CarePlanManager;
