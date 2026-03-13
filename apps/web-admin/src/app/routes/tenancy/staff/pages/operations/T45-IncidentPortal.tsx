import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry, ApiRegistry } from 'prime-care-shared';
import './IncidentPortal.css';

const { ContentRegistry } = AdminRegistry;

export default function IncidentPortal() {
    const { t } = useTranslation();
    const [type, setType] = useState('other');
    const [description, setDescription] = useState('');
    const [submitting, setSubmitting] = useState(false);
    const [success, setSuccess] = useState(false);

    const handleSubmit = async () => {
        if (!description) return;
        setSubmitting(true);
        try {
            const token = localStorage.getItem('token');
            const res = await fetch(`${import.meta.env.VITE_API_URL}${ApiRegistry.TENANCY.STAFF.INCIDENT_SUBMIT}`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    type,
                    description,
                }),
            });
            if (res.ok) {
                setSuccess(true);
                setDescription('');
            }
        } catch (error) {
            console.error('Failed to report incident:', error);
        } finally {
            setSubmitting(false);
        }
    };

    const protocolSteps = [
        { title: 'Immediate Stabilization', desc: 'Secure the area and provide immediate clinical support.' },
        { title: 'Witness statements', desc: 'Identify and document statements from present staff or family.' },
        { title: 'Evidence Preservation', desc: 'Secure any involved equipment or medical supplies.' },
        { title: 'Branch Notification', desc: 'Notify the clinical manager or regional operator immediately.' },
    ];

    if (success) {
        return (
            <div className="incident-portal flex flex-col items-center justify-center h-[60vh]">
                <div className="w-20 h-20 bg-green-100 text-green-600 rounded-full flex items-center justify-center text-3xl mb-6">✓</div>
                <h1 className="text-2xl font-black mb-2">Incident Reported</h1>
                <p className="text-muted-foreground mb-8">The operational team has been notified and triage has begun.</p>
                <button className="btn-modern btn-modern-primary" onClick={() => setSuccess(false)}>Report Another Event</button>
            </div>
        );
    }

    return (
        <div className="incident-portal">
            <header className="incident-header">
                <h1>{t(ContentRegistry.INCIDENTS.TITLE)}</h1>
                <p>{t(ContentRegistry.INCIDENTS.SUBTITLE)}</p>
            </header>

            <div className="incident-grid">
                <main className="incident-form-container">
                    <div className="field-group">
                        <label className="field-label">{t(ContentRegistry.INCIDENTS.FORM.TYPE_LABEL)}</label>
                        <select
                            className="modern-select"
                            value={type}
                            onChange={(e) => setType(e.target.value)}
                        >
                            <option value="fall_risk">Clinical: Fall Risk</option>
                            <option value="medical_emergency">Clinical: Medical Emergency</option>
                            <option value="safety">Operational: Safety Risk</option>
                            <option value="refusal">Operational: Service Refusal</option>
                            <option value="no_show">Staffing: No Show</option>
                            <option value="other">Other / Miscellaneous</option>
                        </select>
                    </div>

                    <div className="field-group">
                        <label className="field-label">{t(ContentRegistry.INCIDENTS.FORM.DESC_LABEL)}</label>
                        <textarea
                            className="modern-textarea"
                            rows={6}
                            placeholder="Provide a factual, clinical description of the event..."
                            value={description}
                            onChange={(e) => setDescription(e.target.value)}
                        />
                    </div>

                    <div className="flex justify-between items-center pt-8 border-t border-slate-100">
                        <button className="btn-modern btn-modern-secondary" disabled={submitting}>Save Draft</button>
                        <button
                            className="btn-modern btn-modern-primary"
                            disabled={submitting || !description}
                            onClick={handleSubmit}
                        >
                            {submitting ? 'Submitting...' : t(ContentRegistry.INCIDENTS.FORM.SUBMIT_BTN)}
                        </button>
                    </div>
                </main>

                <aside className="triage-assistance">
                    <h2>Staff Emergency Protocol</h2>
                    <div className="space-y-4">
                        {protocolSteps.map((step, i) => (
                            <div key={i} className="protocol-step">
                                <div className="step-number">{i + 1}</div>
                                <div className="step-text">
                                    <h4>{step.title}</h4>
                                    <p>{step.desc}</p>
                                </div>
                            </div>
                        ))}
                    </div>

                    <div className="emergency-hotline">
                        <div className="w-12 h-12 rounded-2xl bg-red-500 flex items-center justify-center text-xl">📞</div>
                        <div>
                            <div className="text-[10px] font-black uppercase opacity-60">Emergency Hotline</div>
                            <div className="hotline-number">1-800-CARE-911</div>
                        </div>
                    </div>
                </aside>
            </div>
        </div>
    );
}
