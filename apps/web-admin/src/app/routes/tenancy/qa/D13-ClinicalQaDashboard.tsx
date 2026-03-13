// ================================================================
// PAGE IDENTITY: D13 � Clinical QA Dashboard
// Type: Dashboard | Owner: qa
// ================================================================
import React from 'react';

const ClinicalQaDashboard: React.FC = () => {
    return (
        <div data-cy="page.container" className="p-6 space-y-6 max-w-[1600px] mx-auto animate-in fade-in slide-in-from-bottom-4 duration-500">
            <header className="flex justify-between items-end">
                <div>
                    <h1 data-cy="page.title" className="text-3xl font-black text-slate-900 tracking-tight">CLINICAL QA & SAFETY</h1>
                    <p className="text-slate-500 font-medium">Quality Assurance & Medication Compliance Monitoring</p>
                </div>
                <div className="flex gap-3">
                    <button data-cy="btn-clinical-qa-dashboard-0" className="px-4 py-2 bg-white border border-slate-200 rounded-xl font-bold text-sm shadow-sm hover:bg-slate-50 transition-all">
                        Safety Report
                    </button>
                    <button data-cy="btn-clinical-qa-dashboard-1" className="px-4 py-2 bg-rose-600 text-white rounded-xl font-bold text-sm shadow-lg shadow-rose-100 hover:bg-rose-700 transition-all">
                        Flag Incident
                    </button>
                </div>
            </header>

            <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
                {[
                    { label: 'MAR Accuracy', val: '99.2%', change: '+0.4%', color: 'emerald' },
                    { label: 'Incident Rate', val: '0.8%', change: '-12%', color: 'emerald' },
                    { label: 'QA Audits', val: '24/25', change: '1 Pending', color: 'amber' },
                    { label: 'Patient Sat.', val: '4.8/5', change: 'Region High', color: 'indigo' }
                ].map(stat => (
                    <div key={stat.label} className="bg-white p-6 rounded-3xl border border-slate-100 shadow-sm group hover:border-rose-200 transition-all">
                        <p className="text-slate-400 text-xs font-black uppercase tracking-widest mb-2">{stat.label}</p>
                        <div className="flex items-end gap-3">
                            <h4 className="text-3xl font-black text-slate-800 tracking-tight">{stat.val}</h4>
                            <span className={`text-[10px] font-bold mb-1 text-slate-400`}>{stat.change}</span>
                        </div>
                    </div>
                ))}
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div className="lg:col-span-2 bg-white rounded-[2.5rem] border border-slate-100 shadow-sm overflow-hidden">
                    <div className="p-8 border-b border-slate-50 bg-slate-50/30 flex justify-between items-center">
                        <h3 data-cy="h3-clinical-qa-dashboard-0" className="font-black text-slate-800 tracking-tight uppercase text-sm">Medication Compliance Heatmap</h3>
                        <div className="flex gap-2">
                            <div className="px-3 py-1 bg-emerald-100 text-emerald-700 text-[10px] font-black rounded-lg">ACTIVE</div>
                        </div>
                    </div>
                    <div className="p-8 h-80 flex items-center justify-center bg-[radial-gradient(circle_at_center,_var(--tw-gradient-stops))] from-white to-slate-50">
                        <div className="text-center">
                            <div className="text-6xl mb-4 group-hover:scale-110 transition-transform cursor-default">🫀</div>
                            <p className="text-slate-400 text-xs font-medium">Regional Health Metrics are 100% Synced</p>
                        </div>
                    </div>
                </div>

                <div className="space-y-6">
                    <div className="bg-rose-600 rounded-[2.5rem] p-8 text-white shadow-xl shadow-rose-100 relative overflow-hidden group">
                        <div className="absolute top-0 right-0 p-8 opacity-20 group-hover:scale-125 transition-transform">
                            <span className="text-6xl font-black">⚠️</span>
                        </div>
                        <h3 data-cy="h3-clinical-qa-dashboard-1" className="text-rose-200 font-black text-[10px] uppercase tracking-widest mb-4">Critical Safety Alerts</h3>
                        <div className="space-y-4 relative z-10">
                            <div className="p-4 bg-white/10 rounded-2xl backdrop-blur-md">
                                <p className="text-xs font-bold leading-tight">MAR Discrepancy detected in North Region</p>
                                <p className="text-[10px] opacity-60 mt-1">20 mins ago</p>
                            </div>
                            <div className="p-4 bg-white/10 rounded-2xl backdrop-blur-md">
                                <p className="text-xs font-bold leading-tight">Fall incident report pending RN review</p>
                                <p className="text-[10px] opacity-60 mt-1">1h ago</p>
                            </div>
                        </div>
                        <button data-cy="btn-clinical-qa-dashboard-2" className="w-full mt-8 py-3 bg-white text-rose-600 rounded-2xl text-xs font-bold hover:bg-rose-50 transition-all">
                            Investigate All
                        </button>
                    </div>

                    <div className="bg-white rounded-[2.5rem] p-8 border border-slate-100 shadow-sm">
                        <h3 data-cy="h3-clinical-qa-dashboard-2" className="text-slate-400 font-black text-[10px] uppercase tracking-widest mb-6">QA Audit Progress</h3>
                        <div className="space-y-4">
                            {[
                                { name: 'Medication Safety', progress: 100 },
                                { name: 'Client Documentation', progress: 85 },
                                { name: 'Care Plan Frequency', progress: 60 }
                            ].map(audit => (
                                <div key={audit.name}>
                                    <div className="flex justify-between text-xs font-bold mb-1">
                                        <span>{audit.name}</span>
                                        <span>{audit.progress}%</span>
                                    </div>
                                    <div className="h-1.5 w-full bg-slate-50 rounded-full overflow-hidden">
                                        <div className="h-full bg-slate-200 rounded-full" style={{ width: `${audit.progress}%` }} />
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default ClinicalQaDashboard;
