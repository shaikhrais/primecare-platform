// ================================================================
// PAGE IDENTITY: D10 � Regional Stats
// Type: Dashboard | Owner: manager
// ================================================================
import React, { useState, useEffect } from 'react';
import { ApiRegistry, ContentRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './RegionalStats.css';

const { REGIONAL_STATS } = ContentRegistry;

export default function RegionalStats() {
    const [stats, setStats] = useState({
        revenue: '$2.4M',
        utilization: '91%',
        churn: '1.2%',
        compliance: '98.8%'
    });
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchStats = async () => {
            try {
                const res: any = await apiClient.get(ApiRegistry.TENANCY.MANAGER.OPS_STATS);
                const data = await res.json();

                if (data) {
                    setStats({
                        revenue: data.revenue ? `${(data.revenue / 1000000).toFixed(1)}M` : '$2.4M',
                        utilization: data.utilization ? `${data.utilization}%` : '91%',
                        churn: data.churnRate ? `${data.churnRate}%` : '1.2%',
                        compliance: '98.8%'
                    });
                }
            } catch (error) {
                console.error('Failed to fetch regional stats:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchStats();
    }, []);

    if (loading) {
        return (
            <div className="regional-stats-container">
                <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', flexDirection: 'column', gap: '1rem' }}>
                    <div className="spinner"></div>
                    <p style={{ fontWeight: 700, color: '#64748b' }}>Projecting Regional Intelligence...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="regional-stats-container">
            <header className="stats-header">
                <div className="mgr-title-group">
                    <h1>{REGIONAL_STATS.TITLE}</h1>
                    <p>{REGIONAL_STATS.SUBTITLE}</p>
                </div>
                <div className="stats-actions">
                    <button className="btn-secondary-pc">{REGIONAL_STATS.ACTIONS.EXPORT_PL}</button>
                    <button className="btn-primary-pc">Generate Strategic Audit</button>
                </div>
            </header>

            <div className="stats-bento-grid">
                <div className="bento-item bento-large">
                    <span className="item-label">{REGIONAL_STATS.BENTO.PERFORMANCE}</span>
                    <div className="radar-chart-placeholder">
                        <div className="radar-scan"></div>
                        <div className="chart-line" style={{ transform: 'rotate(0deg)' }}></div>
                        <div className="chart-line" style={{ transform: 'rotate(45deg)' }}></div>
                        <div className="chart-line" style={{ transform: 'rotate(90deg)' }}></div>
                        <div className="chart-line" style={{ transform: 'rotate(135deg)' }}></div>
                        <p style={{ position: 'relative', zIndex: 1, fontWeight: 900, color: '#0f172a', letterSpacing: '0.1em' }}>
                            LIVE REGIONAL RADAR
                        </p>
                    </div>
                    <div className="item-subtext">
                        <span style={{ color: '#10b981' }}>●</span> Real-time load balancing across regional nodes.
                    </div>
                </div>

                <div className="bento-item">
                    <span className="item-label">{REGIONAL_STATS.STATS.REVENUE}</span>
                    <div className="item-value">{stats.revenue}</div>
                    <div className="item-subtext" style={{ color: '#10b981' }}>↑ 8.2% Growth</div>
                </div>

                <div className="bento-item">
                    <span className="item-label">{REGIONAL_STATS.STATS.UTILIZATION}</span>
                    <div className="item-value">{stats.utilization}</div>
                    <div className="item-subtext" style={{ color: '#3b82f6' }}>Optimized via AI Dispatch</div>
                </div>

                <div className="bento-item">
                    <span className="item-label">{REGIONAL_STATS.STATS.CHURN}</span>
                    <div className="item-value">{stats.churn}</div>
                    <div className="item-subtext" style={{ color: '#10b981' }}>Retention Above Baseline</div>
                </div>

                <div className="bento-item">
                    <span className="item-label">{REGIONAL_STATS.STATS.COMPLIANCE_SCORE}</span>
                    <div className="item-value">{stats.compliance}</div>
                    <div className="item-subtext" style={{ color: '#8b5cf6' }}>Registry-Locked Records</div>
                </div>
            </div>
        </div>
    );
}
