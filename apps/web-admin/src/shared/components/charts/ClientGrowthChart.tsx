import React from 'react';
import { ChartCard } from './ChartCard';
import { CoreBarChart } from './core';

const data = [
    { name: 'Jan', newClients: 12, churn: -2 },
    { name: 'Feb', newClients: 19, churn: -1 },
    { name: 'Mar', newClients: 15, churn: -3 },
    { name: 'Apr', newClients: 22, churn: -4 },
    { name: 'May', newClients: 28, churn: -1 },
    { name: 'Jun', newClients: 25, churn: -5 },
];

export const ClientGrowthChart = React.memo(() => {
    return (
        <ChartCard title="Client Acquisition & Churn" height={400}>
            <CoreBarChart
                data={data}
                xKey="name"
                series={[
                    { key: 'newClients', name: 'New Clients', color: '#00875A', stackId: 'stack', radius: [4, 4, 0, 0] },
                    { key: 'churn', name: 'Churned', color: '#EF4444', stackId: 'stack', radius: [0, 0, 4, 4] }
                ]}
                stackOffset="sign"
                referenceLineY={0}
            />
        </ChartCard>
    );
});
