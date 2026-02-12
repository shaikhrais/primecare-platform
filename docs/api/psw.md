# PSW API Module

The PSW module handles all caregiver-facing operations, including scheduling, daily reporting, and incident management.

## Technical Scope
- **Endpoints**: 8+
- **Security**: Mandatory Auth + `requireClientAssignedToPSW` Ownership Guard.
- **Data Flow**: Prisma Client (PostgreSQL) via service layer.

## Critical Workflows
1. **Visit Check-In/Out**: Geofenced shift transitions.
2. **Daily Care Entry**: ADL and clinical logging for clients.
3. **Incident Reporting**: Real-time safety alerting.

## Investment Measurement
- **Complexity**: High (Geospatial + Real-time durable objects)
- **Status**: Modularized (Role-First)
- **Test Coverage**: Cypress E2E functional tests active.
