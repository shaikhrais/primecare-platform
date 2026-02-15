import React, { memo } from 'react';
import { ScatterChart, Scatter, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, ZAxis } from 'recharts';
import { useNavigate } from 'react-router-dom';

const data = [
    { type: 1, severity: 1, count: 5 }, // Falls - Low
    { type: 1, severity: 3, count: 1 }, // Falls - High
    { type: 2, severity: 2, count: 3 }, // Med Error - Med
    { type: 3, severity: 1, count: 8 }, // Skin Tear - Low
    { type: 4, severity: 2, count: 2 }, // Behavior - Med
];

const types = ['', 'Falls', 'Meds', 'Skin', 'Behavior'];
const severities = ['', 'Low', 'Medium', 'High', 'Critical'];

export const ClinicalIncidentHeatmap = memo(() => {
    const navigate = useNavigate();
    return (
        <div style={{ padding: '24px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', height: '400px', display: 'flex', flexDirection: 'column' }}>
            <h3 style={{ margin: '0 0 20px 0', fontSize: '18px', fontWeight: 700, color: '#111827' }}>Clinical Incident Hotspots</h3>
            <div style={{ flex: 1, width: '100%', minHeight: 0 }}>
                <ResponsiveContainer width="100%" height="100%">
                    <ScatterChart
                        margin={{ top: 20, right: 20, bottom: 20, left: 20 }}
                        onClick={() => navigate('/rn/incidents')}
                        style={{ cursor: 'pointer' }}
                    >
                        <CartesianGrid />
                        <XAxis type="number" dataKey="type" name="Type" tickFormatter={(val) => types[val] || ''} domain={[0, 5]} tickCount={6} />
                        <YAxis type="number" dataKey="severity" name="Severity" tickFormatter={(val) => severities[val] || ''} domain={[0, 5]} tickCount={6} />
                        <ZAxis type="number" dataKey="count" range={[100, 500]} name="Frequency" />
                        <Tooltip cursor={{ strokeDasharray: '3 3' }} />
                        <Scatter name="Incidents" data={data} fill="#EF4444" />
                    </ScatterChart>
                </ResponsiveContainer>
            </div>
        </div>
    );
});

ClinicalIncidentHeatmap.displayName = 'ClinicalIncidentHeatmap';
