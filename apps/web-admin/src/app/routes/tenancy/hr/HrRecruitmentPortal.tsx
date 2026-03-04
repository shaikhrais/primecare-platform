import React from 'react';

const HrRecruitmentPortal: React.FC = () => {
    return (
        <div className="p-6 space-y-6 max-w-[1600px] mx-auto animate-in fade-in slide-in-from-bottom-4 duration-500">
            <header className="flex justify-between items-end">
                <div>
                    <h1 className="text-3xl font-black text-slate-900 tracking-tight">TALENT & COMPLIANCE</h1>
                    <p className="text-slate-500 font-medium">HR Operations & Recruitment Pipeline</p>
                </div>
                <div className="flex gap-3">
                    <button className="px-4 py-2 bg-white border border-slate-200 rounded-xl font-bold text-sm shadow-sm hover:bg-slate-50 transition-all">
                        Onboarding Guide
                    </button>
                    <button className="px-4 py-2 bg-indigo-600 text-white rounded-xl font-bold text-sm shadow-lg shadow-indigo-100 hover:bg-indigo-700 transition-all">
                        Post Core Role
                    </button>
                </div>
            </header>

            <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
                {[
                    { label: 'Active Pipeline', val: '42', change: '+5 this week', color: 'indigo' },
                    { label: 'Onboarding', val: '12', change: '8 on track', color: 'emerald' },
                    { label: 'Expiring Certs', val: '8', change: 'Action Required', color: 'rose' },
                    { label: 'Avg Time to Hire', val: '14d', change: '-2d vs last mth', color: 'amber' }
                ].map(stat => (
                    <div key={stat.label} className="bg-white p-6 rounded-3xl border border-slate-100 shadow-sm">
                        <p className="text-slate-400 text-xs font-black uppercase tracking-widest mb-2">{stat.label}</p>
                        <div className="flex items-end gap-3">
                            <h4 className="text-3xl font-black text-slate-800 tracking-tight">{stat.val}</h4>
                            <span className={`text-[10px] font-bold mb-1 ${stat.color === 'rose' ? 'text-rose-500' : 'text-slate-400'
                                }`}>{stat.change}</span>
                        </div>
                    </div>
                ))}
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div className="lg:col-span-2 bg-white rounded-3xl border border-slate-100 shadow-sm overflow-hidden">
                    <div className="p-6 border-b border-slate-50 flex justify-between items-center bg-slate-50/20">
                        <h2 className="font-bold text-slate-800 uppercase tracking-tight text-sm">Recruitment Funnel</h2>
                        <div className="flex gap-2">
                            <span className="w-3 h-3 rounded-full bg-slate-100" />
                            <span className="w-3 h-3 rounded-full bg-slate-200" />
                        </div>
                    </div>
                    <div className="p-8 space-y-8">
                        {[
                            { step: 'Applied', count: 180, percentage: 100, color: 'bg-slate-200' },
                            { step: 'Screening', count: 45, percentage: 25, color: 'bg-indigo-400' },
                            { step: 'Interview', count: 12, percentage: 7, color: 'bg-indigo-600' },
                            { step: 'Offer', count: 3, percentage: 2, color: 'bg-emerald-500' }
                        ].map(flow => (
                            <div key={flow.step}>
                                <div className="flex justify-between items-end mb-2">
                                    <span className="text-sm font-bold text-slate-700">{flow.step}</span>
                                    <span className="text-xs font-mono text-slate-400">{flow.count} candidates</span>
                                </div>
                                <div className="w-full bg-slate-50 h-2 rounded-full overflow-hidden">
                                    <div
                                        className={`${flow.color} h-full transition-all duration-1000`}
                                        style={{ width: `${flow.percentage}%` }}
                                    />
                                </div>
                            </div>
                        ))}
                    </div>
                </div>

                <div className="bg-slate-900 rounded-3xl shadow-xl p-8 text-white">
                    <h3 className="text-indigo-400 font-black text-[10px] uppercase tracking-widest mb-6 border-b border-slate-800 pb-4">Compliance Alerts</h3>
                    <div className="space-y-6">
                        {[
                            { name: 'John Doe (PSW)', cert: 'CPR Recert', due: 'IN 2 DAYS' },
                            { name: 'Alice Smith (RN)', cert: 'VSS Update', due: 'EXPIRED' },
                            { name: 'Michael Lee (PSW)', cert: 'HCA Certification', due: 'IN 5 DAYS' }
                        ].map(alert => (
                            <div key={alert.name} className="flex flex-col gap-1 group cursor-pointer">
                                <p className="text-sm font-bold group-hover:text-indigo-300 transition-colors">{alert.name}</p>
                                <div className="flex justify-between items-center">
                                    <span className="text-xs text-slate-500">{alert.cert}</span>
                                    <span className={`text-[10px] font-black px-2 py-0.5 rounded ${alert.due === 'EXPIRED' ? 'bg-rose-500/20 text-rose-400' : 'bg-amber-500/20 text-amber-400'
                                        }`}>{alert.due}</span>
                                </div>
                            </div>
                        ))}
                    </div>
                    <button className="w-full mt-8 py-3 bg-white/5 border border-white/10 rounded-2xl text-xs font-bold hover:bg-white/10 transition-all">
                        Bulk Notify
                    </button>
                </div>
            </div>
        </div>
    );
};

export default HrRecruitmentPortal;
