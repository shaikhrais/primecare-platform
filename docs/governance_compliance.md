# PrimeCare Governance & Compliance Document (v1.0)

## 1. Data Privacy & Security (HIPAA/PIPEDA Alignment)
The PrimeCare platform is designed to handle sensitive health information (PHI) with the following controls:
- **Authentication**: Mandatory HttpOnly, Secure, SameSite=Strict cookies. No local storage of JWTs.
- **Vulnerability Protection**: Strict IDOR prevention at the middleware layer via `tenantId` verification.
- **Mass Assignment**: All user role elevations are restricted to dedicated, audited endpoints.

## 2. Role-Based Access Control (RBAC)
Access is granted on a "Least Privilege" basis. The following roles are strictly enforced:
- **Admin**: Full system health, backups, and user lifecycle.
- **RN (Clinical)**: Care plan approval and clinical oversight. Cannot modify billing or system settings.
- **Manager**: Operational scheduling and client admission.
- **PSW**: Visit-level data recording only for assigned clients. No access to other psw or client profiles.

## 3. Clinical Integrity & Safety
- **Care Plans**: Must be created/signed by an RN before a PSW can submit a Daily Entry.
- **Incidents**: Real-time logging with mandatory escalation flags for high-severity events.
- **Audit Trails**: Every write operation (Create/Update/Delete) is logged with Actor ID and Resource metadata.

## 4. Operational Continuity
- **Backups**: Encrypted daily backups stored in isolated S3-compatible buckets.
- **Offline Access**: Critical PSW tasks support temporary local caching to prevent data loss.

## 5. Compliance Checklist for Daily Activity
- [ ] Is every visit recorded via a Daily Entry?
- [ ] Has the RN reviewed 100% of high-risk client entries this week?
- [ ] Are all incident reports closed with an action summary?
- [ ] Does every user have an active Tenant assignment?
