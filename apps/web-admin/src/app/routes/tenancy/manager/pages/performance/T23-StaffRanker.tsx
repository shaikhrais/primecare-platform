// ================================================================
// PAGE IDENTITY: T23 � Staff Ranker
// Type: Tool | Owner: manager
// ================================================================
import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { CoreBarChart, CorePieChart } from '@/shared/components/charts/core';

import './StaffRanker.css';

export default function StaffRanker() {
    const { t } = useTranslation();
    const [period, setPeriod] = useState('30d');

    const rankData = [
        { name: 'Sarah Jenkins', attendance: 98, performance: 95, reliability: 99, shifts: 42 },
        { name: 'Michael Chen', attendance: 95, performance: 92, reliability: 94, shifts: 38 },
        { name: 'Amina Okafor', attendance: 99, performance: 88, reliability: 96, shifts: 45 },
        { name: 'David Wilson', attendance: 92, performance: 90, reliability: 85, shifts: 30 },
        { name: 'Elena Rodriguez', attendance: 88, performance: 94, reliability: 82, shifts: 28 },
    ];

    const distributionData = [
        { name: 'Top Tier (90%+)', value: 12, color: '#10b981' },
        { name: 'Good (80-90%)', value: 24, color: '#3b82f6' },
        { name: 'Average (70-80%)', value: 8, color: '#f59e0b' },
        { name: 'At Risk (<70%)', value: 3, color: '#ef4444' },
    ];

    return (
        <div data-cy="page.container" role="main" aria-label="Staff Ranker" className="staff-ranker-container">
            <header className="staff-ranker-header">
                <div>
                    <h1 data-cy="page.title">Staff Performance Ranker</h1>
                    <p>Identify top performers and optimize branch clinical reliability.</p>
                </div>
                <div className="period-toggle">
                    {['7d', '30d', '90d'].map(p => (
                        <button data-cy="btn-manager.staff-ranker-0"
                            key={p}
                            onClick={() => setPeriod(p)}
                            className={`period-btn ${period === p ? 'active' : ''}`}
                        >
                            {p.toUpperCase()}
                        </button>
                    ))}
                </div>
            </header>

            <div className="ranker-grid">
                <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                    <div className="ranker-card">
                        <span className="ranker-card-label">Performance Spread</span>
                        <div style={{ height: '200px' }}>
                            <CorePieChart data={distributionData} dataKey="value" nameKey="name" />
                        </div>
                    </div>

                    <div className="branch-avg-card">
                        <div className="branch-avg-title">Branch Average</div>
                        <div className="branch-avg-value">94.2</div>
                        <div className="branch-avg-trend">
                            <span style={{ color: '#86efac' }}>▲ 2.1%</span> vs previous {period}
                        </div>
                    </div>
                </div>

                <div className="ranker-card">
                    <h3 data-cy="h3-manager.staff-ranker-0" className="leaderboard-title">
                        <span>🏆</span> Leaderboard: Clinical Excellence
                    </h3>
                    <div className="leaderboard-table-wrapper">
                        <table data-cy="table-manager.staff-ranker" className="leaderboard-table">
                            <thead>
                                <tr>
                                    <th>Staff Member</th>
                                    <th>Attendance</th>
                                    <th>Performance</th>
                                    <th>Reliability</th>
                                    <th>Shifts</th>
                                </tr>
                            </thead>
                            <tbody>
                                {rankData.map((staff, idx) => (
                                    <tr key={idx}>
                                        <td className="staff-name-cell">
                                            <div className="staff-rank-badge">
                                                {idx === 0 ? '🥇' : idx === 1 ? '🥈' : idx === 2 ? '🥉' : idx + 1}
                                            </div>
                                            {staff.name}
                                        </td>
                                        <td>
                                            <div className="attendance-bar-container">
                                                <div className="attendance-bar-bg">
                                                    <div className="attendance-bar-fill" style={{ width: `${staff.attendance}%` }} />
                                                </div>
                                                <span className="attendance-value">{staff.attendance}%</span>
                                            </div>
                                        </td>
                                        <td>
                                            <span className={`performance-badge ${staff.performance >= 90 ? 'high' : 'med'}`}>
                                                {staff.performance} / 100
                                            </span>
                                        </td>
                                        <td className="reliability-cell">{staff.reliability}%</td>
                                        <td>
                                            <span className="shifts-badge">{staff.shifts}</span>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div className="ranker-bottom-grid">
                <div className="ranker-card">
                    <h3 data-cy="h3-manager.staff-ranker-1" className="ranker-card-label">Attendance Trends</h3>
                    <div style={{ height: '250px' }}>
                        <CoreBarChart
                            data={[
                                { date: 'Week 1', attendance: 92 },
                                { date: 'Week 2', attendance: 94 },
                                { date: 'Week 3', attendance: 91 },
                                { date: 'Week 4', attendance: 98 },
                            ]}
                            xKey="date"
                            series={[{ key: 'attendance', name: 'Attendance %', color: '#10b981' }]}
                        />
                    </div>
                </div>

                <div className="ranker-card review-cycle-card">
                    <div className="review-icon">📅</div>
                    <h3 data-cy="h3-manager.staff-ranker-2" className="review-title">Next Review Cycle</h3>
                    <p className="review-desc">
                        Your next automated performance sweep is scheduled for <strong>Monday, March 9th</strong>. You can manually trigger a review for specific staff members.
                    </p>
                    <button data-cy="btn-manager.staff-ranker-1" className="btn-primary-pc">
                        Schedule Evaluation
                    </button>
                </div>
            </div>
        </div>
    );
}
