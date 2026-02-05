# PrimeCare Support Services - Project Specification

This document details the "As-Built" specification for the PrimeCare Platform. It outlines the structure, components, inputs, and data sources for every page across the ecosystem.

## 1. Shared Infrastructure (`packages/shared`)
The core "brain" of the frontend. All text, routes, and API endpoints are defined here to ensure consistency.
- **ContentRegistry:** Stores all static text (Mission, Hero Titles, Service Descriptions).
- **RouteRegistry:** Defines all URL paths (e.g., `/about`, `/book-now`).
- **ApiRegistry:** Defines all backend endpoints (e.g., `/v1/auth/login`).

---

## 2. Web: Marketing Website (`apps/web-marketing`)
**Target Audience:** Public, Potential Clients, Job Seekers.

### 2.1 Landing Page (`/`)
- **Visuals:** Hero Banner with Gradient, "Why Choose Us" Grid, Mission Statement.
- **Components:**
  - `Header` (Sticky): Logo (Text), Nav Links.
  - `HeroSection`: Title (`ContentRegistry.HERO.TITLE`), Subtitle, 2 CTA Buttons ("View Services", "Book Now").
  - `FeatureGrid`: 4 Cards displaying "Why Choose Us" points.
  - `Footer`: Links to Privacy, Terms, Contact.
- **Data:** Static content from `ContentRegistry`.

### 2.2 About Page (`/about`)
- **Visuals:** Clean text layout, Values Grid.
- **Components:**
  - `MissionSection`: Large typography mission statement.
  - `ValuesList`: Grid of cards (Compassion, Excellence, Integrity).
- **Data:** `ContentRegistry.ABOUT`.

### 2.3 Services Page (`/services`)
- **Visuals:** Card Grid of available services.
- **Components:**
  - `ServiceCard`:
    - **Data:** Name, Price (Starting at $X), Description.
    - **Source:** Hardcoded array matching `ContentRegistry.SERVICES`.
    - **Action:** Clicking doesn't drill down yet (future enhancement: link to individual detail pages).

### 2.4 Booking Page (`/book-now`)
- **Purpose:** Capture new leads.
- **Components:** `LeadForm`.
- **Active Inputs (Interactive):**
  - `TextBox` **Name:** Full Name.
  - `TextBox` **Email:** Email Address.
  - `TextBox` **Phone:** Phone Number.
  - `ComboBox` **Service Type:** Dropdown (Foot Care, Senior Care, etc.).
  - `TextArea` **Message:** Additional notes.
  - `Button` **Submit:** POSTs data to `/v1/public/leads`.

---

## 3. Web: Admin Portal (`apps/web-admin`)
**Target Audience:** Business Owners, Admins.

### 3.1 Dashboard (`/`)
- **Visuals:** Stats cards, Quick Actions.
- **Components:**
  - `StatsCard`: "Total Users", "Pending Leads".
  - `QuickActionTile`: Link to "View Schedule".
- **Data:** Fetches from `/v1/admin/dashboard` (Mocked/Real).

### 3.2 Schedule (`/schedule`)
- **Visuals:** Full-screen Calendar view (Month/Week/Day).
- **Components:**
  - `Calendar` (React-Big-Calendar):
    - **Data:** Visits Array `[{ title, start, end, status }]`.
    - **Source:** `GET /v1/admin/visits`.
    - **Interactive:** Clicking a slot details the visit.

---

## 4. Mobile: Client App (`apps/mobile-client`)
**Target Audience:** Clients receiving care.

### 4.1 Login Screen
- **Components:**
  - `TextInput`: **Email**.
  - `TextInput`: **Password** (Secure).
  - `Button`: **Login** (Calls `POST /v1/auth/login`).

### 4.2 Home Screen (Dashboard)
- **Visuals:** Welcome Message, "Upcoming Visits" Card.
- **Data:**
  - **User Name:** From `AuthContext` (User Session).
  - **Visits:** Pending implementation of `/v1/client/visits`.

### 4.3 Services Screen
- **Visuals:** Scrollable list of services.
- **Components:**
  - `FlatList`: Renders `ServiceCard` for each item.
  - **Data:** Fetches `GET /v1/public/services`.

### 4.4 Booking Screen
- **Purpose:** Request a specific service.
- **Active Inputs:**
  - `TextInput`: **Requested Date/Time** (e.g., "2024-02-15 09:00").
  - `TextInput` (Multiline): **Notes**.
  - `Button`: **Confirm Booking** (Calls `POST /v1/client/bookings`).

---

## 5. Mobile: PSW App (`apps/mobile-psw`)
**Target Audience:** Personal Support Workers.

### 5.1 Login Screen
- **Logic:** Restricts access to users with `role: 'psw'`.
- **Inputs:** Email, Password.

### 5.2 Visits Dashboard (`Home`)
- **Visuals:** List of assigned jobs.
- **Components:**
  - `FlatList`: Visits.
  - `StatusBadge`: Color-coded (Blue=Scheduled, Orange=In-Progress, Green=Completed).
- **Data:** Fetches `GET /v1/psw/visits`.

### 5.3 Visit Details Screen
- **Visuals:** Client Address, Actions.
- **Components:**
  - `ActionButtons`:
    - **Check In:** Visible if status is 'scheduled'. Sends GPS + Timestamp.
    - **Check Out:** Visible if status is 'in_progress'. Sends GPS + Timestamp.
- **Data:** Actions POST to `/v1/psw/visits/:id/{action}`.
