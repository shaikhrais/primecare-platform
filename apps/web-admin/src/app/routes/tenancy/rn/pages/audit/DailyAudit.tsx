import React from 'react';

const DailyAudit: React.FC = () => {
    const pendingEntries = [
        { id: '1', provider: 'John Davis (PSW)', client: 'Alice Thompson', visitId: 'VST-8821', time: 'Today 10:00 AM', highlights: 'Medication administered, no side effects noted. Mobility stable.' },
        { id: '2', provider: 'Samantha Reed (PSW)', client: 'Bob Richards', visitId: 'VST-8822', time: 'Today 08:30 AM', highlights: 'BP slightly elevated (145/92). Recommended rest and hydration.' },
        { id: '3', provider: 'John Davis (PSW)', client: 'Catherine Lee', visitId: 'VST-8823', time: 'Yesterday 04:00 PM', highlights: 'Assisted with partial bath. Client reported minor discomfort.' },
    ];

    return (
        <div className="p-6 space-y-6">
            <header>
                <h1 className="text-2xl font-bold text-slate-900">Registered Nurse Daily Audit</h1>
                <p className="text-slate-500">Review and verify provider daily care entries for clinical accuracy.</p>
            </header>

            <div className="grid grid-cols-1 gap-4">
                {pendingEntries.map(entry => (
                    <div key={entry.id} className="bg-white p-5 rounded-2xl shadow-sm border border-slate-200 flex flex-col md:flex-row gap-6 items-start hover:border-indigo-300 hover:shadow-md transition-all group">
                        <div className="flex-1">
                            <div className="flex items-center gap-3 mb-2">
                                <span className="text-sm font-bold text-indigo-600 bg-indigo-50 px-2 py-0.5 rounded uppercase tracking-tighter">{entry.visitId}</span>
                                <span className="text-slate-400">•</span>
                                <span className="text-slate-500 text-sm">{entry.time}</span>
                            </div>
                            <h3 className="text-lg font-bold text-slate-900 mb-1">{entry.client}</h3>
                            <p className="text-sm text-slate-500 mb-3">Documented by <span className="font-semibold text-slate-700">{entry.provider}</span></p>
                            <div className="bg-slate-50 p-4 rounded-xl border border-slate-100 group-hover:bg-indigo-50/30 group-hover:border-indigo-100 transition-colors">
                                <p className="text-slate-700 text-sm leading-relaxed italic">"{entry.highlights}"</p>
                            </div>
                        </div>
                        <div className="flex md:flex-col gap-2 w-full md:w-48 shrink-0">
                            <button className="flex-1 px-4 py-2 bg-emerald-600 text-white rounded-xl font-medium hover:bg-emerald-700 transition-colors shadow-sm text-sm">
                                Verify Entry
                            </button>
                            <button className="flex-1 px-4 py-2 bg-white text-slate-600 rounded-xl font-medium border border-slate-200 hover:bg-slate-50 transition-colors text-sm">
                                Flag for Edit
                            </button>
                            <button className="flex-1 px-4 py-2 text-indigo-600 text-sm font-semibold hover:bg-indigo-50 rounded-xl transition-colors">
                                Full Visit Profile →
                            </button>
                        </div>
                    </div>
                ))}
            </div>

            <div className="p-8 border-2 border-dashed border-slate-200 rounded-3xl flex flex-col items-center justify-center text-center">
                <div className="w-16 h-16 bg-slate-100 rounded-full flex items-center justify-center text-2xl mb-4">✅</div>
                <h3 className="text-slate-900 font-bold text-lg">Daily Audit in Good Standing</h3>
                <p className="text-slate-500 text-sm max-w-sm">No high-risk entries requiring immediate clinical intervention detected by system triage.</p>
            </div>
        </div>
    );
};

export default DailyAudit;
