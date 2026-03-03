import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { CoreAreaChart } from '@/shared/components/charts/core/CoreAreaChart';
import { CorePieChart } from '@/shared/components/charts/core/CorePieChart';

const { ContentRegistry } = AdminRegistry;

export const SystemHealthCharts: React.FC = () => {
    const { t } = useTranslation();

    const latencyData = [
        { name: '08:00', latency: 35 },
        { name: '09:00', latency: 42 },
        { name: '10:00', latency: 38 },
        { name: '11:00', latency: 45 },
        { name: '12:00', latency: 52 },
        { name: '13:00', latency: 40 },
        { name: '14:00', latency: 36 },
        { name: '15:00', latency: 39 },
    ];

    const errorData = [
        { name: '200 OK', value: 98.4 },
        { name: '401 Unauth', value: 0.8 },
        { name: '500 Server', value: 0.3 },
        { name: '404 Not Found', value: 0.5 },
    ];

    return (
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))', gap: '2rem', marginBottom: '3rem' }}>
            <div className="sm-card" style={{ padding: '2rem', background: '#ffffff' }}>
                <h3 style={{ margin: '0 0 1.5rem 0', display: 'flex', alignItems: 'center', gap: '10px', fontSize: '1.25rem', fontWeight: 800 }}>
                    📈 {t(ContentRegistry.SCRUM_MASTER.ANALYTICS.LATENCY)}
                </h3>
                <div style={{ height: '300px' }}>
                    <CoreAreaChart
                        data={latencyData}
                        xKey="name"
                        series={[
                            { key: 'latency', name: 'Latency (ms)', color: '#4f46e5' }
                        ]}
                        showGradient={true}
                    />
                </div>
            </div>

            <div className="sm-card" style={{ padding: '2rem', background: '#ffffff' }}>
                <h3 style={{ margin: '0 0 1.5rem 0', display: 'flex', alignItems: 'center', gap: '10px', fontSize: '1.25rem', fontWeight: 800 }}>
                    📊 {t(ContentRegistry.SCRUM_MASTER.ANALYTICS.ERRORS)}
                </h3>
                <div style={{ height: '300px' }}>
                    <CorePieChart
                        data={errorData}
                        dataKey="value"
                        nameKey="name"
                        colors={['#10b981', '#6366f1', '#f43f5e', '#f59e0b']}
                    />
                </div>
            </div>
        </div>
    );
};
