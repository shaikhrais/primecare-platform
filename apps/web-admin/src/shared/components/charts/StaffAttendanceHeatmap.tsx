import React, { memo } from 'react';
import { ScatterChart, Scatter, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, ZAxis } from 'recharts';
import { useNavigate } from 'react-router-dom';

const data = [
    { day: 1, hour: 8, count: 5 }, // Monday 8am
    { day: 1, hour: 9, count: 2 },
    { day: 2, hour: 8, count: 4 },
    { day: 3, hour: 8, count: 6 },
    { day: 3, hour: 17, count: 1 }, // Wed 5pm (Lates)
];

const days = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

export const StaffAttendanceHeatmap = memo(() => {
    const navigate = useNavigate();
    return (
        <div style={{ padding: '24px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', height: '400px', display: 'flex', flexDirection: 'column' }}>
            <h3 style={{ margin: '0 0 20px 0', fontSize: '18px', fontWeight: 700, color: '#111827' }}>Lateness Heatmap</h3>
            <div style={{ flex: 1, width: '100%', minHeight: 0 }}>
                <ResponsiveContainer width="100%" height="100%">
                    <ScatterChart
                        margin={{ top: 20, right: 20, bottom: 20, left: 20 }}
                        onClick={() => navigate('/staff/attendance')}
                        style={{ cursor: 'pointer' }}
                    >
                        <CartesianGrid />
                        <XAxis type="number" dataKey="day" name="Day" tickFormatter={(val) => days[val] || ''} domain={[0, 5]} tickCount={6} />
                        <YAxis type="number" dataKey="hour" name="Hour" unit="h" domain={[6, 22]} />
                        <ZAxis type="number" dataKey="count" range={[50, 400]} name="Late Arrivals" />
                        <Tooltip cursor={{ strokeDasharray: '3 3' }} />
                        <Scatter name="Late Arrivals" data={data} fill="#F59E0B" />
                    </ScatterChart>
                </ResponsiveContainer>
            </div>
        </div>
    );
});

StaffAttendanceHeatmap.displayName = 'StaffAttendanceHeatmap';
