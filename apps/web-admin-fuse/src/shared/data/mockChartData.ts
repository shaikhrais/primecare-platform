export const MOCK_MANAGER_DATA = {
    revenue: [
        { month: 'Jan', revenue: 45000, target: 40000, actual: 45000, projected: 48000 },
        { month: 'Feb', revenue: 52000, target: 42000, actual: 52000, projected: 50000 },
        { month: 'Mar', revenue: 48000, target: 44000, actual: 48000, projected: 52000 },
        { month: 'Apr', revenue: 61000, target: 46000, actual: 61000, projected: 55000 },
        { month: 'May', revenue: 55000, target: 48000, actual: 55000, projected: 58000 },
        { month: 'Jun', revenue: 67000, target: 50000, actual: 67000, projected: 60000 },
    ],
    visitVolume: [
        { date: 'Mon', scheduled: 120, completed: 115, missed: 5 },
        { date: 'Tue', scheduled: 135, completed: 130, missed: 5 },
        { date: 'Wed', scheduled: 140, completed: 138, missed: 2 },
        { date: 'Thu', scheduled: 125, completed: 120, missed: 5 },
        { date: 'Fri', scheduled: 150, completed: 145, missed: 5 },
        { date: 'Sat', scheduled: 90, completed: 88, missed: 2 },
        { date: 'Sun', scheduled: 85, completed: 85, missed: 0 },
    ],
    staffUtilization: [
        { name: 'RN', billable: 75, admin: 15, travel: 10 },
        { name: 'RPN', billable: 80, admin: 10, travel: 10 },
        { name: 'PSW', billable: 85, admin: 5, travel: 10 },
        { name: 'Therapist', billable: 70, admin: 20, travel: 10 },
    ],
    shiftFulfillment: [
        { date: 'Mon', fulfilled: 95, unfulfilled: 5 },
        { date: 'Tue', fulfilled: 98, unfulfilled: 2 },
        { date: 'Wed', fulfilled: 92, unfulfilled: 8 },
        { date: 'Thu', fulfilled: 96, unfulfilled: 4 },
        { date: 'Fri', fulfilled: 90, unfulfilled: 10 },
        { date: 'Sat', fulfilled: 99, unfulfilled: 1 },
        { date: 'Sun', fulfilled: 100, unfulfilled: 0 },
    ],
    servicePopularity: [
        { name: 'Personal Care', value: 400 },
        { name: 'Nursing', value: 300 },
        { name: 'Therapy', value: 200 },
        { name: 'Cleaning', value: 100 },
    ],
    incidents: [
        { month: 'Jan', incidents: 5, severe: 1 },
        { month: 'Feb', incidents: 8, severe: 2 },
        { month: 'Mar', incidents: 4, severe: 0 },
        { month: 'Apr', incidents: 6, severe: 1 },
        { month: 'May', incidents: 3, severe: 0 },
        { month: 'Jun', incidents: 7, severe: 2 },
    ],
    carePlanAdherence: [
        { name: 'Adherent', count: 85, fill: '#10B981' },
        { name: 'Non-Adherent', count: 15, fill: '#EF4444' }
    ],
    staffAttendance: [
        { name: '08:00', 'Monday': 5, 'Tuesday': 2, 'Wednesday': 10, 'Thursday': 5, 'Friday': 15 },
        { name: '09:00', 'Monday': 10, 'Tuesday': 5, 'Wednesday': 15, 'Thursday': 8, 'Friday': 20 },
        { name: '10:00', 'Monday': 15, 'Tuesday': 10, 'Wednesday': 20, 'Thursday': 12, 'Friday': 25 },
    ],
    clientSatisfaction: [
        { subject: 'Reliability', A: 120, fullMark: 150 },
        { subject: 'Care Quality', A: 98, fullMark: 150 },
        { subject: 'Communication', A: 86, fullMark: 150 },
        { subject: 'Punctuality', A: 99, fullMark: 150 },
        { subject: 'Professionalism', A: 110, fullMark: 150 },
    ],
    travelTime: [
        { zone: 'North', travel: 45, service: 120 },
        { zone: 'South', travel: 30, service: 150 },
        { zone: 'East', travel: 50, service: 110 },
        { zone: 'West', travel: 25, service: 160 },
    ],
    overtimeRisk: [
        { name: 'High Risk', count: 12, fill: '#EF4444' },
        { name: 'Moderate', count: 25, fill: '#F59E0B' },
        { name: 'Low Risk', count: 150, fill: '#10B981' }
    ],
    resourceAvailability: [
        { hour: '08:00', busy: 20, available: 5 },
        { hour: '10:00', busy: 22, available: 3 },
        { hour: '12:00', busy: 18, available: 7 },
        { hour: '14:00', busy: 24, available: 1 },
        { hour: '16:00', busy: 15, available: 10 },
    ]
};

export const MOCK_CLIENT_DATA = {
    budget: [
        { name: 'Used', value: 1200, fill: '#3B82F6' },
        { name: 'Remaining', value: 800, fill: '#E5E7EB' }
    ],
    wellness: [
        { date: 'Mon', score: 85 },
        { date: 'Tue', score: 88 },
        { date: 'Wed', score: 82 },
        { date: 'Thu', score: 90 },
        { date: 'Fri', score: 92 },
    ],
    continuity: [
        { month: 'Jan', percentage: 95 },
        { month: 'Feb', percentage: 98 },
        { month: 'Mar', percentage: 92 },
        { month: 'Apr', percentage: 96 },
    ]
};

export const MOCK_RN_DATA = {
    acuity: [
        { acuity: 'High', patients: 15 },
        { acuity: 'Medium', patients: 45 },
        { acuity: 'Low', patients: 30 },
    ],
    compliance: [
        { name: 'Completed', value: 120, fill: '#10B981' },
        { name: 'Pending', value: 25, fill: '#F59E0B' },
        { name: 'Overdue', value: 5, fill: '#EF4444' }
    ],
    incidents: [
        { type: 1, severity: 2, count: 150 }, // Falls, Medium
        { type: 2, severity: 1, count: 300 }, // Meds, Low
        { type: 3, severity: 3, count: 120 }, // Skin, High
        { type: 4, severity: 4, count: 100 }, // Behavior, Critical
    ],
    kpi: {
        pendingCarePlans: 5,
        dailyReviewsNeed: 12,
        supervisedPswCount: 24
    }
};

export const MOCK_PSW_DATA = {
    earnings: [
        { date: 'Mon', earnings: 120 },
        { date: 'Tue', earnings: 140 },
        { date: 'Wed', earnings: 110 },
        { date: 'Thu', earnings: 160 },
        { date: 'Fri', earnings: 150 },
    ],
    reliability: [
        { name: 'Score', count: 95, fill: '#10B981' }
    ],
    distribution: [
        { name: 'Morning', value: 15 },
        { name: 'Afternoon', value: 20 },
        { name: 'Evening', value: 5 },
        { name: 'Night', value: 2 }
    ]
};
