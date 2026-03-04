import React from 'react';

const SupervisionHub: React.FC = () => {
    const providers = [
        { id: '1', name: 'John Davis', role: 'PSW', visits: 42, qualityScore: 98, certs: 'Compliant', risk: 'Low' },
        { id: '2', name: 'Samantha Reed', role: 'PSW', visits: 38, qualityScore: 85, certs: 'Expiring Soon', risk: 'Medium' },
        { id: '3', name: 'Michael Chen', role: 'PSW', visits: 15, qualityScore: 92, certs: 'Compliant', risk: 'Low' },
    ];

    return (
        <div className="p-6 space-y-6">
            <header>
                <h1 className="text-2xl font-bold text-slate-900">Clinical Supervision Hub</h1>
                <p className="text-slate-500">Monitor provider performance and maintain clinical standards across the branch.</p>
            </header>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-200">
                    <p className="text-slate-500 text-sm font-semibold uppercase mb-1">Avg Quality Score</p>
                    <div className="flex items-end gap-2 text-3xl font-bold text-indigo-600">
                        92%
                        <span className="text-emerald-500 text-sm mb-1 font-bold">▲ 2.4%</span>
                    </div>
                </div>
                <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-200">
                    <p className="text-slate-500 text-sm font-semibold uppercase mb-1">Certs at Risk</p>
                    <div className="flex items-end gap-2 text-3xl font-bold text-amber-600">
                        3
                        <span className="text-slate-400 text-sm mb-1 font-medium">Providers</span>
                    </div>
                </div>
                <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-200">
                    <p className="text-slate-500 text-sm font-semibold uppercase mb-1">Supervised PSWs</p>
                    <div className="flex items-end gap-2 text-3xl font-bold text-slate-900">
                        24
                        <span className="text-slate-400 text-sm mb-1 font-medium">Active</span>
                    </div>
                </div>
            </div>

            <div className="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
                <div className="p-4 border-b border-slate-100 bg-slate-50/50 flex justify-between items-center">
                    <h2 className="font-bold text-slate-800">Caregiver Roster</h2>
                    <button className="text-indigo-600 text-sm font-semibold hover:underline">View All Providers</button>
                </div>
                <table className="w-full text-left">
                    <thead className="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider">
                        <tr>
                            <th className="px-6 py-4 font-semibold">Provider</th>
                            <th className="px-6 py-4 font-semibold text-center">Visits (30d)</th>
                            <th className="px-6 py-4 font-semibold text-center">Quality Score</th>
                            <th className="px-6 py-4 font-semibold">Compliance</th>
                            <th className="px-6 py-4 font-semibold">Risk Level</th>
                            <th className="px-6 py-4 font-semibold text-right">Action</th>
                        </tr>
                    </thead>
                    <tbody className="divide-y divide-slate-100">
                        {providers.map(p => (
                            <tr key={p.id} className="hover:bg-slate-50 transition-colors">
                                <td className="px-6 py-4 font-medium text-slate-900">{p.name}</td>
                                <td className="px-6 py-4 text-center text-slate-600">{p.visits}</td>
                                <td className="px-6 py-4 text-center text-slate-600 font-bold">{p.qualityScore}%</td>
                                <td className="px-6 py-4">
                                    <span className={`px-3 py-1 rounded-full text-xs font-semibold ${p.certs === 'Compliant' ? 'bg-emerald-100 text-emerald-700' : 'bg-rose-100 text-rose-700'
                                        }`}>
                                        {p.certs}
                                    </span>
                                </td>
                                <td className="px-6 py-4">
                                    <span className={`font-semibold text-sm ${p.risk === 'Low' ? 'text-emerald-600' : 'text-amber-600'
                                        }`}>
                                        {p.risk}
                                    </span>
                                </td>
                                <td className="px-6 py-4 text-right">
                                    <button className="text-indigo-600 font-semibold hover:underline">Supervise</button>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>

            <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-200">
                <h3 className="font-bold text-slate-900 mb-4">Required Field Audits</h3>
                <div className="space-y-3">
                    <div className="flex justify-between items-center p-3 hover:bg-slate-50 rounded-xl transition-colors cursor-pointer border border-transparent hover:border-slate-100">
                        <div className="flex items-center gap-3">
                            <div className="w-10 h-10 bg-indigo-50 text-indigo-600 rounded-lg flex items-center justify-center font-bold">JD</div>
                            <div>
                                <p className="font-bold text-slate-800 text-sm">John Davis</p>
                                <p className="text-slate-500 text-xs">Complex wound care assessment</p>
                            </div>
                        </div>
                        <span className="text-xs bg-slate-100 px-2 py-1 rounded text-slate-600">Due in 2 days</span>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default SupervisionHub;
