import React from 'react';

const BuildHealthPage: React.FC = () => {
    return (
        <div data-cy="page.container" style={{ padding: '2rem' }}>
            <h1 data-cy="page.title">Build & Deployment Health</h1>
            <p>CI/CD pipeline status and deployment transparency log.</p>
            <table data-cy="table-build-health-page" style={{ width: '100%', marginTop: '2rem', borderCollapse: 'collapse' }}>
                <thead>
                    <tr style={{ textAlign: 'left', borderBottom: '2px solid #e5e7eb' }}>
                        <th style={{ padding: '0.75rem' }}>Environment</th>
                        <th style={{ padding: '0.75rem' }}>Version</th>
                        <th style={{ padding: '0.75rem' }}>Trigger</th>
                        <th style={{ padding: '0.75rem' }}>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr style={{ borderBottom: '1px solid #f3f4f6' }}>
                        <td style={{ padding: '0.75rem' }}>Production</td>
                        <td style={{ padding: '0.75rem' }}>v2.4.1</td>
                        <td style={{ padding: '0.75rem' }}>Merge (main)</td>
                        <td style={{ padding: '0.75rem', color: '#059669' }}>Success</td>
                    </tr>
                    <tr style={{ borderBottom: '1px solid #f3f4f6' }}>
                        <td style={{ padding: '0.75rem' }}>Staging</td>
                        <td style={{ padding: '0.75rem' }}>v2.4.2-rc.1</td>
                        <td style={{ padding: '0.75rem' }}>Schedule</td>
                        <td style={{ padding: '0.75rem', color: '#059669' }}>Success</td>
                    </tr>
                </tbody>
            </table>
        </div>
    );
};

export default BuildHealthPage;
