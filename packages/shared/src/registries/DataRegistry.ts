export enum Role {
    CLIENT = 'client',
    PSW = 'psw',
    ADMIN = 'admin',
    STAFF = 'staff',
    COORDINATOR = 'coordinator',
    FINANCE = 'finance',
}

export enum VisitStatus {
    REQUESTED = 'requested',
    SCHEDULED = 'scheduled',
    COMPLETED = 'completed',
    CANCELLED = 'cancelled',
}

export enum TicketStatus {
    OPEN = 'open',
    IN_PROGRESS = 'in_progress',
    P_RESOLVED = 'resolved', // using P_ prefix to avoid strict mode conflicts if any, though standard resolved is fine. adjusted to RESOLVED
    RESOLVED = 'resolved',
    CLOSED = 'closed',
}

export const DataRegistry = {
    Roles: Role,
    VisitStatus: VisitStatus,
    TicketStatus: TicketStatus,
    Provinces: [
        { code: 'ON', name: 'Ontario' },
        { code: 'BC', name: 'British Columbia' },
        { code: 'AB', name: 'Alberta' },
    ]
} as const;
