// ================================================================
// PAGE IDENTITY: R2 � Data Export
// Registry ID:   page.admin.export
// Type:          Report
// Owner:         admin
// ================================================================
import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';

const { ApiRegistry } = AdminRegistry;

const ExportPage: React.FC = () => {
    const { t } = useTranslation();
    const [exportType, setExportType] = useState('users');
    const [format, setFormat] = useState('csv');
    const [exporting, setExporting] = useState(false);
    const [success, setSuccess] = useState(false);
    const [error, setError] = useState<string | null>(null);

    const handleExport = async () => {
        setExporting(true);
        setError(null);
        setSuccess(false);
        try {
            const url = `${ApiRegistry.ADMIN.REPORTS}?type=${exportType}&format=${format}`;

            // For CSV, we can download directly
            if (format === 'csv') {
                const response = await apiClient.get(url);
                if (response.ok) {
                    const blob = await response.blob();
                    const blobUrl = window.URL.createObjectURL(blob);
                    const link = document.createElement('a');
                    link.href = blobUrl;
                    link.setAttribute('download', `export_${exportType}_${new Date().toISOString().split('T')[0]}.csv`);
                    document.body.appendChild(link);
                    link.click();
                    link.remove();
                    setSuccess(true);
                } else {
                    const data = await response.json();
                    setError(data.error || 'Export failed');
                }
            } else {
                setError('PDF export is currently in maintenance. Please use CSV.');
            }
        } catch (err: any) {
            setError(err.message || 'Export failed');
        } finally {
            setExporting(false);
        }
    };

    return (
        <div className="p-6 max-w-4xl mx-auto space-y-8">
            <header className="space-y-2">
                <h1 className="text-3xl font-bold tracking-tight">{t('platform.admin.export.title', 'Data Export Center')}</h1>
                <p className="text-muted-foreground">{t('platform.admin.export.subtitle', 'Build and download custom datasets for your agency.')}</p>
            </header>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                <div className="space-y-6">
                    <section className="space-y-4">
                        <h2 className="text-sm font-semibold uppercase tracking-wider text-muted-foreground">Select Collection</h2>
                        <div className="grid grid-cols-2 gap-3">
                            <ExportOption
                                selected={exportType === 'users'}
                                onClick={() => setExportType('users')}
                                label="Users & Staff"
                                icon={<span className="text-xl">📊</span>}
                            />
                            <ExportOption
                                selected={exportType === 'visits'}
                                onClick={() => setExportType('visits')}
                                label="Visits & Care"
                                icon={<span className="text-xl">📅</span>}
                            />
                            <ExportOption
                                selected={exportType === 'leads'}
                                onClick={() => setExportType('leads')}
                                label="Leads & CRM"
                                icon={<span className="text-xl">📋</span>}
                            />
                            <ExportOption
                                selected={exportType === 'invoices'}
                                onClick={() => setExportType('invoices')}
                                label="Billing Data"
                                icon={<span className="text-xl">💰</span>}
                            />
                        </div>
                    </section>

                    <section className="space-y-4">
                        <h2 className="text-sm font-semibold uppercase tracking-wider text-muted-foreground">Export Format</h2>
                        <div className="flex gap-4">
                            <label className={`flex-1 flex items-center justify-center gap-2 p-4 rounded-xl border-2 cursor-pointer transition-all ${format === 'csv' ? 'border-primary bg-primary/5' : 'border-transparent bg-secondary'}`}>
                                <input type="radio" value="csv" checked={format === 'csv'} onChange={() => setFormat('csv')} className="hidden" />
                                <span className="text-xl">📄</span>
                                <span className="font-medium">CSV (Excel)</span>
                            </label>
                            <label className={`flex-1 flex items-center justify-center gap-2 p-4 rounded-xl border-2 cursor-pointer transition-all ${format === 'pdf' ? 'border-primary bg-primary/5' : 'border-transparent bg-secondary'}`}>
                                <input type="radio" value="pdf" checked={format === 'pdf'} onChange={() => setFormat('pdf')} className="hidden" />
                                <span className="text-xl">📕</span>
                                <span className="font-medium">PDF Document</span>
                            </label>
                        </div>
                    </section>

                    <button
                        onClick={handleExport}
                        disabled={exporting}
                        className="w-full py-4 rounded-xl bg-primary text-primary-foreground font-semibold flex items-center justify-center gap-2 hover:opacity-90 transition-opacity disabled:opacity-50"
                    >
                        {exporting ? '🔄' : '📥'}
                        {exporting ? 'Processing Architecture...' : 'Generate and Download'}
                    </button>

                    {success && (
                        <div className="p-4 rounded-lg bg-green-500/10 text-green-500 flex items-center gap-2 border border-green-500/20">
                            <span className="text-xl">✅</span>
                            <span>Export completed successfully. Check your downloads.</span>
                        </div>
                    )}

                    {error && (
                        <div className="p-4 rounded-lg bg-destructive/10 text-destructive flex items-center gap-2 border border-destructive/20">
                            <span className="text-xl">⚠️</span>
                            <span>{error}</span>
                        </div>
                    )}
                </div>

                <div className="bg-card border rounded-2xl p-6 space-y-4 hidden md:block">
                    <h3 className="font-semibold text-lg">Export Summary</h3>
                    <div className="space-y-4 text-sm">
                        <div className="flex justify-between border-b pb-2">
                            <span className="text-muted-foreground">Target Collection</span>
                            <span className="font-medium capitalize">{exportType}</span>
                        </div>
                        <div className="flex justify-between border-b pb-2">
                            <span className="text-muted-foreground">File Encoding</span>
                            <span className="font-medium uppercase">{format === 'csv' ? 'UTF-8' : 'Binary'}</span>
                        </div>
                        <div className="flex justify-between border-b pb-2">
                            <span className="text-muted-foreground">Security Layer</span>
                            <span className="font-medium">Encrypted (TLS)</span>
                        </div>
                        <p className="text-xs text-muted-foreground mt-4 leading-relaxed">
                            Data exports are audited and logged. By downloading this data, you agree to handle sensitive information according to your agency's compliance policies.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    );
};

const ExportOption: React.FC<{ selected: boolean; label: string; icon: React.ReactNode; onClick: () => void }> = ({ selected, label, icon, onClick }) => (
    <div
        onClick={onClick}
        className={`p-4 rounded-xl border-2 flex items-center gap-3 cursor-pointer transition-all ${selected ? 'border-primary bg-primary/5 shadow-sm' : 'border-transparent bg-secondary'}`}
    >
        <div className={`p-2 rounded-lg ${selected ? 'bg-primary text-primary-foreground' : 'bg-background'}`}>
            {icon}
        </div>
        <span className="font-medium text-sm">{label}</span>
    </div>
);

export default ExportPage;
