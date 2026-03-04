import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

const ClinicalCarePlans: React.FC = () => {
    const [searchTerm, setSearchTerm] = useState('');

    const carePlans = [
        { id: '1', client: 'Alice Thompson', status: 'Active', goal: 'Reduce fall risk by improving gait stability', diagnoses: ['Osteoarthritis', 'Gait Imbalance'], reviewDate: '2026-03-20' },
        { id: '2', client: 'Bob Richards', status: 'Requires Review', goal: 'Manage hypertension and monitor fluid intake', diagnoses: ['Hypertension', 'CHF'], reviewDate: '2026-03-01' },
        { id: '3', client: 'Catherine Lee', status: 'Active', goal: 'Post-operative wound care and infection monitoring', diagnoses: ['Hip Replacement'], reviewDate: '2026-04-12' },
    ];

    return (
        <div className="p-6 space-y-6">
            <header className="flex justify-between items-center">
                <div>
                    <h1 className="text-2xl font-bold text-slate-900">Clinical Care Plans</h1>
                    <p className="text-slate-500">Manage medical protocols and clinical goals for all clients.</p>
                </div>
                <button className="px-4 py-2 bg-indigo-600 text-white rounded-lg font-medium hover:bg-indigo-700 transition-colors shadow-sm">
                    + New Care Plan
                </button>
            </header>

            <div className="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
                <div className="p-4 border-b border-slate-100 bg-slate-50/50 flex gap-4">
                    <input
                        type="text"
                        placeholder="Search clients or diagnoses..."
                        className="flex-1 px-4 py-2 border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-indigo-500/20"
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                    />
                </div>
                <table className="w-full text-left">
                    <thead className="bg-slate-50 text-slate-500 text-sm uppercase tracking-wider">
                        <tr>
                            <th className="px-6 py-4 font-semibold">Client</th>
                            <th className="px-6 py-4 font-semibold">Primary Goal</th>
                            <th className="px-6 py-4 font-semibold">Diagnoses</th>
                            <th className="px-6 py-4 font-semibold">Status</th>
                            <th className="px-6 py-4 font-semibold">Last Review</th>
                            <th className="px-6 py-4 font-semibold text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody className="divide-y divide-slate-100">
                        {carePlans.map(plan => (
                            <tr key={plan.id} className="hover:bg-slate-50 transition-colors">
                                <td className="px-6 py-4 font-medium text-slate-900">{plan.client}</td>
                                <td className="px-6 py-4 text-slate-600 max-w-xs truncate">{plan.goal}</td>
                                <td className="px-6 py-4">
                                    <div className="flex flex-wrap gap-1">
                                        {plan.diagnoses.map(d => (
                                            <span key={d} className="px-2 py-0.5 bg-slate-100 text-slate-600 text-xs rounded-full border border-slate-200">{d}</span>
                                        ))}
                                    </div>
                                </td>
                                <td className="px-6 py-4">
                                    <span className={`px-3 py-1 rounded-full text-xs font-semibold ${plan.status === 'Active' ? 'bg-emerald-100 text-emerald-700' : 'bg-amber-100 text-amber-700'
                                        }`}>
                                        {plan.status}
                                    </span>
                                </td>
                                <td className="px-6 py-4 text-slate-500 text-sm">{plan.reviewDate}</td>
                                <td className="px-6 py-4 text-right">
                                    <button className="text-indigo-600 font-semibold hover:underline">Edit</button>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div className="bg-gradient-to-br from-indigo-50 to-white p-6 rounded-2xl border border-indigo-100 shadow-sm">
                    <h3 className="text-indigo-900 font-bold mb-2">💡 Clinical Best Practice</h3>
                    <p className="text-indigo-700 text-sm leading-relaxed">
                        Ensure care plans are reviewed every 30 days or after any hospital discharge. Use the "Digital Signature" feature to finalize updates.
                    </p>
                </div>
                <div className="bg-gradient-to-br from-slate-800 to-slate-900 p-6 rounded-2xl border border-slate-700 shadow-xl text-white">
                    <h3 className="font-bold flex items-center gap-2 mb-2">
                        <span>🪄</span> Clinical AI Insights
                    </h3>
                    <p className="text-slate-300 text-sm leading-relaxed">
                        Predictive modeling suggests a 15% increase in gait instability for patients with Osteoarthritis during seasonal changes.
                    </p>
                    <button className="mt-4 text-xs bg-white/10 hover:bg-white/20 px-3 py-1.5 rounded-lg transition-colors border border-white/10">
                        View Detailed Forecast →
                    </button>
                </div>
            </div>
        </div>
    );
};

export default ClinicalCarePlans;
