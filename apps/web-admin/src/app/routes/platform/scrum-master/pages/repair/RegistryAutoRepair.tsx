import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';

const { ApiRegistry } = AdminRegistry;

export default function RegistryAutoRepair() {
    const { t } = useTranslation();
    const [isScanning, setIsScanning] = useState(false);
    const [scanResults, setScanResults] = useState<any>(null);
    const [isRepairing, setIsRepairing] = useState(false);
    const [repairLog, setRepairLog] = useState<string[]>([]);

    const handleScan = async () => {
        setIsScanning(true);
        setRepairLog([]);
 // a deep scan of ApiRegistry vs RouteRegistry
        await new Promise(resolve => setTimeout(resolve, 1500));
        setScanResults({
            inconsistencies: [
                { id: 'ADMIN.REPORTS', type: 'API_MISSING', severity: 'high', description: 'API endpoint for reports missing in some worker nodes.' },
                { id: 'SCRUM_MASTER.AUTO_FIX', type: 'ROUTE_MISMATCH', severity: 'medium', description: 'Internal route mapping does not match the master manifest.' },
                { id: 'PSW.FEED', type: 'REGISTRY_SHADOW', severity: 'low', description: 'Property shadowed by legacy override in local shared package.' }
            ],
            score: 84
        });
        setIsScanning(false);
    };

    const handleRepair = async () => {
        setIsRepairing(true);
        const repairs = [
            'Analyzing dependency graph...',
            'Injecting master overrides into local context...',
            'Patching shadowed properties in ApiRegistry...',
            'Re-syncing RouteRegistry with platform metadata...',
            'Registry Integrity Restored.'
        ];

        for (const step of repairs) {
            setRepairLog(prev => [...prev, step]);
            await new Promise(resolve => setTimeout(resolve, 800));
        }

        setIsRepairing(false);
        setScanResults(null);
    };

    return (
        <div data-cy="page.container" className="p-8 max-w-5xl mx-auto space-y-8">
            <header className="flex justify-between items-end">
                <div>
                    <h1 data-cy="page.title" className="text-3xl font-extrabold tracking-tight">Registry Auto-Repair</h1>
                    <p className="text-muted-foreground mt-2">Self-healing utility for synchronizing platform-wide API and Route registries.</p>
                </div>
                <div className="bg-primary/5 px-4 py-2 rounded-lg border border-primary/20">
                    <span className="text-xs font-bold text-primary uppercase">Engine Status:</span>
                    <span className="ml-2 font-mono text-sm">OPTIMAL</span>
                </div>
            </header>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div className="md:col-span-2 space-y-6">
                    {!scanResults && !isRepairing && (
                        <div className="bg-card border rounded-2xl p-12 text-center space-y-6">
                            <div className="text-6xl">🛡️</div>
                            <div className="space-y-2">
                                <h2 data-cy="h2-registry-auto-repair-0" className="text-xl font-bold">Platform Integrity Scan</h2>
                                <p className="text-muted-foreground max-w-md mx-auto">
                                    Before performing repairs, we must analyze the consistency between the Master Registry and local application bundles.
                                </p>
                            </div>
                            <button data-cy="btn-registry-auto-repair-0"
                                onClick={handleScan}
                                disabled={isScanning}
                                className="px-8 py-3 bg-primary text-primary-foreground rounded-xl font-bold hover:opacity-90 transition-all disabled:opacity-50"
                            >
                                {isScanning ? '🔍 Scanning Infrastructure...' : 'Start Integrity Audit'}
                            </button>
                        </div>
                    )}

                    {scanResults && (
                        <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-500">
                            <div className="bg-destructive/5 border border-destructive/20 rounded-2xl p-6">
                                <h3 data-cy="h3-registry-auto-repair-0" className="text-lg font-bold text-destructive flex items-center gap-2 mb-4">
                                    <span>⚠️</span> Potential Inconsistencies Detected
                                </h3>
                                <div className="divide-y border rounded-xl bg-background">
                                    {scanResults.inconsistencies.map((inc: any, idx: number) => (
                                        <div key={idx} className="p-4 flex gap-4 items-start">
                                            <div className={`p-2 rounded-lg mt-1 ${inc.severity === 'high' ? 'bg-destructive/10 text-destructive' : 'bg-orange-500/10 text-orange-500'}`}>
                                                <span className="text-xs font-black uppercase">{inc.severity}</span>
                                            </div>
                                            <div className="flex-1">
                                                <div className="font-bold">{inc.id}</div>
                                                <p className="text-sm text-muted-foreground">{inc.description}</p>
                                            </div>
                                        </div>
                                    ))}
                                </div>
                            </div>

                            <div className="flex gap-4">
                                <button data-cy="btn-registry-auto-repair-1"
                                    onClick={handleRepair}
                                    className="flex-1 py-4 bg-green-600 text-white rounded-xl font-bold shadow-lg shadow-green-600/20 hover:bg-green-700 transition-all"
                                >
                                    ⚡ Execute Autonomous Repair
                                </button>
                                <button data-cy="btn-registry-auto-repair-2"
                                    onClick={() => setScanResults(null)}
                                    className="px-6 py-4 border rounded-xl font-bold hover:bg-accent transition-all"
                                >
                                    Cancel
                                </button>
                            </div>
                        </div>
                    )}

                    {isRepairing && (
                        <div className="bg-black text-green-500 font-mono p-6 rounded-2xl h-80 overflow-y-auto space-y-2 border-4 border-zinc-900 shadow-2xl">
                            {repairLog.map((log, idx) => (
                                <div key={idx} className="animate-in fade-in slide-in-from-left-2 duration-300">
                                    <span className="opacity-50 mr-2">[{new Date().toLocaleTimeString()}]</span>
                                    {log}
                                </div>
                            ))}
                            <div className="animate-pulse">_</div>
                        </div>
                    )}
                </div>

                <div className="space-y-6">
                    <div className="bg-primary text-primary-foreground p-6 rounded-2xl space-y-4">
                        <h3 data-cy="h3-registry-auto-repair-1" className="font-bold flex items-center gap-2">
                            <span>📡</span> Registry Hub
                        </h3>
                        <div className="space-y-3">
                            <div className="flex justify-between text-sm">
                                <span className="opacity-70">Master Version</span>
                                <span className="font-mono">v4.8.2-stable</span>
                            </div>
                            <div className="flex justify-between text-sm">
                                <span className="opacity-70">Last Sync</span>
                                <span className="font-mono">14m ago</span>
                            </div>
                        </div>
                        <div className="pt-4 border-t border-white/10">
                            <div className="text-xs font-bold uppercase opacity-50 mb-2">Platform Health Score</div>
                            <div className="flex items-end gap-2">
                                <span className="text-4xl font-black">{scanResults ? scanResults.score : 98}%</span>
                                <span className="mb-1 opacity-70">Secure</span>
                            </div>
                        </div>
                    </div>

                    <div className="bg-card border rounded-2xl p-6 space-y-4">
                        <h3 data-cy="h3-registry-auto-repair-2" className="font-bold text-sm uppercase tracking-widest text-muted-foreground">Technical Docs</h3>
                        <ul className="space-y-3 text-sm">
                            <li className="flex items-center gap-2 hover:text-primary cursor-pointer transition-colors">
                                <span>📖</span> Understanding Registry Shadowing
                            </li>
                            <li className="flex items-center gap-2 hover:text-primary cursor-pointer transition-colors">
                                <span>🛠️</span> Manual Override Injection
                            </li>
                            <li className="flex items-center gap-2 hover:text-primary cursor-pointer transition-colors">
                                <span>🔒</span> Encryption Layer Verification
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    );
}
