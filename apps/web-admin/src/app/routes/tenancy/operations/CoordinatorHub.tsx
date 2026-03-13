import React from 'react';

const CoordinatorHub: React.FC = () => {
    return (
        <div data-cy="page.container" className="p-6 space-y-6 max-w-[1600px] mx-auto animate-in fade-in slide-in-from-bottom-4 duration-500">
            <header className="flex justify-between items-end">
                <div>
                    <h1 data-cy="page.title" className="text-3xl font-black text-slate-900 tracking-tight">OPERATIONS HUB</h1>
                    <p className="text-slate-500 font-medium">Real-time Coordination & Emergency Dispatch</p>
                </div>
                <div className="flex gap-3">
                    <button className="px-4 py-2 bg-white border border-slate-200 rounded-xl font-bold text-sm shadow-sm hover:bg-slate-50 transition-all">
                        Live Map
                    </button>
                    <button
                        data-cy="btn-coord-optimize"
                        className="px-4 py-2 bg-slate-100 text-slate-600 border border-slate-200 rounded-xl font-bold text-sm hover:bg-slate-200 transition-all"
                    >
                        Optimize Routes
                    </button>
                    <button
                        data-cy="btn-coord-sos-dispatch"
                        className="px-4 py-2 bg-emerald-600 text-white rounded-xl font-bold text-sm shadow-lg shadow-emerald-100 hover:bg-emerald-700 transition-all"
                    >
                        Dispatch Hero
                    </button>
                </div>
            </header>

            <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
                {[
                    { label: 'Active Visits', val: '42', change: '8 En Route', color: 'indigo' },
                    { label: 'SOS Alerts', val: '2', change: 'Urgent', color: 'rose' },
                    { label: 'Unassigned', val: '5', change: '-2 from 1h', color: 'amber' },
                    { label: 'Branch Coverage', val: '96%', change: '+2%', color: 'emerald' }
                ].map(stat => (
                    <div key={stat.label} className="bg-white p-6 rounded-3xl border border-slate-100 shadow-sm relative overflow-hidden group">
                        <p className="text-slate-400 text-xs font-black uppercase tracking-widest mb-2">{stat.label}</p>
                        <div className="flex items-end gap-3">
                            <h4 className="text-3xl font-black text-slate-800 tracking-tight">{stat.val}</h4>
                            <span className={`text-[10px] font-bold mb-1 ${stat.label.includes('SOS') ? 'text-rose-500 animate-pulse' : 'text-slate-400'}`}>{stat.change}</span>
                        </div>
                    </div>
                ))}
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div className="lg:col-span-2 bg-slate-900 rounded-[2.5rem] p-8 text-white shadow-2xl relative overflow-hidden h-[500px]">
                    <div className="absolute inset-0 bg-[url('https://api.mapbox.com/styles/v1/mapbox/dark-v10/static/-79.3832,43.6532,11/1200x500?access_token=pk.placeholder')] bg-cover opacity-40grayscale mix-blend-overlay" />
                    <div className="relative z-10 flex flex-col h-full">
                        <div className="flex justify-between items-center mb-auto">
                            <h3 className="font-black tracking-tight uppercase text-sm border-b-2 border-emerald-500 pb-1">Live Pulse Map</h3>
                            <div className="flex gap-2">
                                <span className="flex items-center gap-2 px-3 py-1 bg-white/10 rounded-lg text-[10px] font-black">
                                    <span className="w-2 h-2 bg-emerald-500 rounded-full animate-ping" />
                                    LIVE MONITORING
                                </span>
                            </div>
                        </div>

                        <div className="grid grid-cols-3 gap-4 mb-4">
                            {[
                                { name: 'Shift #782', status: 'In Progress', loc: 'Downtown' },
                                { name: 'Shift #783', status: 'Checking In', loc: 'North End' },
                                { name: 'Shift #784', status: 'En Route', loc: 'West Quay' }
                            ].map(v => (
                                <div key={v.name} className="p-4 bg-white/5 border border-white/10 rounded-2xl backdrop-blur-md">
                                    <p className="text-[10px] font-black text-slate-400 uppercase">{v.name}</p>
                                    <p className="text-sm font-bold">{v.loc}</p>
                                    <p className="text-[10px] text-emerald-400 font-bold mt-2 italic">{v.status}</p>
                                </div>
                            ))}
                        </div>
                    </div>
                </div>

                <div className="space-y-6">
                    <div className="bg-rose-50 rounded-[2.5rem] p-8 border border-rose-100 shadow-sm relative group overflow-hidden">
                        <div className="absolute top-0 right-0 p-8 opacity-10 group-hover:scale-125 transition-transform duration-500">
                            <span className="text-8xl font-black text-rose-600">🆘</span>
                        </div>
                        <h3 className="text-rose-600 font-black text-[10px] uppercase tracking-widest mb-6 border-b border-rose-200 pb-2">Active SOS Queue</h3>
                        <div className="space-y-4">
                            <div className="p-5 bg-white rounded-2xl shadow-sm border-l-4 border-rose-500">
                                <p className="text-xs font-black text-slate-800">Visit #9021 • SOS Trigger</p>
                                <p className="text-[10px] text-slate-400 mt-1 uppercase font-bold tracking-tight">PSW: Sarah J. • Client: Robert M.</p>
                                <div className="mt-4 flex gap-2">
                                    <button className="flex-1 py-2 bg-rose-600 text-white rounded-xl text-[10px] font-black hover:bg-rose-700 transition-all">
                                        RESPOND
                                    </button>
                                    <button className="px-3 py-2 bg-slate-100 text-slate-400 rounded-xl text-[10px] font-black">
                                        MAP
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div className="bg-white rounded-[2.5rem] p-8 border border-slate-100 shadow-sm">
                        <h3 className="text-slate-400 font-black text-[10px] uppercase tracking-widest mb-6">Coverage Alerts</h3>
                        <div className="space-y-3">
                            {[
                                { time: '18:00', task: 'Medication Assist', client: 'Alice W.', dist: '2.4km' },
                                { time: '19:30', task: 'Evening Prep', client: 'Tom H.', dist: '1.8km' }
                            ].map(alert => (
                                <div key={alert.client} className="flex items-center gap-4 group cursor-pointer hover:bg-slate-50 p-2 rounded-2xl transition-all">
                                    <div className="w-10 h-10 bg-slate-100 rounded-xl flex items-center justify-center font-black text-[10px] text-slate-400 group-hover:bg-indigo-50 group-hover:text-indigo-600 transition-colors">
                                        {alert.time}
                                    </div>
                                    <div className="flex-1">
                                        <p className="text-xs font-bold text-slate-800">{alert.client}</p>
                                        <p className="text-[10px] text-slate-400">{alert.task}</p>
                                    </div>
                                    <span className="text-[10px] font-black text-indigo-500 italic">{alert.dist}</span>
                                </div>
                            ))}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default CoordinatorHub;
