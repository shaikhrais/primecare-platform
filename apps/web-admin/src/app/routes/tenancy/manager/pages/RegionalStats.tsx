import React, { useState, useEffect } from 'react';
import {
    LayoutDashboard,
    ShieldCheck,
    ChartBar,
    RefreshCcw,
    FileText,
    AlertTriangle,
    ArrowUpRight,
    TrendingUp
} from 'lucide-react';
import {
    ContentRegistry,
    ApiRegistry,
    ButtonRegistry,
    AdminRegistry
} from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

const RegionalStats: React.FC = () => {
    const [stats, setStats] = useState<any>(null);
    const [loading, setLoading] = useState(true);
    const [syncing, setSyncing] = useState(false);

    useEffect(() => {
        fetchStats();
    }, []);

    const fetchStats = async () => {
        setLoading(true);
        try {
            // In a real app, this would be an API call
            // const response = await fetch(ApiRegistry.TENANCY.MANAGER.OPS_STATS);
            // const data = await response.json();

            // Mock data for WOW factor
            setTimeout(() => {
                setStats({
                    revenue: 1254300,
                    utilization: 91.2,
                    churnRate: 1.8,
                    complianceScore: 98.4,
                    performanceRadar: [
                        { label: 'Ops', value: 92 },
                        { label: 'Clinical', value: 88 },
                        { label: 'Financial', value: 95 },
                        { label: 'Growth', value: 84 }
                    ],
                    complianceFlags: [
                        { id: '1', type: 'Training', status: 'Pending', psw: 'John Doe' },
                        { id: '2', type: 'Clinical', status: 'Alert', psw: 'Jane Smith' }
                    ]
                });
                setLoading(false);
            }, 800);
        } catch (err) {
            console.error('Failed to fetch stats', err);
            setLoading(false);
        }
    };

    const handleSyncCompliance = () => {
        setSyncing(true);
        setTimeout(() => {
            setSyncing(false);
            alert(ContentRegistry.REGIONAL_STATS.SUCCESS.COMPLIANCE_SYNCED);
        }, 1500);
    };

    if (loading) {
        return (
            <div className="p-8 flex items-center justify-center min-h-[400px]">
                <div className="flex flex-col items-center gap-4">
                    <RefreshCcw className="w-8 h-8 animate-spin text-blue-500" />
                    <p className="text-gray-500 font-medium">{ContentRegistry.MANAGER_DASHBOARD.MESSAGES.LOADING}</p>
                </div>
            </div>
        );
    }

    return (
        <div className="p-8 max-w-7xl mx-auto animate-in fade-in slide-in-from-bottom-4 duration-700">
            {/* Header section */}
            <div className="mb-10 flex flex-col md:flex-row md:items-end justify-between gap-6">
                <div>
                    <h1 className="text-4xl font-bold tracking-tight text-white mb-2">
                        {ContentRegistry.REGIONAL_STATS.TITLE}
                    </h1>
                    <p className="text-lg text-gray-400">
                        {ContentRegistry.REGIONAL_STATS.SUBTITLE}
                    </p>
                </div>
                <div className="flex gap-3">
                    <button
                        onClick={fetchStats}
                        className="flex items-center gap-2 px-4 py-2 bg-white/5 hover:bg-white/10 text-white rounded-xl border border-white/10 transition-all"
                    >
                        <RefreshCcw className="w-4 h-4" />
                        {ContentRegistry.REGIONAL_STATS.ACTIONS.SYNC_COMPLIANCE}
                    </button>
                    <button
                        onClick={() => alert('Exporting P&L...')}
                        className="flex items-center gap-2 px-4 py-2 bg-blue-600 hover:bg-blue-500 text-white rounded-xl shadow-lg shadow-blue-500/20 transition-all"
                    >
                        <FileText className="w-4 h-4" />
                        {ContentRegistry.REGIONAL_STATS.ACTIONS.EXPORT_PL}
                    </button>
                </div>
            </div>

            {/* Bento Grid */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                {/* Performance Radar Card */}
                <div className="col-span-1 md:col-span-2 bg-gradient-to-br from-slate-900 to-slate-800 rounded-3xl border border-white/5 p-8 relative overflow-hidden group">
                    <div className="absolute top-0 right-0 p-4 opacity-10 group-hover:opacity-20 transition-opacity">
                        <TrendingUp className="w-32 h-32" />
                    </div>

                    <div className="flex items-center gap-3 mb-8">
                        <div className="p-2 bg-blue-500/20 rounded-lg">
                            <ChartBar className="w-5 h-5 text-blue-400" />
                        </div>
                        <h3 className="text-xl font-semibold text-white">
                            {ContentRegistry.REGIONAL_STATS.BENTO.PERFORMANCE}
                        </h3>
                    </div>

                    <div className="grid grid-cols-2 sm:grid-cols-4 gap-8">
                        {stats.performanceRadar.map((p: any) => (
                            <div key={p.label} className="flex flex-col gap-2">
                                <span className="text-gray-400 text-sm">{p.label}</span>
                                <div className="flex items-baseline gap-2">
                                    <span className="text-3xl font-bold text-white">{p.value}%</span>
                                    {p.value > 90 && <ArrowUpRight className="w-4 h-4 text-emerald-400" />}
                                </div>
                                <div className="w-full h-1 bg-white/5 rounded-full mt-2">
                                    <div className="h-full bg-blue-500 rounded-full" style={{ width: `${p.value}%` }} />
                                </div>
                            </div>
                        ))}
                    </div>
                </div>

                {/* Regional Revenue Card */}
                <div className="bg-gradient-to-br from-emerald-950/40 to-emerald-900/20 rounded-3xl border border-emerald-500/10 p-8 flex flex-col justify-between">
                    <div className="flex items-center justify-between mb-8">
                        <div className="p-2 bg-emerald-500/20 rounded-lg">
                            <TrendingUp className="w-5 h-5 text-emerald-400" />
                        </div>
                        <span className="text-xs font-bold text-emerald-400 bg-emerald-500/10 px-2 py-1 rounded-full">+12.4%</span>
                    </div>

                    <div>
                        <span className="text-gray-400 text-sm block mb-1">{ContentRegistry.REGIONAL_STATS.STATS.REVENUE}</span>
                        <span className="text-4xl font-bold text-white">${(stats.revenue / 1000).toFixed(1)}k</span>
                    </div>

                    <div className="mt-8 pt-8 border-t border-white/5 flex items-center justify-between text-sm">
                        <span className="text-gray-500">Target: $1.2M</span>
                        <span className="text-emerald-400 font-medium">On Track</span>
                    </div>
                </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                {/* Compliance Monitor */}
                <div className="bg-slate-900/50 rounded-3xl border border-white/5 p-8">
                    <div className="flex items-center justify-between mb-8">
                        <div className="flex items-center gap-3">
                            <div className="p-2 bg-amber-500/20 rounded-lg">
                                <ShieldCheck className="w-5 h-5 text-amber-400" />
                            </div>
                            <h3 className="text-xl font-semibold text-white">
                                {ContentRegistry.REGIONAL_STATS.BENTO.COMPLIANCE}
                            </h3>
                        </div>
                        <button
                            onClick={handleSyncCompliance}
                            disabled={syncing}
                            className="p-2 hover:bg-white/5 rounded-lg transition-colors text-gray-400"
                        >
                            <RefreshCcw className={`w-4 h-4 ${syncing ? 'animate-spin' : ''}`} />
                        </button>
                    </div>

                    <div className="space-y-4">
                        {stats.complianceFlags.map((flag: any) => (
                            <div key={flag.id} className="flex items-center justify-between p-4 bg-white/5 rounded-2xl border border-white/5">
                                <div className="flex flex-col">
                                    <span className="text-white font-medium">{flag.psw}</span>
                                    <span className="text-xs text-gray-500">{flag.type}</span>
                                </div>
                                <div className={`px-3 py-1 rounded-full text-xs font-medium ${flag.status === 'Alert' ? 'bg-rose-500/10 text-rose-400 border border-rose-500/20' : 'bg-amber-500/10 text-amber-400 border border-amber-500/20'
                                    }`}>
                                    {flag.status}
                                </div>
                            </div>
                        ))}
                    </div>
                </div>

                {/* Financial Triage / Efficiency */}
                <div className="bg-slate-900/50 rounded-3xl border border-white/5 p-8 col-span-1 md:col-span-2">
                    <div className="flex items-center gap-3 mb-8">
                        <div className="p-2 bg-indigo-500/20 rounded-lg">
                            <LayoutDashboard className="w-5 h-5 text-indigo-400" />
                        </div>
                        <h3 className="text-xl font-semibold text-white">
                            {ContentRegistry.REGIONAL_STATS.BENTO.FINANCE}
                        </h3>
                    </div>

                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
                        <div className="p-6 bg-white/5 rounded-2xl border border-white/5 flex flex-col gap-4 hover:border-indigo-500/30 transition-all cursor-pointer group">
                            <div className="flex items-center justify-between">
                                <span className="text-gray-400">{ContentRegistry.REGIONAL_STATS.STATS.UTILIZATION}</span>
                                <AlertTriangle className="w-4 h-4 text-amber-500" />
                            </div>
                            <span className="text-3xl font-bold text-white tracking-tight">{stats.utilization}%</span>
                            <div className="text-sm text-gray-500">
                                <span className="text-indigo-400">8%</span> vs regional average
                            </div>
                        </div>

                        <div className="p-6 bg-white/5 rounded-2xl border border-white/5 flex flex-col gap-4 hover:border-emerald-500/30 transition-all cursor-pointer group">
                            <div className="flex items-center justify-between">
                                <span className="text-gray-400">{ContentRegistry.REGIONAL_STATS.STATS.CHURN}</span>
                                <ShieldCheck className="w-4 h-4 text-emerald-500" />
                            </div>
                            <span className="text-3xl font-bold text-white tracking-tight">{stats.churnRate}%</span>
                            <div className="text-sm text-gray-500">
                                <span className="text-emerald-400">-0.2%</span> from last month
                            </div>
                        </div>
                    </div>

                    <div className="mt-8 flex justify-end">
                        <button
                            onClick={() => alert('Launching Feedback Triage...')}
                            className="text-indigo-400 font-medium hover:text-indigo-300 transition-colors flex items-center gap-2"
                        >
                            {ContentRegistry.REGIONAL_STATS.ACTIONS.TRIAGE_FEEDBACK}
                            <ArrowUpRight className="w-4 h-4" />
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default RegionalStats;
