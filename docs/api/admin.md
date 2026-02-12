# Admin API Module

The Admin module provides mission-critical governance, user management, and system-wide orchestration.

## Technical Scope
- **Endpoints**: 15+
- **Security**: Mandatory `admin` role check.
- **Sub-Modules**: `Users`, `Visits`, `Leads`, `Incidents`, `Timesheets`, `Services`, `Content`.

## Critical Workflows
1. **User Management**: Verification and role elevation.
2. **Visit Scheduling**: Assigning PSWs to client shifts.
3. **Financial Oversight**: Timesheet review and billing logic.

## Investment Measurement
- **Complexity**: High (Orchestration of multiple platform components)
- **Status**: Modularized (Role-First)
- **Documentation**: Access Control Matrix synced.
