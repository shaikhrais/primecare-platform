# 🧠 PRIMECARE MASTER TEST INVENTORY

This document serves as the "North Star" for the PrimeCare Platform's QA coverage. It maps every critical user flow and technical requirement to a testable unit.

---

## 0️⃣ PLATFORM FOUNDATION
### 0.1 Application Health
- App loads without white screen
- No uncaught JS exceptions
- No severe console errors
- Build version displayed (if exists)
- Environment badge correct (dev/stage/prod)

### 0.2 Routing
- All marketing routes return 200
- All admin routes require auth
- Invalid route → Not Found page
- Trailing slash handling
- Case sensitivity handling

---

## 1️⃣ AUTHENTICATION MODULE
### 1.1 Login
- Valid login (staff/manager/psw/client)
- Invalid password/email handling
- Empty form submit
- Password visibility toggle
- Remember me (if exists)

### 1.2 Register
- Valid registration
- Duplicate email prevention
- Required field validation
- Password strength rules
- Confirmation mismatch

### 1.3 Forgot / Reset
- Request reset with valid/invalid email
- Expired/Invalid token handling
- Successful reset & Re-login

### 1.4 Logout
- Logout clears token
- Logout redirects to login
- Protected route blocking after logout

---

## 2️⃣ ROLE-BASED ACCESS CONTROL (SECURITY)
### 2.1 Access Matrix Enforcement
- Verify access/redirection for: Guest, Client, PSW, Manager, Staff/Admin
- Enforce direct URL blocking
- Enforce hidden menu items
- Deep link unauthorized access blocking

---

## 3️⃣ MARKETING WEBSITE
### 3.1 Page Rendering
- Home (Hero), Services (List/Detail), Blog (List/Detail), Contact, FAQ, Testimonials, Careers, About.
### 3.2 SEO
- Title/Meta tags, Canonical tags, OpenGraph tags, H1 presence/uniqueness.
### 3.3 lead Form
- Required/Email validation, Success/Failure states, Loading indicators.

---

## 4️⃣ DASHBOARDS (ALL ROLES)
- Stats cards, Quick actions (role-based), Widgets, Loading/Error states.

---

## 5️⃣ USERS MANAGEMENT (/users)
- List load, Pagination, Sorting, Search, CRUD operations, Role assignment.

---

## 6️⃣ SCHEDULING (/schedule)
- Calendar rendering, Shift CRUD, PSW assignment, Conflict detection, Filters.

---

## 7️⃣ LEADS / CRM (/leads)
- Lead CRUD, Conversion, Search, Filter by status, Badges.

---

## 8️⃣ TIMESHEETS (/timesheets)
- Approval/Rejection, Filtering, Exporting, Error handling.

---

## 9️⃣ INCIDENTS (/incidents)
- Incident CRUD, Assignment, Status change, Attachments, Filtering.

---

## 🔟 BOOKINGS (/bookings)
- Client-view vs Staff-view, CRUD operations, Manager filtering.

---

## 1️⃣1️⃣ BILLING (/billing)
- History, Detail view, Status badges, Exporting, Payment failure handling.

---

## 12 EARNINGS (/earnings – PSW)
- Summary load, Date filters, Exporting, Empty/Error states.

---

## 13 SHIFTS (/shifts – PSW)
- Accept/Decline logic, Status updates, Detail page, Visit navigation.

---

## 14 VISITS (/visits/:id)
- Detail load, Client info, Notes CRUD, Submit visit, Status change.

---

## 15 SUPPORT CHAT (/support/chat)
- Thread list, Messaging flow, Attachments, Auto-scroll, Sync states.

---

## 16 SETTINGS (/settings)
- Org info updates, Validation, Role restrictions.

---

## 17 PROFILE (/profile)
- CRUD operations, Password updates, Avatar upload, Validation.

---

## 18 CONTENT MANAGER (/content)
- CMS operations, Publishing logic, Preview mode.

---

## 19 REPORTS (/reports)
- Page load, Date filters, Exporting, Graph rendering.

---

## 20 API CONTRACT TESTS
- Verify 200 OK + Payload shape for: Login, Profile, Users, Schedule, Leads, Timesheets, Visits, Incidents, Billing.

---

## 21 STATE TESTS (FOR ROBUSTNESS)
- Loading, Empty, Error (500), Unauthorized (401), Forbidden (403).

---

## 22 PERFORMANCE TESTS (LIGHT)
- Core page load speeds, Payload optimization, Asset checks.

---

## 23 SECURITY TESTS
- Token safety, XSS/Injection prevention, CSRF (if applicable), RBAC escalation attempts.

---

## 24 RESPONSIVE TESTS
- Mobile nav, No horizontal scroll, Table responsiveness, Modal sizing.

---

## 25 ACCESSIBILITY (A11y)
- H1 uniqueness, Input labels, Aria-label, Contrast, Tab-index, Focus states.

---

## 26 DATA INTEGRITY
- Persistance checks (CRUD flow verification), Cache/Refresh consistency.

---

## 27 QUICK ACTIONS
- Role-based visibility, Navigation targets, Modal flow, Success/Error toasts.

---

## 28 NOTIFICATION SYSTEM
- Toast stacking, Auto-dismiss, Type-based styling (Success/Error).

---

## 29 EDGE CASES
- High-volume data sets, String injection, Network latency/Offline handling.

---

## 30 CI TAGGING STRATEGY
- `@smoke`, `@security`, `@contract`, `@regression`, `@performance`, `@api`, `@portal`, `@admin`, `@marketing`.
