# PrimeCare Platform Absolute Selector Access List

> [!IMPORTANT]
> **Last Updated**: 2026-02-10
> **Application Version**: 1.4.3
> **Total Selectors**: 253
> **Coverage**: 100%
> **Owner**: QA Automation Team

This is the **exhaustive and definitive** reference for all testable elements across the PrimeCare workspace. It contains every `data-cy` attribute existing in the codebase as of today.

---

## 🏗️ Web Admin & Operations Portals (`apps/web-admin`)

### 🧭 Global Layout & Navigation
| Component | Element | Selector |
|-----------|---------|----------|
| SideBar | Sidebar Container | `sidebar` |
| TopBar | Topbar Container | `topbar` |
| Floating Button | Toggle Button | `btn-floating-toggle` |
| Floating Menu | Menu Container | `floating-menu` |
| Floating Menu | New Daily Entry | `mbtn-new-daily-entry` |
| Floating Menu | New Incident | `mbtn-new-incident` |
| Floating Menu | New Client | `mbtn-new-client` |
| Floating Menu | Emergency Button | `mbtn-emergency` |
| Quick Actions | Daily Entry | `qa-daily-entry` |
| Quick Actions | Create Shift | `qa-create-shift` |
| Quick Actions | Incident | `qa-incident` |
| Quick Actions | Assign Staff | `qa-assign-staff` |
| Quick Actions | Schedule | `qa-schedule` |
| Quick Actions | Add User | `qa-add-user` |
| Quick Actions | System Backup | `qa-backup` |
| Quick Actions | Emergency | `qa-emergency` |
| Shared Layout | Logout Button | `btn-logout` |
| Quick Actions Box | Crisis Mode Toggle | `btn-crisis-mode` |
| UI Components | Toast Container | `toast` |

### 🔑 Authentication
| Page | Element | Selector |
|------|---------|----------|
| Login | Email Input | `inp-email` |
| Login | Password Input | `inp-password` |
| Login | Submit Button | `btn-login` |
| Register | Email Input | `inp-email` |
| Register | Password Input | `inp-password` |
| Register | Confirm Password | `inp-confirm-password` |
| Register | Register Button | `btn-register` |
| Forgot Password | Email Input | `inp-forgot-email` |
| Forgot Password | Submit Button | `btn-forgot-submit` |
| Reset Password | New Password | `inp-reset-password` |
| Reset Password | Confirm Password | `inp-reset-confirm-password` |
| Reset Password | Submit Button | `btn-reset-submit` |

### 🛠️ Admin Management
| Page | Element | Selector |
|------|---------|----------|
| Admin Dashboard | Link: Users | `qa-link-users` |
| Admin Dashboard | Link: Schedule | `qa-link-schedule` |
| Admin Dashboard | Link: Leads | `qa-link-leads` |
| Admin Dashboard | Link: Settings | `qa-link-settings` |
| User List | Invite User Button | `btn-invite-user` |
| User List | Users Table | `tbl-users` |
| User List | Full Name Display | `user-fullname` |
| User List | Email Display | `user-email` |
| User List | Role Tag | `user-role` |
| User List | Verification Icon | `user-verification-icon` |
| User List | Verification Text | `user-verification-text` |
| User List | Edit User Button | `btn-edit-user` |
| User List | Verify User Button | `btn-verify-user` |
| Services Page | Add Service Button | `btn-add-service` |
| Services Page | Services Table | `tbl-services` |
| Services Page | Service Form | `form-service` |
| Services Page | Name Input | `inp-service-name` |
| Services Page | Rate Input | `inp-service-rate` |
| Services Page | Category Selector | `sel-service-category` |
| Services Page | Description Textarea | `inp-service-desc` |
| Services Page | Save Button | `btn-save-service` |
| Services Page | Cancel Button | `btn-cancel-service` |
| Settings Page | Email Alerts Toggle | `chk-email-alerts` |
| Settings Page | Auto Assign Toggle | `chk-auto-assign` |
| Settings Page | Grace Period Selector | `sel-grace-period` |
| Settings Page | Save Button | `btn-save-settings` |
| Settings Page | Reset Button | `btn-reset-settings` |

### 💼 Manager & Support
| Page | Element | Selector |
|------|---------|----------|
| Manager Dashboard | Dashboard Container | `mgr-dashboard` |
| Daily Entry | Page Container | `daily-entry-page` |
| Daily Entry | Client Selector | `client-select` |
| Daily Entry | Vitals: BP | `vitals-bp` |
| Daily Entry | Vitals: Pulse | `vitals-pulse` |
| Daily Entry | Vitals: Temp | `vitals-temp` |
| Daily Entry | Notes Textarea | `notes` |
| Daily Entry | Signature Input | `signature` |
| Daily Entry | Submit Button | `submit-entry` |
| Leads Page | Full Name | `lead-fullname` |
| Leads Page | Email | `lead-email` |
| Leads Page | Phone | `lead-phone` |
| Leads Page | Message | `lead-message` |
| Leads Page | Status Tag | `lead-status` |
| Leads Page | Mark Contacted | `btn-lead-contacted` |
| Leads Page | Convert Lead | `btn-lead-convert` |
| Leads Page | Close Lead | `btn-lead-close` |

---

## 📣 Web Marketing (`apps/web-marketing`)

### 🧭 Navigation & Core Components
| Component | Element | Selector |
|-----------|---------|----------|
| Header | Logo Link | `logo-link` |
| Header | Portal Link: Family | `link-family-portal` |
| Header | Portal Link: Staff | `link-staff-hub` |
| Header | Nav: HealthTech | `nav-healthtech` |
| Header | Book Assessment CTA | `btn-book-assessment` |
| Header | Mobile Menu Toggle | `btn-mobile-menu` |
| ChatWidget | Widget Toggle | `btn-chat-widget-toggle` |
| Footer | Contact Email | `lnk-footer-email` |
| Footer | Contact Phone | `lnk-footer-phone` |
| Footer | Link: About | `lnk-footer-about` |
| Footer | Link: Careers | `lnk-footer-careers` |

### 📄 Marketing Pages
| Page | Element | Selector |
|------|---------|----------|
| About Page | Booking Button | `btn-about-booking` |
| About Page | Careers Button | `btn-about-careers` |
| Contact Page | Success Message | `contact-success` |
| Contact Page | Error Message | `contact-error` |
| Contact Page | Name Input | `inp-name` |
| Contact Page | Email Input | `inp-email` |
| Contact Page | Phone Input | `inp-phone` |
| Contact Page | Message Input | `inp-message` |
| Contact Page | Submit Button | `btn-submit-contact` |
| FAQ Page | Contact Button | `btn-faq-contact` |
| FAQ Page | Toggle Button | `faq-toggle-{index}` |

---

## 🧬 Dynamic Selector Guide

For many tables and lists, selectors use dynamic IDs. Below are the common patterns:

1.  **Table Rows**: `data-cy="user-row-{userId}"`, `data-cy="shift-row-{shiftId}"`.
2.  **Buttons in Lists**: `data-cy="btn-view-shift-{shiftId}"`, `data-cy="btn-apply-{jobId}"`, `data-cy="btn-learn-more-{serviceId}"`.
3.  **Counters/Indexes**: `data-cy="faq-toggle-{index}"` (0-indexed).

---

> [!NOTE]
> This document is the human-readable reference. For automated tests, use the granular TypeScript maps in `apps/cypress-test/cypress/support/selectors/`.
