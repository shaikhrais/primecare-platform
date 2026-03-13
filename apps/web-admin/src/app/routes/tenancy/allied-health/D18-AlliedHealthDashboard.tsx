// ================================================================
// PAGE IDENTITY: D18 · Allied Health Dashboard
// Type: Dashboard | Owner: allied
// ================================================================
import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

const AlliedHealthDashboard: React.FC = () => {
    const { t } = useTranslation();

    const stats = [
        { label: 'Upcoming Treatments', value: '4', color: '#6366f1' },
        { label: 'Pending Sign-offs', value: '2', color: '#f59e0b' },
        { label: 'Historical Reviews', value: '12', color: '#10b981' }
    ];

    return (
        <div className="p-6 space-y-6 max-w-[1600px] mx-auto animate-in fade-in slide-in-from-bottom-4 duration-500">
            <header className="flex justify-between items-end">
                <div>
                    <h1 className="text-3xl font-black text-slate-900 tracking-tight">ALLIED HEALTH HUB</h1>
                    <p className="text-slate-500 font-medium">Clinical RMT / RPT / RCH Operations</p>
                </div>
                <div className="flex gap-3">
                    <button className="px-4 py-2 bg-white border border-slate-200 rounded-xl font-bold text-sm shadow-sm hover:bg-slate-50 transition-all">
                        Treatment History
                    </button>
                    <button
                        data-cy="btn-allied-sign-visit"
                        className="px-4 py-2 bg-indigo-600 text-white rounded-xl font-bold text-sm shadow-lg shadow-indigo-100 hover:bg-indigo-700 transition-all"
                    >
                        Sign Clinical Note
                    </button>
                </div>
            </header>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                {stats.map(s => (
                    <div key={s.label} className="bg-white p-8 rounded-3xl shadow-sm border border-slate-100">
                        <p className="text-slate-400 text-[10px] font-black uppercase tracking-widest mb-2">{s.label}</p>
                        <h4 className="text-3xl font-black text-slate-800 tracking-tight">{s.value}</h4>
                    </div>
                ))}
            </div>

            <div className="pc-card">
                <div className="pc-card-b p-8 text-center text-slate-400 italic">
                    Allied Health Treatment Queue is currently up to date.
                </div>
            </div>
        </div>
    );
};

export default AlliedHealthDashboard;
