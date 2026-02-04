-- Initial Migration for PrimeCare Support Services

-- Extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Enums
CREATE TYPE user_role AS ENUM ('client', 'psw', 'coordinator', 'admin', 'finance');
CREATE TYPE doc_status AS ENUM ('pending', 'verified', 'rejected');
CREATE TYPE visit_status AS ENUM ('requested', 'scheduled', 'assigned', 'en_route', 'arrived', 'in_progress', 'completed', 'cancelled');
CREATE TYPE event_type AS ENUM ('check_in', 'check_out');
CREATE TYPE event_result AS ENUM ('success', 'rejected');
CREATE TYPE incident_type AS ENUM ('fall_risk', 'refusal', 'no_show', 'safety', 'other');
CREATE TYPE incident_status AS ENUM ('open', 'investigating', 'resolved');
CREATE TYPE timesheet_status AS ENUM ('draft', 'submitted', 'approved', 'rejected');
CREATE TYPE invoice_status AS ENUM ('draft', 'unpaid', 'paid', 'void');

-- Tables

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    role user_role NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    password_hash TEXT NOT NULL,
    status TEXT DEFAULT 'active',
    last_login_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE client_profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID UNIQUE NOT NULL REFERENCES users(id),
    full_name TEXT NOT NULL,
    dob DATE,
    address_line1 TEXT,
    address_line2 TEXT,
    city TEXT,
    province TEXT,
    postal_code TEXT,
    lat DOUBLE PRECISION,
    lng DOUBLE PRECISION,
    emergency_contact_name TEXT,
    emergency_contact_phone TEXT,
    preferences_json JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE psw_profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID UNIQUE NOT NULL REFERENCES users(id),
    full_name TEXT NOT NULL,
    bio TEXT,
    languages TEXT[],
    service_areas TEXT[],
    availability_json JSONB,
    is_approved BOOLEAN DEFAULT FALSE,
    approved_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE psw_documents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    psw_id UUID NOT NULL REFERENCES psw_profiles(id),
    doc_type TEXT NOT NULL,
    file_key TEXT NOT NULL,
    status doc_status DEFAULT 'pending',
    expiry_date DATE,
    verified_by UUID REFERENCES users(id),
    verified_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE services (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    description TEXT,
    base_rate_hourly NUMERIC(10, 2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE visits (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    client_id UUID NOT NULL REFERENCES client_profiles(id),
    service_id UUID NOT NULL REFERENCES services(id),
    requested_start_at TIMESTAMPTZ NOT NULL,
    duration_minutes INTEGER NOT NULL,
    status visit_status DEFAULT 'requested',
    assigned_psw_id UUID REFERENCES psw_profiles(id),
    service_address_line1 TEXT,
    service_address_line2 TEXT,
    service_city TEXT,
    service_province TEXT,
    service_postal_code TEXT,
    service_lat DOUBLE PRECISION,
    service_lng DOUBLE PRECISION,
    client_notes TEXT,
    coordinator_notes TEXT,
    cancellation_reason TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE visit_check_events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    visit_id UUID NOT NULL REFERENCES visits(id),
    psw_id UUID NOT NULL REFERENCES psw_profiles(id),
    event_type event_type NOT NULL,
    lat DOUBLE PRECISION,
    lng DOUBLE PRECISION,
    accuracy_m DOUBLE PRECISION,
    computed_distance_m DOUBLE PRECISION,
    device_time_iso TIMESTAMPTZ,
    server_time TIMESTAMPTZ DEFAULT NOW(),
    result event_result NOT NULL,
    reject_reason TEXT,
    is_override BOOLEAN DEFAULT FALSE,
    override_by_user_id UUID REFERENCES users(id),
    override_reason TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE visit_notes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    visit_id UUID NOT NULL REFERENCES visits(id),
    psw_id UUID NOT NULL REFERENCES psw_profiles(id),
    note_text TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE visit_checklists (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    visit_id UUID NOT NULL REFERENCES visits(id),
    psw_id UUID NOT NULL REFERENCES psw_profiles(id),
    checklist_json JSONB NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE incidents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    visit_id UUID REFERENCES visits(id),
    reporter_user_id UUID NOT NULL REFERENCES users(id),
    type incident_type NOT NULL,
    description TEXT NOT NULL,
    status incident_status DEFAULT 'open',
    resolution_notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE timesheets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    psw_id UUID NOT NULL REFERENCES psw_profiles(id),
    week_id TEXT NOT NULL, -- "2026-W05"
    total_minutes INTEGER DEFAULT 0,
    status timesheet_status DEFAULT 'draft',
    submitted_at TIMESTAMPTZ,
    reviewed_by UUID REFERENCES users(id),
    reviewed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE timesheet_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    timesheet_id UUID NOT NULL REFERENCES timesheets(id),
    visit_id UUID NOT NULL REFERENCES visits(id),
    minutes INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE invoices (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    client_id UUID NOT NULL REFERENCES client_profiles(id),
    status invoice_status DEFAULT 'draft',
    currency TEXT DEFAULT 'CAD',
    subtotal NUMERIC(10, 2),
    tax NUMERIC(10, 2),
    total NUMERIC(10, 2),
    stripe_invoice_id TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    invoice_id UUID NOT NULL REFERENCES invoices(id),
    stripe_payment_intent_id TEXT,
    amount NUMERIC(10, 2),
    status TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE messages_threads (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    thread_type TEXT NOT NULL, -- client_coordinator, psw_coordinator
    client_id UUID REFERENCES client_profiles(id),
    psw_id UUID REFERENCES psw_profiles(id),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    thread_id UUID NOT NULL REFERENCES messages_threads(id),
    sender_user_id UUID NOT NULL REFERENCES users(id),
    body_text TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    actor_user_id UUID REFERENCES users(id),
    action TEXT NOT NULL,
    resource_type TEXT NOT NULL,
    resource_id UUID,
    metadata_json JSONB,
    ip_address TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE leads (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    full_name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT,
    message TEXT,
    source TEXT NOT NULL,
    status TEXT DEFAULT 'new',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Blog Tables
CREATE TABLE blog_posts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    excerpt TEXT,
    content_html TEXT,
    status TEXT DEFAULT 'draft',
    published_at TIMESTAMPTZ,
    author_user_id UUID REFERENCES users(id),
    feature_image_doc_id UUID, -- Placeholder for R2 link/doc table
    seo_title TEXT,
    seo_description TEXT,
    canonical_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
