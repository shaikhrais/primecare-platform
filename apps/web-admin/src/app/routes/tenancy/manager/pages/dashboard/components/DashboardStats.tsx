import React from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

const { ContentRegistry } = AdminRegistry;

interface SubComponentProps {
    id: string;
    label: string;
    value: number | string;
    color: string;
    dataCy: string;
    isHealth?: boolean;
    onDragStart: (e: React.DragEvent, id: string) => void;
    onDragOver: (e: React.DragEvent) => void;
    onDrop: (e: React.DragEvent, id: string) => void;
}

const KPICard = ({ id, label, value, color, dataCy, isHealth, onDragStart, onDragOver, onDrop }: SubComponentProps) => (
    <div 
        className={`kpi-card ${isHealth ? 'health-status-card' : ''}`} 
        data-cy={dataCy} 
        style={{ borderTop: `4px solid ${color}`, cursor: 'grab', transition: 'transform 0.2s', backgroundColor: 'white' }}
        draggable
        onDragStart={(e) => onDragStart(e, id)}
        onDragOver={onDragOver}
        onDrop={(e) => onDrop(e, id)}
        onDragEnd={(e) => e.currentTarget.style.opacity = '1'}
    >
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
            <div className="kpi-label" style={{ userSelect: 'none' }}>{label}</div>
            <div style={{ color: '#CBD5E1', cursor: 'grab' }}>⋮⋮</div>
        </div>
        <div className="kpi-value" style={isHealth ? { color, fontSize: '1.2rem', textTransform: 'uppercase' } : {}}>
            {value}
        </div>
    </div>
);

interface DashboardStatsProps {
    activeClients: number;
    staffOnDuty: number;
    openIncidents: number;
    todayShifts: number;
    healthStatus?: 'healthy' | 'warning' | 'critical';
    alertsCount?: number;
}

export const DashboardStats: React.FC<DashboardStatsProps> = ({ activeClients, staffOnDuty, openIncidents, todayShifts, healthStatus = 'healthy', alertsCount = 0 }) => {
    const { t } = useTranslation();
    const healthColor = healthStatus === 'healthy' ? '#10b981' : healthStatus === 'warning' ? '#f59e0b' : '#ef4444';

    // Suggestion 25: Customizable Dashboard Layouts
    // Establish default array of cards
    const defaultCards = [
        { id: 'health', label: 'Branch Health', value: `${healthStatus} ${alertsCount > 0 ? `(${alertsCount} Alerts)` : ''}`, color: healthColor, dataCy: 'kpi-health', isHealth: true },
        { id: 'shifts', label: t(ContentRegistry.MANAGER_DASHBOARD.KPI.TODAY_SHIFTS), value: todayShifts, color: '#3b82f6', dataCy: 'kpi-today-shifts' },
        { id: 'clients', label: t(ContentRegistry.MANAGER_DASHBOARD.KPI.ACTIVE_CLIENTS), value: activeClients, color: '#10b981', dataCy: 'kpi-active-clients' },
        { id: 'staff', label: t(ContentRegistry.MANAGER_DASHBOARD.KPI.STAFF_ON_DUTY), value: staffOnDuty, color: '#f59e0b', dataCy: 'kpi-staff-on-duty' },
        { id: 'incidents', label: t(ContentRegistry.MANAGER_DASHBOARD.KPI.OPEN_INCIDENTS), value: openIncidents, color: '#ef4444', dataCy: 'kpi-open-incidents' },
    ];

    // Read saved layout order from localStorage, fallback to default
    const [cardOrder, setCardOrder] = React.useState<string[]>(() => {
        const saved = localStorage.getItem('manager_dashboard_kpi_layout');
        if (saved) {
            try {
                const parsed = JSON.parse(saved);
                if (parsed.length === defaultCards.length) return parsed;
            } catch (e) {
                console.error("Failed to parse kpi layout", e);
            }
        }
        return defaultCards.map(c => c.id);
    });

    const handleDragStart = (e: React.DragEvent, id: string) => {
        e.dataTransfer.setData('text/plain', id);
        setTimeout(() => {
            (e.target as HTMLElement).style.opacity = '0.5';
        }, 0);
    };

    const handleDragOver = (e: React.DragEvent) => {
        e.preventDefault(); // allow drop
    };

    const handleDrop = (e: React.DragEvent, targetId: string) => {
        e.preventDefault();
        const draggedId = e.dataTransfer.getData('text/plain');
        if (draggedId === targetId) return;

        const newOrder = [...cardOrder];
        const draggedIndex = newOrder.findIndex(id => id === draggedId);
        const targetIndex = newOrder.findIndex(id => id === targetId);

        // Swap the elements
        newOrder.splice(draggedIndex, 1);
        newOrder.splice(targetIndex, 0, draggedId);

        setCardOrder(newOrder);
        localStorage.setItem('manager_dashboard_kpi_layout', JSON.stringify(newOrder));
    };

    return (
        <div className="kpi-grid">
            {cardOrder.map(id => {
                // Find dynamic values to map into the static ordered blueprint
                const blueprintCard = defaultCards.find(c => c.id === id);
                if (!blueprintCard) return null;
                
                return (
                    <KPICard 
                        key={blueprintCard.id} 
                        {...blueprintCard} 
                        onDragStart={handleDragStart}
                        onDragOver={handleDragOver}
                        onDrop={handleDrop}
                    />
                );
            })}
        </div>
    );
};
