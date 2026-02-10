# PrimeCare Platform Absolute Page Access List

> [!IMPORTANT]
> **Last Updated**: 2026-02-10
> **Application Version**: 1.4.3
> **Total Pages**: 51
> **Global Coverage**: 100%
> **Owner**: QA Automation Team

This document is the **definitive audit reference** for all navigable pages across the PrimeCare Web ecosystem.

---

## 📢 Web Marketing Portfolio (`apps/web-marketing`)

| Route Key | URL Path | Page Component | Functional Area |
|-----------|----------|----------------|-----------------|
| `HOME` | `/` | `LandingPage` | Customer Hero/Entry |
| `SERVICES` | `/services` | `ServicesPage` | Service Overview |
| `SERVICE_FOOT_CARE` | `/services/foot-care` | `FootCarePage` | Specialized Care |
| `SERVICE_EDUCATION` | `/services/education` | `EducationPage` | Professional Training |
| `SERVICE_IT` | `/services/it-support` | `ITSupportPage` | Managed Services |
| `SERVICE_SENIOR` | `/services/senior-care` | `SeniorCarePage` | Personal Care |
| `SERVICE_FACILITY` | `/services/facility-foot-care`| `FacilityFootCarePage`| B2B Services |
| `SERVICE_STAFFING` | `/services/staffing` | `StaffingPage` | Recruitment |
| `SERVICE_CERTIFICATE` | `/services/foot-care-certificate`| `FootCareCertificatePage`| Education |
| `SERVICE_PSW` | `/education/psw-training` | `PSWTrainingPage` | Education |
| `BLOG` | `/blog` | `BlogPage` | Content/Insights |
| `BLOG_DETAIL` | `/blog/:id` | `BlogPostPage` | Content/Insights |
| `CONTACT` | `/contact` | `ContactPage` | Lead Generation |
| `TERMS` | `/terms` | `TermsPage` | Legal |
| `PRIVACY` | `/privacy` | `PrivacyPage` | Legal |
| `CAREERS` | `/careers` | `CareersPage` | HR/Recruitment |
| `ABOUT` | `/about` | `AboutPage` | Company Info |
| `BOOKING` | `/book-now` | `BookingPage` | Online Booking |
| `VOLUNTEER` | `/volunteer` | `VolunteerPage` | Community |
| `FRANCHISE` | `/franchise` | `FranchisePage` | Partnership |
| `TESTIMONIALS` | `/testimonials` | `TestimonialsPage` | Social Proof |
| `FAQ` | `/faq` | `FAQPage` | Support |
| `CONSULTING` | `/consulting` | `ConsultingPage` | Specialized |
| `LOGIN` | `/login` | `LoginPage` | Family Auth |
| `LOGIN_CAREGIVER` | `/caregiver-login` | `CaregiverLoginPage` | PSW Auth |
| `LOGIN_STAFF` | `/staff-login` | `StaffLoginPage` | Admin Auth |

---

## 🏗️ Web Admin & Portals Portfolio (`apps/web-admin`)

### 🛡️ Authentication & Core
| Route Key | URL Path | Page Component | Functional Area |
|-----------|----------|----------------|-----------------|
| `LOGIN` | `/login` | `Login` | Unified Auth |
| `REGISTER` | `/register` | `Register` | New Account |
| - | `/forgot-password` | `ForgotPassword` | Recovery |
| - | `/reset-password` | `ResetPassword` | Recovery |
| `DASHBOARD` | `/dashboard` | `Dashboard` | Landing/Stats |

### 🛠️ Admin & Staff Operations
| Route Key | URL Path | Page Component | Functional Area |
|-----------|----------|----------------|-----------------|
| `USERS` | `/users` | `UserList` | Staff Management |
| `SCHEDULE` | `/schedule` | `Schedule` | Scheduling |
| - | `/leads` | `LeadsPage` | CRM/Leads |
| - | `/services` | `ServicesPage` | Ops/Finance |
| - | `/content` | `ContentManager` | CMS/Marketing |
| - | `/audits` | `CallAuditPage` | QA/Compliance |
| - | `/customers` | `CustomerList` | CRM/Master Data |
| - | `/support` | `SupportDashboard` | Helpdesk |
| - | `/incidents` | `IncidentList` | Risk/Safety |
| - | `/timesheets` | `TimesheetList` | Payroll |
| - | `/settings` | `SettingsPage` | Configuration |

### 💼 Manager Module
| Route Key | URL Path | Page Component | Functional Area |
|-----------|----------|----------------|-----------------|
| - | `/manager/dashboard` | `ManagerDashboard` | Operations |
| - | `/manager/daily-entry`| `DailyEntryPage` | Documentation |
| - | `/reports` | `div (Placeholder)` | Reporting |

### 🏥 Client & PSW Portals
| Route Key | URL Path | Page Component | Functional Area |
|-----------|----------|----------------|-----------------|
| - | `/bookings` | `BookingsPage` | Client Portal |
| - | `/billing` | `BillingPage` | Client Portal |
| - | `/earnings` | `EarningsPage` | PSW Portal |
| - | `/shifts` | `ShiftsPage` | PSW Portal |
| - | `/profile` | `ProfilePage` | Shared Settings |
| - | `/visits/:id` | `VisitDetails` | Shared Data |
| - | `/support/chat` | `MessagingPortal` | Communication |

---

> [!NOTE]
> This list is synchronized with the `shared` RouteRegistry constants. For interaction elements, refer to the [Selector Access List](file:///c:/Users/User/Projects/psw_app/apps/cypress-test/cypress/docs/selector_access_list.md).
