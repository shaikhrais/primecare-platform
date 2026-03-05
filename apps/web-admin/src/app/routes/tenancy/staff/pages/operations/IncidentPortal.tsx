import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import './IncidentPortal.css';

const { ContentRegistry } = AdminRegistry;

export default function IncidentPortal() {
    const { t } = useTranslation();
    const [severity, setSeverity] = useState<'critical' | 'moderate' | 'low'>('moderate');

    const protocolSteps = [
        { title: 'Immediate Stabilization', desc: 'Secure the area and provide immediate clinical support.' },
        { title: 'Witness statements', desc: 'Identify and document statements from present staff or family.' },
        { title: 'Evidence Preservation', desc: 'Secure any involved equipment or medical supplies.' },
        { title: 'Branch Notification', desc: 'Notify the clinical manager or regional operator immediately.' },
    ];

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
                        <select className="modern-select">
                            <option>Clinical Incident</option>
                            <option>Operational Risk</option>
                            <option>Security Breach</option>
                            <option>Documentation Gap</option>
                        </select>
                    </div>

                    <div className="field-group">
                        <label className="field-label">{t(ContentRegistry.INCIDENTS.FORM.SEVERITY_LABEL)}</label>
                        <div className="severity-selector">
                            <button
                                className={`severity-btn critical ${severity === 'critical' ? 'active' : ''}`}
                                onClick={() => setSeverity('critical')}
                            >
                                Critical
                            </button>
                            <button
                                className={`severity-btn moderate ${severity === 'moderate' ? 'active' : ''}`}
                                onClick={() => setSeverity('moderate')}
                            >
                                Moderate
                            </button>
                            <button
                                className={`severity-btn low ${severity === 'low' ? 'active' : ''}`}
                                onClick={() => setSeverity('low')}
                            >
                                Low
                            </button>
                        </div>
                    </div>

                    <div className="field-group">
                        <label className="field-label">Affected Patient / User</label>
                        <input type="text" className="modern-input" placeholder="Search customer registry..." />
                    </div>

                    <div className="field-group">
                        <label className="field-label">{t(ContentRegistry.INCIDENTS.FORM.DESC_LABEL)}</label>
                        <textarea
                            className="modern-textarea"
                            rows={6}
                            placeholder="Provide a factual, clinical description of the event..."
                        />
                    </div>

                    <div className="flex justify-between items-center pt-8 border-t border-slate-100">
                        <button className="btn-modern btn-modern-secondary">Save Draft</button>
                        <button className="btn-modern btn-modern-primary">{t(ContentRegistry.INCIDENTS.FORM.SUBMIT_BTN)}</button>
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

                    <div className="mt-12 p-6 rounded-2xl bg-white/5 border border-white/10 italic text-xs leading-relaxed opacity-70">
                        "Documenting incidents is not about assignment of blame, but about ensuring continuous care improvement and patient safety."
                    </div>
                </aside>
            </div>
        </div>
    );
}
