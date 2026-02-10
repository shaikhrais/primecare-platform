# PrimeCare Platform Page Route Map

This document provides a complete map of URLs to their corresponding pages and components across the platform.

---

## 📢 Web Marketing (`apps/web-marketing`)
*Public-facing site and lead generation.*

| Route Key | URL Path | Page Component | Description |
|-----------|----------|----------------|-------------|
| `HOME` | `/` | `LandingPage` | Main landing page/Hero |
| `SERVICES` | `/services` | `ServicesPage` | Overview of all services |
| `SERVICE_FOOT_CARE` | `/services/foot-care` | `FootCarePage` | Diabetic Foot Care details |
| `SERVICE_EDUCATION` | `/services/education` | `EducationPage` | Nursing & Education overview |
| `SERVICE_IT` | `/services/it-support` | `ITSupportPage` | HealthTech managed services |
| `SERVICE_SENIOR` | `/services/senior-care` | `SeniorCarePage` | Personal Care & Senior services |
| `SERVICE_FACILITY` | `/services/facility-foot-care` | `FacilityFootCarePage` | Institutional foot clinic services |
| `SERVICE_STAFFING` | `/services/staffing` | `StaffingPage` | Healthcare staffing solutions |
| `SERVICE_CERTIFICATE` | `/services/foot-care-certificate`| `FootCareCertificatePage`| Professional certification data |
| `SERVICE_PSW` | `/education/psw-training` | `PSWTrainingPage` | PSW training programs |
| `BLOG` | `/blog` | `BlogPage` | Insights and news list |
| `BLOG_DETAIL` | `/blog/:id` | `BlogPostPage` | Individual blog article |
| `CONTACT` | `/contact` | `ContactPage` | General inquiry form |
| `TERMS` | `/terms` | `TermsPage` | Terms of Service |
| `PRIVACY` | `/privacy` | `PrivacyPage` | Privacy Policy |
| `CAREERS` | `/careers` | `CareersPage` | Job listings and application |
| `ABOUT` | `/about` | `AboutPage` | Company mission and team |
| `BOOKING` | `/book-now` | `BookingPage` | Online appointment booking |
| `VOLUNTEER` | `/volunteer` | `VolunteerPage` | Volunteer application form |
| `FRANCHISE` | `/franchise` | `FranchisePage` | Business partnership details |
| `TESTIMONIALS` | `/testimonials` | `TestimonialsPage` | Customer success stories |
| `FAQ` | `/faq` | `FAQPage` | Frequently asked questions |
| `CONSULTING` | `/consulting` | `ConsultingPage` | Specialized business consulting |
| `LOGIN` | `/login` | `LoginPage` | Family Portal entry point |
| `LOGIN_CAREGIVER` | `/caregiver-login` | `CaregiverLoginPage` | PSW Portal entry point |
| `LOGIN_STAFF` | `/staff-login` | `StaffLoginPage` | Staff Hub entry point |

---

## 🏗️ Web Admin & Portals (`apps/web-admin`)
*Internal operations, client portals, and management.*

### 🛡️ Core & Authentication
| Route Key | URL Path | Page Component | Description |
|-----------|----------|----------------|-------------|
| `LOGIN` | `/login` | `Login` | Unified login (Admin/Staff/Client/PSW) |
| `REGISTER` | `/register` | `Register` | User registration |
| - | `/forgot-password` | `ForgotPassword` | Password recovery |
| - | `/reset-password` | `ResetPassword` | Set new password |
| `DASHBOARD` | `/dashboard` | `Dashboard` | Admin/Shared statistics |

### 🛠️ Admin & Staff Modules
| Route Key | URL Path | Page Component | Description |
|-----------|----------|----------------|-------------|
| `USERS` | `/users` | `UserList` | User management and invites |
| `SCHEDULE` | `/schedule` | `Schedule` | Master visit calendar |
| - | `/leads` | `LeadsPage` | Marketing lead tracking |
| - | `/services` | `ServicesPage` | Service catalog/rate editor |
| - | `/content` | `ContentManager` | Blog/FAQ content editor |
| - | `/audits` | `CallAuditPage` | AI review of voice calls |
| - | `/customers` | `CustomerList` | Client/Patient records |
| - | `/support` | `SupportDashboard` | Staff ticketing/support queue |
| - | `/incidents` | `IncidentList` | Safety and incident reporting |
| - | `/timesheets` | `TimesheetList` | Payroll and time verification |
| - | `/settings` | `SettingsPage` | Global system configurations |

### 💼 Manager Module
| Route Key | URL Path | Page Component | Description |
|-----------|----------|----------------|-------------|
| - | `/manager/dashboard` | `ManagerDashboard` | Field manager overview |
| - | `/manager/daily-entry`| `DailyEntryPage` | Shift documentation (ADLs/Vitals) |
| - | `/reports` | `div (Placeholder)` | Operational reporting |

### 🏥 Client & PSW Portals (Shared Dashboard)
| Route Key | URL Path | Page Component | Description |
|-----------|----------|----------------|-------------|
| - | `/bookings` | `BookingsPage` | Client: Manage care requests |
| - | `/billing` | `BillingPage` | Client: Invoices and payments |
| - | `/earnings` | `EarningsPage` | PSW: Compensation tracking |
| - | `/shifts` | `ShiftsPage` | PSW: Shift history and current |
| - | `/profile` | `ProfilePage` | Shared: Personal profile settings |
| - | `/visits/:id` | `VisitDetails` | Shared: Detailed shift data |
| - | `/support/chat` | `MessagingPortal` | Portal-to-Staff secure chat |

---

> [!TIP]
> Use these routes in your `cy.visit()` calls alongside the **Selector Access List** for full end-to-end test coverage.
