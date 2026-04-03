-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "password_hash" TEXT,
    "osm_id" TEXT,
    "status" TEXT DEFAULT 'active',
    "resetToken" TEXT,
    "resetTokenExpiry" DATETIME,
    "last_login_at" DATETIME,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "roles" TEXT NOT NULL DEFAULT 'client',
    CONSTRAINT "users_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "tenants" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'active',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "business_number" TEXT,
    "support_email" TEXT,
    "logo_url" TEXT,
    "tax_settings" TEXT,
    "branding_config" TEXT,
    "stripe_account_id" TEXT,
    "onboarding_step" INTEGER NOT NULL DEFAULT 1,
    "allowed_vpn_ranges" TEXT NOT NULL,
    "enforce_vpn" BOOLEAN NOT NULL DEFAULT false,
    "require_device_approval" BOOLEAN NOT NULL DEFAULT false,
    "max_devices_per_user" INTEGER NOT NULL DEFAULT 5,
    "cors_allowed_origins" TEXT NOT NULL,
    "cors_allowed_methods" TEXT NOT NULL,
    "cors_allowed_headers" TEXT NOT NULL,
    "tax_percentage" DECIMAL,
    "parent_tenant_id" TEXT,
    CONSTRAINT "tenants_parent_tenant_id_fkey" FOREIGN KEY ("parent_tenant_id") REFERENCES "tenants" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "registries" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "section" TEXT,
    "metadata" TEXT,
    "tenant_id" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "registries_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "api_keys" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "key" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'active',
    "tenant_id" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "last_used_at" DATETIME,
    CONSTRAINT "api_keys_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "client_profiles" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "user_id" TEXT NOT NULL,
    "full_name" TEXT NOT NULL,
    "dob" DATETIME,
    "address_line1" TEXT,
    "address_line2" TEXT,
    "city" TEXT,
    "province" TEXT,
    "postal_code" TEXT,
    "lat" REAL,
    "lng" REAL,
    "emergency_contact_name" TEXT,
    "emergency_contact_phone" TEXT,
    "preferences_json" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "franchise_id" TEXT,
    CONSTRAINT "client_profiles_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "client_profiles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "client_profiles_franchise_id_fkey" FOREIGN KEY ("franchise_id") REFERENCES "franchises" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "psw_profiles" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "user_id" TEXT NOT NULL,
    "full_name" TEXT NOT NULL,
    "bio" TEXT,
    "languages" TEXT NOT NULL,
    "service_areas" TEXT NOT NULL,
    "availability_json" TEXT,
    "is_approved" BOOLEAN NOT NULL DEFAULT false,
    "approved_at" DATETIME,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    "address" TEXT,
    "avatar_url" TEXT,
    "skills" TEXT NOT NULL,
    CONSTRAINT "psw_profiles_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "psw_profiles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "visits" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_id" TEXT NOT NULL,
    "service_id" TEXT NOT NULL,
    "requested_start_at" DATETIME NOT NULL,
    "duration_minutes" INTEGER NOT NULL,
    "status" TEXT DEFAULT 'requested',
    "assigned_psw_id" TEXT,
    "service_address_line1" TEXT,
    "service_address_line2" TEXT,
    "service_city" TEXT,
    "service_province" TEXT,
    "service_postal_code" TEXT,
    "service_lat" REAL,
    "service_lng" REAL,
    "client_notes" TEXT,
    "coordinator_notes" TEXT,
    "cancellation_reason" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "booking_id" TEXT,
    "crisis_mode" BOOLEAN DEFAULT false,
    "priority" TEXT DEFAULT 'normal',
    "required_skills" TEXT NOT NULL,
    "is_surge_active" BOOLEAN DEFAULT false,
    "surge_multiplier" REAL DEFAULT 1.0,
    CONSTRAINT "visits_assigned_psw_id_fkey" FOREIGN KEY ("assigned_psw_id") REFERENCES "psw_profiles" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "visits_booking_id_fkey" FOREIGN KEY ("booking_id") REFERENCES "bookings" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "visits_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "visits_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "services" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "visits_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "services" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "base_rate_hourly" DECIMAL,
    "provider_rate_hourly" DECIMAL,
    "is_active" BOOLEAN DEFAULT true,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "is_featured" BOOLEAN NOT NULL DEFAULT false,
    CONSTRAINT "services_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "visit_check_events" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "visit_id" TEXT NOT NULL,
    "psw_id" TEXT NOT NULL,
    "event_type" TEXT NOT NULL,
    "lat" REAL,
    "lng" REAL,
    "accuracy_m" REAL,
    "computed_distance_m" REAL,
    "device_time_iso" DATETIME,
    "server_time" DATETIME DEFAULT CURRENT_TIMESTAMP,
    "result" TEXT NOT NULL,
    "reject_reason" TEXT,
    "is_override" BOOLEAN DEFAULT false,
    "override_by_user_id" TEXT,
    "override_reason" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "visit_check_events_override_by_user_id_fkey" FOREIGN KEY ("override_by_user_id") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "visit_check_events_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "visit_check_events_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "visit_check_events_visit_id_fkey" FOREIGN KEY ("visit_id") REFERENCES "visits" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "visit_notes" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "visit_id" TEXT NOT NULL,
    "psw_id" TEXT NOT NULL,
    "note_text" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "visit_notes_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "visit_notes_visit_id_fkey" FOREIGN KEY ("visit_id") REFERENCES "visits" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "visit_checklists" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "visit_id" TEXT NOT NULL,
    "psw_id" TEXT NOT NULL,
    "checklist_json" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "visit_checklists_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "visit_checklists_visit_id_fkey" FOREIGN KEY ("visit_id") REFERENCES "visits" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "incidents" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "visit_id" TEXT,
    "reporter_user_id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "status" TEXT DEFAULT 'open',
    "resolution_notes" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "acknowledged_at" DATETIME,
    "acknowledged_by" TEXT,
    CONSTRAINT "incidents_acknowledged_by_fkey" FOREIGN KEY ("acknowledged_by") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "incidents_reporter_user_id_fkey" FOREIGN KEY ("reporter_user_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "incidents_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "incidents_visit_id_fkey" FOREIGN KEY ("visit_id") REFERENCES "visits" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "timesheets" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "psw_id" TEXT NOT NULL,
    "week_id" TEXT NOT NULL,
    "total_minutes" INTEGER DEFAULT 0,
    "status" TEXT DEFAULT 'draft',
    "submitted_at" DATETIME,
    "reviewed_by" TEXT,
    "reviewed_at" DATETIME,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "timesheets_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "timesheets_reviewed_by_fkey" FOREIGN KEY ("reviewed_by") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "timesheets_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "timesheet_items" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "timesheet_id" TEXT NOT NULL,
    "visit_id" TEXT NOT NULL,
    "minutes" INTEGER NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "timesheet_items_timesheet_id_fkey" FOREIGN KEY ("timesheet_id") REFERENCES "timesheets" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "timesheet_items_visit_id_fkey" FOREIGN KEY ("visit_id") REFERENCES "visits" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "invoices" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_id" TEXT NOT NULL,
    "status" TEXT DEFAULT 'draft',
    "currency" TEXT DEFAULT 'CAD',
    "subtotal" DECIMAL,
    "tax" DECIMAL,
    "total" DECIMAL,
    "stripe_invoice_id" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "invoices_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "invoices_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "payments" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "invoice_id" TEXT NOT NULL,
    "stripe_payment_intent_id" TEXT,
    "amount" DECIMAL,
    "status" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "payments_invoice_id_fkey" FOREIGN KEY ("invoice_id") REFERENCES "invoices" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "messages_threads" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "thread_type" TEXT NOT NULL,
    "client_id" TEXT,
    "psw_id" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "messages_threads_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "messages_threads_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "messages_threads_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "messages" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "thread_id" TEXT NOT NULL,
    "sender_user_id" TEXT NOT NULL,
    "body_text" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "messages_sender_user_id_fkey" FOREIGN KEY ("sender_user_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "messages_thread_id_fkey" FOREIGN KEY ("thread_id") REFERENCES "messages_threads" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "audit_logs" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "actor_user_id" TEXT,
    "action" TEXT NOT NULL,
    "resource_type" TEXT NOT NULL,
    "resource_id" TEXT,
    "metadata_json" TEXT,
    "device_id" TEXT,
    "ip_address" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "audit_logs_actor_user_id_fkey" FOREIGN KEY ("actor_user_id") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "audit_logs_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "system_events" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tenant_id" TEXT NOT NULL,
    "operation" TEXT NOT NULL,
    "model_name" TEXT NOT NULL,
    "entity_id" TEXT,
    "payload" TEXT,
    "previous_data" TEXT,
    "actor_user_id" TEXT,
    "device_id" TEXT,
    "ip_address" TEXT,
    "checksum" TEXT NOT NULL DEFAULT '',
    "previous_checksum" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "system_events_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "system_events_actor_user_id_fkey" FOREIGN KEY ("actor_user_id") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "leads" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "full_name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "message" TEXT,
    "source" TEXT NOT NULL,
    "status" TEXT DEFAULT 'new',
    "service_interest" TEXT NOT NULL,
    "notes" TEXT,
    "converted_to_user_id" TEXT,
    "conversion_date" DATETIME,
    "tenant_id" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "leads_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "bookings" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_id" TEXT NOT NULL,
    "branch_id" TEXT,
    "start_at" DATETIME NOT NULL,
    "end_at" DATETIME NOT NULL,
    "service_type" TEXT NOT NULL,
    "priority" TEXT NOT NULL DEFAULT 'normal',
    "notes" TEXT,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "recurrence_rule" TEXT,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "bookings_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "bookings_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "psw_availability" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "psw_id" TEXT NOT NULL,
    "day_of_week" INTEGER NOT NULL,
    "start_time" TEXT NOT NULL,
    "end_time" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "psw_availability_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "psw_availability_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "shift_assignments" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "visit_id" TEXT NOT NULL,
    "psw_id" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'offered',
    "score" REAL,
    "assigned_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "shift_assignments_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "shift_assignments_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "shift_assignments_visit_id_fkey" FOREIGN KEY ("visit_id") REFERENCES "visits" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "blog_posts" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "excerpt" TEXT,
    "content_html" TEXT,
    "status" TEXT DEFAULT 'draft',
    "published_at" DATETIME,
    "author_user_id" TEXT,
    "feature_image_doc_id" TEXT,
    "seo_title" TEXT,
    "seo_description" TEXT,
    "canonical_url" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "target_role" TEXT,
    "category" TEXT DEFAULT 'announcement',
    CONSTRAINT "blog_posts_author_user_id_fkey" FOREIGN KEY ("author_user_id") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "staff_tasks" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "status" TEXT NOT NULL DEFAULT 'todo',
    "priority" TEXT NOT NULL DEFAULT 'medium',
    "due_date" DATETIME,
    "assignee_id" TEXT,
    "tenant_id" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "staff_tasks_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "psw_documents" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "psw_id" TEXT NOT NULL,
    "doc_type" TEXT NOT NULL,
    "file_key" TEXT NOT NULL,
    "status" TEXT DEFAULT 'pending',
    "expiry_date" DATETIME,
    "verified_by" TEXT,
    "verified_at" DATETIME,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "psw_documents_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "psw_documents_verified_by_fkey" FOREIGN KEY ("verified_by") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "faqs" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "question" TEXT NOT NULL,
    "answer" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "daily_entries" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tenant_id" TEXT NOT NULL,
    "client_id" TEXT NOT NULL,
    "staff_id" TEXT NOT NULL,
    "visit_id" TEXT,
    "adl_data" TEXT NOT NULL,
    "medication" TEXT,
    "mood" INTEGER,
    "vitals" TEXT,
    "notes" TEXT,
    "signature" TEXT,
    "status" TEXT NOT NULL DEFAULT 'DRAFT',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "daily_entries_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "daily_entries_staff_id_fkey" FOREIGN KEY ("staff_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "daily_entries_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "daily_entries_visit_id_fkey" FOREIGN KEY ("visit_id") REFERENCES "visits" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "user_devices" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "user_id" TEXT NOT NULL,
    "device_id" TEXT NOT NULL,
    "device_name" TEXT,
    "device_type" TEXT,
    "last_ip" TEXT,
    "status" TEXT NOT NULL DEFAULT 'active',
    "is_authorized" BOOLEAN NOT NULL DEFAULT false,
    "authorized_at" DATETIME,
    "is_temporary" BOOLEAN NOT NULL DEFAULT false,
    "expires_at" DATETIME,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "last_active_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "user_devices_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "marketplace_listings" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "total" DECIMAL NOT NULL,
    "category" TEXT NOT NULL,
    "provider_id" TEXT NOT NULL,
    "tenant_id" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "marketplace_listings_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "feedbacks" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_id" TEXT NOT NULL,
    "visit_id" TEXT,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,
    "status" TEXT DEFAULT 'pending',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "feedbacks_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "feedbacks_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "feedbacks_visit_id_fkey" FOREIGN KEY ("visit_id") REFERENCES "visits" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "care_plans" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "diagnoses" TEXT NOT NULL,
    "clinical_goals" TEXT,
    "interventions" TEXT,
    "status" TEXT NOT NULL DEFAULT 'active',
    "review_date" DATETIME,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "author_id" TEXT,
    "version" INTEGER NOT NULL DEFAULT 1,
    "is_archived" BOOLEAN NOT NULL DEFAULT false,
    "outcome_notes" TEXT,
    CONSTRAINT "care_plans_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "care_plans_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "care_plans_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "training_modules" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "category" TEXT,
    "video_url" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "training_modules_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "training_assignments" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "psw_id" TEXT,
    "staff_id" TEXT,
    "module_id" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'assigned',
    "completed_at" DATETIME,
    "assigned_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "training_assignments_module_id_fkey" FOREIGN KEY ("module_id") REFERENCES "training_modules" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "surveys" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "target_role" TEXT,
    "questions_json" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "surveys_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "survey_responses" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "survey_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "answers_json" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "survey_responses_survey_id_fkey" FOREIGN KEY ("survey_id") REFERENCES "surveys" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "regions" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "province" TEXT NOT NULL,
    "boundary_json" TEXT,
    "status" TEXT NOT NULL DEFAULT 'active',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "regions_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "branch_capacity" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "region_id" TEXT NOT NULL,
    "total_staff" INTEGER NOT NULL DEFAULT 0,
    "available_staff" INTEGER NOT NULL DEFAULT 0,
    "active_visits" INTEGER NOT NULL DEFAULT 0,
    "pending_bookings" INTEGER NOT NULL DEFAULT 0,
    "utilization_rate" REAL,
    "timestamp" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "branch_capacity_region_id_fkey" FOREIGN KEY ("region_id") REFERENCES "regions" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "clinical_records" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "data_json" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "clinical_records_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "health_ids" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "user_id" TEXT NOT NULL,
    "did" TEXT NOT NULL,
    "public_key" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'active',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "fhir_sync_logs" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "direction" TEXT NOT NULL,
    "resource_type" TEXT NOT NULL,
    "external_id" TEXT,
    "status" TEXT NOT NULL,
    "error" TEXT,
    "timestamp" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "fhir_sync_logs_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "ai_recommendations" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "type" TEXT NOT NULL,
    "priority" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "is_applied" BOOLEAN NOT NULL DEFAULT false,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "ai_recommendations_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "sentiment_analysis" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "source" TEXT NOT NULL,
    "source_id" TEXT NOT NULL,
    "score" REAL NOT NULL,
    "magnitude" REAL NOT NULL,
    "entities" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "sentiment_analysis_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "security_threats" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "type" TEXT NOT NULL,
    "severity" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'detected',
    "description" TEXT NOT NULL,
    "source" TEXT,
    "detected_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resolved_at" DATETIME,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "security_threats_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "tenant_slas" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "uptime_target" REAL NOT NULL DEFAULT 99.9,
    "response_time_target" INTEGER NOT NULL DEFAULT 500,
    "support_tier" TEXT NOT NULL DEFAULT 'STANDARD',
    "status" TEXT NOT NULL DEFAULT 'compliant',
    "last_audit_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "tenant_slas_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "system_policies" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "is_enforced" BOOLEAN NOT NULL DEFAULT true,
    "version" INTEGER NOT NULL DEFAULT 1,
    "updated_at" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "fleet_status" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "psw_id" TEXT NOT NULL,
    "lat" REAL,
    "lng" REAL,
    "status" TEXT NOT NULL DEFAULT 'available',
    "battery_level" INTEGER,
    "last_heartbeat_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "current_visit_id" TEXT,
    CONSTRAINT "fleet_status_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "response_bot_audits" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "type" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'success',
    "summary" TEXT NOT NULL,
    "details" TEXT NOT NULL,
    "duration_ms" INTEGER NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "visit_matches" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "visit_id" TEXT NOT NULL,
    "psw_id" TEXT NOT NULL,
    "score" REAL NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "visit_matches_visit_id_fkey" FOREIGN KEY ("visit_id") REFERENCES "visits" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "visit_matches_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "visit_matches_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "waitlist_entries" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_id" TEXT NOT NULL,
    "service_id" TEXT NOT NULL,
    "priority" INTEGER NOT NULL DEFAULT 0,
    "status" TEXT NOT NULL DEFAULT 'active',
    "notes" TEXT,
    "requested_start_at" DATETIME,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "waitlist_entries_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "waitlist_entries_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "services" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "waitlist_entries_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "branch_stats" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "utilization" REAL NOT NULL,
    "revenue" REAL NOT NULL,
    "churn_rate" REAL NOT NULL,
    "active_clients" INTEGER NOT NULL,
    "active_providers" INTEGER NOT NULL,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "branch_stats_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "compliance_records" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "type" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "score" REAL,
    "notes" TEXT,
    "last_sync_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "compliance_records_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "franchises" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "reseller_id" TEXT NOT NULL,
    "owner_user_id" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'active',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "franchises_reseller_id_fkey" FOREIGN KEY ("reseller_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "reseller_agreements" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "franchise_id" TEXT NOT NULL,
    "terms" TEXT NOT NULL,
    "fee_percentage" REAL NOT NULL,
    "start_date" DATETIME NOT NULL,
    "end_date" DATETIME,
    "status" TEXT NOT NULL DEFAULT 'active',
    CONSTRAINT "reseller_agreements_franchise_id_fkey" FOREIGN KEY ("franchise_id") REFERENCES "franchises" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "suppliers" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "contact_name" TEXT,
    "email" TEXT,
    "phone" TEXT,
    "category" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'active',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "inventory_items" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "sku" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 0,
    "reorder_point" INTEGER NOT NULL DEFAULT 10,
    "unit_price" REAL NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "clientProfileId" TEXT,
    CONSTRAINT "inventory_items_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "inventory_items_clientProfileId_fkey" FOREIGN KEY ("clientProfileId") REFERENCES "client_profiles" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "purchase_orders" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "po_number" TEXT NOT NULL,
    "supplier_id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "total_amount" REAL NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'draft',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "clientProfileId" TEXT,
    CONSTRAINT "purchase_orders_supplier_id_fkey" FOREIGN KEY ("supplier_id") REFERENCES "suppliers" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "purchase_orders_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "purchase_orders_clientProfileId_fkey" FOREIGN KEY ("clientProfileId") REFERENCES "client_profiles" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "telehealth_sessions" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tenant_id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "provider_id" TEXT NOT NULL,
    "start_time" DATETIME NOT NULL,
    "end_time" DATETIME,
    "meeting_link" TEXT,
    "status" TEXT NOT NULL DEFAULT 'scheduled',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "telehealth_sessions_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "telehealth_sessions_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "telehealth_sessions_provider_id_fkey" FOREIGN KEY ("provider_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "vital_signs" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "patient_id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "value" REAL NOT NULL,
    "unit" TEXT NOT NULL,
    "source" TEXT NOT NULL DEFAULT 'MANUAL',
    "recorded_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "vital_signs_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "patient_alerts" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tenant_id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "severity" TEXT NOT NULL DEFAULT 'MEDIUM',
    "message" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'open',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "patient_alerts_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "patient_alerts_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "insurance_providers" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tenant_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "network_id" TEXT,
    "contact_phone" TEXT,
    "claims_email" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "insurance_providers_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "claims" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tenant_id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "provider_id" TEXT NOT NULL,
    "service_date" DATETIME NOT NULL,
    "amount" REAL NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'draft',
    "denial_reason" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "claims_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "claims_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "claims_provider_id_fkey" FOREIGN KEY ("provider_id") REFERENCES "insurance_providers" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "billing_codes" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "code" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "default_rate" REAL NOT NULL
);

-- CreateTable
CREATE TABLE "medications" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "generic_name" TEXT,
    "dosage_form" TEXT,
    "strength" TEXT,
    "instructions" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "prescriptions" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tenant_id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "medication_id" TEXT NOT NULL,
    "prescriber_id" TEXT,
    "dosage" TEXT NOT NULL,
    "frequency" TEXT NOT NULL,
    "route" TEXT NOT NULL,
    "start_date" DATETIME NOT NULL,
    "end_date" DATETIME,
    "status" TEXT NOT NULL DEFAULT 'active',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "prescriptions_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "prescriptions_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "prescriptions_medication_id_fkey" FOREIGN KEY ("medication_id") REFERENCES "medications" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "mar_entries" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "patient_id" TEXT NOT NULL,
    "prescription_id" TEXT NOT NULL,
    "administer_id" TEXT,
    "admin_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" TEXT NOT NULL DEFAULT 'administered',
    "notes" TEXT,
    CONSTRAINT "mar_entries_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "mar_entries_prescription_id_fkey" FOREIGN KEY ("prescription_id") REFERENCES "prescriptions" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "shift_handovers" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "psw_id" TEXT NOT NULL,
    "visit_id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "handover_notes" TEXT NOT NULL,
    "safety_concerns" TEXT,
    "supplies_needed" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "shift_handovers_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "shift_handovers_visit_id_fkey" FOREIGN KEY ("visit_id") REFERENCES "visits" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "shift_handovers_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "psw_availability_overrides" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "psw_id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "start_time" TEXT NOT NULL,
    "end_time" TEXT NOT NULL,
    "is_available" BOOLEAN NOT NULL DEFAULT true,
    CONSTRAINT "psw_availability_overrides_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "psw_availability_overrides_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "payouts" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "psw_id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "amount" DECIMAL NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'CAD',
    "status" TEXT NOT NULL DEFAULT 'pending',
    "processed_at" DATETIME,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "payouts_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "payouts_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "clinical_assessments" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_id" TEXT NOT NULL,
    "rn_id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "assessment_data" TEXT NOT NULL,
    "score" INTEGER,
    "recommendations" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "clinical_assessments_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "clinical_assessments_rn_id_fkey" FOREIGN KEY ("rn_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "clinical_assessments_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "medication_reconciliations" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_id" TEXT NOT NULL,
    "rn_id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "recon_data" TEXT NOT NULL,
    "discrepancies" TEXT,
    "status" TEXT NOT NULL DEFAULT 'completed',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "medication_reconciliations_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "medication_reconciliations_rn_id_fkey" FOREIGN KEY ("rn_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "medication_reconciliations_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "supervision_logs" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "psw_id" TEXT NOT NULL,
    "rn_id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "competencies" TEXT NOT NULL,
    "is_satisfactory" BOOLEAN NOT NULL DEFAULT true,
    "feedback" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "supervision_logs_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "supervision_logs_rn_id_fkey" FOREIGN KEY ("rn_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "supervision_logs_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "family_notifications" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "is_read" BOOLEAN NOT NULL DEFAULT false,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "family_notifications_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "family_notifications_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "care_feedbacks" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_id" TEXT NOT NULL,
    "visit_id" TEXT NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,
    "triage_status" TEXT NOT NULL DEFAULT 'pending',
    "resolution_notes" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "care_feedbacks_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "care_feedbacks_visit_id_fkey" FOREIGN KEY ("visit_id") REFERENCES "visits" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "care_feedbacks_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "technical_audits" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "audit_type" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'success',
    "summary" TEXT NOT NULL,
    "issues_count" INTEGER NOT NULL DEFAULT 0,
    "details" TEXT,
    "performed_by_id" TEXT,
    "performed_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT,
    CONSTRAINT "technical_audits_performed_by_id_fkey" FOREIGN KEY ("performed_by_id") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "technical_audits_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "registry_entries" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "external_id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "label" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "module" TEXT NOT NULL,
    "action" TEXT,
    "target_path" TEXT,
    "description" TEXT,
    "status" TEXT NOT NULL DEFAULT 'active',
    "last_checked" DATETIME,
    "error_count" INTEGER NOT NULL DEFAULT 0,
    "metadata" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "booking_requests" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "service_type" TEXT NOT NULL,
    "preferred_date" DATETIME NOT NULL,
    "preferred_time" TEXT,
    "notes" TEXT,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "booking_requests_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "booking_requests_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "daily_audit_signoffs" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "rn_id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "visit_id" TEXT NOT NULL,
    "clinical_comment" TEXT,
    "status" TEXT NOT NULL DEFAULT 'verified',
    "signed_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "daily_audit_signoffs_rn_id_fkey" FOREIGN KEY ("rn_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "daily_audit_signoffs_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "daily_audit_signoffs_visit_id_fkey" FOREIGN KEY ("visit_id") REFERENCES "visits" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "wellness_pulses" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "user_id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "note" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "wellness_pulses_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "wellness_pulses_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "system_touchpoints" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "touchpoint_id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "module" TEXT NOT NULL,
    "label" TEXT,
    "path" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'OK',
    "error_detail" TEXT,
    "is_overridden" BOOLEAN NOT NULL DEFAULT false,
    "override_value" TEXT,
    "last_checked" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "system_touchpoints_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "financial_accounts" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'active',
    "tenant_id" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "financial_accounts_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "financial_transactions" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "type" TEXT NOT NULL,
    "reference_id" TEXT,
    "amount" DECIMAL NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'CAD',
    "status" TEXT NOT NULL DEFAULT 'draft',
    "tenant_id" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "financial_transactions_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "financial_journal_entries" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "transaction_id" TEXT NOT NULL,
    "account_id" TEXT NOT NULL,
    "debit" DECIMAL NOT NULL DEFAULT 0,
    "paid_out_amount" DECIMAL,
    "currency" TEXT NOT NULL DEFAULT 'CAD',
    "balance_before" DECIMAL NOT NULL DEFAULT 0,
    "balance_after" DECIMAL NOT NULL DEFAULT 0,
    "tenant_id" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "financial_journal_entries_transaction_id_fkey" FOREIGN KEY ("transaction_id") REFERENCES "financial_transactions" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "financial_journal_entries_account_id_fkey" FOREIGN KEY ("account_id") REFERENCES "financial_accounts" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "financial_journal_entries_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "financial_reconciliations" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "transaction_id" TEXT NOT NULL,
    "bank_transaction_id" TEXT,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "matched_at" DATETIME,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "financial_reconciliations_transaction_id_fkey" FOREIGN KEY ("transaction_id") REFERENCES "financial_transactions" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "financial_reconciliations_bank_transaction_id_fkey" FOREIGN KEY ("bank_transaction_id") REFERENCES "financial_bank_transactions" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "financial_reconciliations_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "financial_bank_transactions" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "bank_date" DATETIME NOT NULL,
    "description" TEXT NOT NULL,
    "amount" DECIMAL NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'CAD',
    "external_ref" TEXT,
    "status" TEXT NOT NULL DEFAULT 'unreconciled',
    "tenant_id" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "financial_bank_transactions_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "evv_records" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "visit_id" TEXT NOT NULL,
    "psw_id" TEXT NOT NULL,
    "check_type" TEXT NOT NULL,
    "lat" REAL,
    "lng" REAL,
    "accuracy" REAL,
    "verification_method" TEXT NOT NULL DEFAULT 'gps',
    "status" TEXT NOT NULL DEFAULT 'valid',
    "override_by_id" TEXT,
    "override_reason" TEXT,
    "raw_data" TEXT,
    "captured_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "evv_records_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "service_authorizations" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_id" TEXT NOT NULL,
    "service_id" TEXT,
    "funding_source" TEXT NOT NULL,
    "authorized_hours" REAL NOT NULL,
    "used_hours" REAL NOT NULL DEFAULT 0,
    "start_date" DATETIME NOT NULL,
    "end_date" DATETIME NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'active',
    "auth_code" TEXT,
    "notes" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "service_authorizations_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "service_authorizations_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "consent_forms" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_id" TEXT NOT NULL,
    "form_type" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "signature_data_url" TEXT,
    "signed_at" DATETIME,
    "expires_at" DATETIME,
    "document_key" TEXT,
    "witness_name" TEXT,
    "template_version" INTEGER NOT NULL DEFAULT 1,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "consent_forms_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "consent_forms_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "mileage_logs" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "psw_id" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "from_visit_id" TEXT,
    "to_visit_id" TEXT,
    "from_address" TEXT,
    "to_address" TEXT,
    "distance_km" REAL NOT NULL,
    "travel_minutes" INTEGER,
    "reimbursement_rate" REAL NOT NULL DEFAULT 0.70,
    "reimbursement_amount" REAL,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "mileage_logs_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "mileage_logs_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "referrals" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_name" TEXT NOT NULL,
    "client_phone" TEXT,
    "client_email" TEXT,
    "referrer_name" TEXT NOT NULL,
    "referrer_org" TEXT,
    "referrer_type" TEXT NOT NULL DEFAULT 'external',
    "service_needed" TEXT,
    "urgency" TEXT NOT NULL DEFAULT 'routine',
    "clinical_notes" TEXT,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "converted_client_id" TEXT,
    "converted_at" DATETIME,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "referrals_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "family_members" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "client_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT,
    "phone" TEXT,
    "relationship" TEXT NOT NULL,
    "access_level" TEXT NOT NULL DEFAULT 'view_only',
    "linked_user_id" TEXT,
    "is_emergency" BOOLEAN NOT NULL DEFAULT false,
    "notify_visits" BOOLEAN NOT NULL DEFAULT true,
    "notify_care" BOOLEAN NOT NULL DEFAULT true,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "family_members_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "family_members_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "performance_reviews" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "psw_id" TEXT NOT NULL,
    "reviewer_id" TEXT NOT NULL,
    "period_start" DATETIME NOT NULL,
    "period_end" DATETIME NOT NULL,
    "overall_rating" REAL,
    "kpis" TEXT,
    "goals" TEXT,
    "strengths" TEXT,
    "improvements" TEXT,
    "notes" TEXT,
    "status" TEXT NOT NULL DEFAULT 'draft',
    "acknowledged_at" DATETIME,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "performance_reviews_psw_id_fkey" FOREIGN KEY ("psw_id") REFERENCES "psw_profiles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "performance_reviews_reviewer_id_fkey" FOREIGN KEY ("reviewer_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "performance_reviews_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "webhook_endpoints" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "url" TEXT NOT NULL,
    "events" TEXT NOT NULL,
    "secret" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'active',
    "last_delivered_at" DATETIME,
    "failure_count" INTEGER NOT NULL DEFAULT 0,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "tenant_id" TEXT NOT NULL,
    CONSTRAINT "webhook_endpoints_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "webhook_deliveries" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "endpoint_id" TEXT NOT NULL,
    "event" TEXT NOT NULL,
    "payload" TEXT NOT NULL,
    "status_code" INTEGER,
    "response_body" TEXT,
    "retry_count" INTEGER NOT NULL DEFAULT 0,
    "delivered_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "webhook_deliveries_endpoint_id_fkey" FOREIGN KEY ("endpoint_id") REFERENCES "webhook_endpoints" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_osm_id_key" ON "users"("osm_id");

-- CreateIndex
CREATE INDEX "users_tenant_id_idx" ON "users"("tenant_id");

-- CreateIndex
CREATE UNIQUE INDEX "tenants_slug_key" ON "tenants"("slug");

-- CreateIndex
CREATE INDEX "registries_category_idx" ON "registries"("category");

-- CreateIndex
CREATE INDEX "registries_section_idx" ON "registries"("section");

-- CreateIndex
CREATE INDEX "registries_tenant_id_idx" ON "registries"("tenant_id");

-- CreateIndex
CREATE UNIQUE INDEX "registries_key_tenant_id_key" ON "registries"("key", "tenant_id");

-- CreateIndex
CREATE UNIQUE INDEX "api_keys_key_key" ON "api_keys"("key");

-- CreateIndex
CREATE INDEX "api_keys_tenant_id_idx" ON "api_keys"("tenant_id");

-- CreateIndex
CREATE UNIQUE INDEX "client_profiles_user_id_key" ON "client_profiles"("user_id");

-- CreateIndex
CREATE INDEX "client_profiles_tenant_id_idx" ON "client_profiles"("tenant_id");

-- CreateIndex
CREATE UNIQUE INDEX "psw_profiles_user_id_key" ON "psw_profiles"("user_id");

-- CreateIndex
CREATE INDEX "psw_profiles_tenant_id_idx" ON "psw_profiles"("tenant_id");

-- CreateIndex
CREATE INDEX "visits_tenant_id_idx" ON "visits"("tenant_id");

-- CreateIndex
CREATE UNIQUE INDEX "services_slug_key" ON "services"("slug");

-- CreateIndex
CREATE INDEX "services_tenant_id_idx" ON "services"("tenant_id");

-- CreateIndex
CREATE INDEX "incidents_tenant_id_idx" ON "incidents"("tenant_id");

-- CreateIndex
CREATE INDEX "timesheets_tenant_id_idx" ON "timesheets"("tenant_id");

-- CreateIndex
CREATE INDEX "invoices_tenant_id_idx" ON "invoices"("tenant_id");

-- CreateIndex
CREATE INDEX "messages_threads_tenant_id_idx" ON "messages_threads"("tenant_id");

-- CreateIndex
CREATE INDEX "audit_logs_tenant_id_idx" ON "audit_logs"("tenant_id");

-- CreateIndex
CREATE INDEX "audit_logs_device_id_idx" ON "audit_logs"("device_id");

-- CreateIndex
CREATE INDEX "system_events_tenant_id_idx" ON "system_events"("tenant_id");

-- CreateIndex
CREATE INDEX "system_events_model_name_entity_id_idx" ON "system_events"("model_name", "entity_id");

-- CreateIndex
CREATE INDEX "system_events_created_at_idx" ON "system_events"("created_at");

-- CreateIndex
CREATE INDEX "leads_tenant_id_idx" ON "leads"("tenant_id");

-- CreateIndex
CREATE UNIQUE INDEX "blog_posts_slug_key" ON "blog_posts"("slug");

-- CreateIndex
CREATE INDEX "daily_entries_tenant_id_idx" ON "daily_entries"("tenant_id");

-- CreateIndex
CREATE INDEX "user_devices_user_id_idx" ON "user_devices"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_devices_user_id_device_id_key" ON "user_devices"("user_id", "device_id");

-- CreateIndex
CREATE INDEX "marketplace_listings_tenant_id_idx" ON "marketplace_listings"("tenant_id");

-- CreateIndex
CREATE INDEX "feedbacks_tenant_id_idx" ON "feedbacks"("tenant_id");

-- CreateIndex
CREATE INDEX "care_plans_tenant_id_idx" ON "care_plans"("tenant_id");

-- CreateIndex
CREATE INDEX "training_modules_tenant_id_idx" ON "training_modules"("tenant_id");

-- CreateIndex
CREATE INDEX "surveys_tenant_id_idx" ON "surveys"("tenant_id");

-- CreateIndex
CREATE UNIQUE INDEX "regions_name_key" ON "regions"("name");

-- CreateIndex
CREATE INDEX "regions_tenant_id_idx" ON "regions"("tenant_id");

-- CreateIndex
CREATE INDEX "clinical_records_client_id_idx" ON "clinical_records"("client_id");

-- CreateIndex
CREATE INDEX "clinical_records_tenant_id_idx" ON "clinical_records"("tenant_id");

-- CreateIndex
CREATE UNIQUE INDEX "health_ids_user_id_key" ON "health_ids"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "health_ids_did_key" ON "health_ids"("did");

-- CreateIndex
CREATE INDEX "fhir_sync_logs_tenant_id_idx" ON "fhir_sync_logs"("tenant_id");

-- CreateIndex
CREATE INDEX "ai_recommendations_tenant_id_idx" ON "ai_recommendations"("tenant_id");

-- CreateIndex
CREATE INDEX "sentiment_analysis_tenant_id_idx" ON "sentiment_analysis"("tenant_id");

-- CreateIndex
CREATE INDEX "security_threats_tenant_id_idx" ON "security_threats"("tenant_id");

-- CreateIndex
CREATE UNIQUE INDEX "tenant_slas_tenant_id_key" ON "tenant_slas"("tenant_id");

-- CreateIndex
CREATE UNIQUE INDEX "system_policies_code_key" ON "system_policies"("code");

-- CreateIndex
CREATE UNIQUE INDEX "fleet_status_psw_id_key" ON "fleet_status"("psw_id");

-- CreateIndex
CREATE INDEX "visit_matches_tenant_id_idx" ON "visit_matches"("tenant_id");

-- CreateIndex
CREATE INDEX "waitlist_entries_tenant_id_idx" ON "waitlist_entries"("tenant_id");

-- CreateIndex
CREATE INDEX "branch_stats_tenant_id_idx" ON "branch_stats"("tenant_id");

-- CreateIndex
CREATE INDEX "compliance_records_tenant_id_idx" ON "compliance_records"("tenant_id");

-- CreateIndex
CREATE UNIQUE INDEX "inventory_items_sku_key" ON "inventory_items"("sku");

-- CreateIndex
CREATE UNIQUE INDEX "purchase_orders_po_number_key" ON "purchase_orders"("po_number");

-- CreateIndex
CREATE UNIQUE INDEX "billing_codes_code_key" ON "billing_codes"("code");

-- CreateIndex
CREATE UNIQUE INDEX "registry_entries_external_id_key" ON "registry_entries"("external_id");

-- CreateIndex
CREATE UNIQUE INDEX "daily_audit_signoffs_visit_id_key" ON "daily_audit_signoffs"("visit_id");

-- CreateIndex
CREATE UNIQUE INDEX "system_touchpoints_touchpoint_id_key" ON "system_touchpoints"("touchpoint_id");

-- CreateIndex
CREATE UNIQUE INDEX "financial_accounts_tenant_id_code_key" ON "financial_accounts"("tenant_id", "code");

-- CreateIndex
CREATE INDEX "financial_transactions_tenant_id_idx" ON "financial_transactions"("tenant_id");

-- CreateIndex
CREATE INDEX "financial_transactions_reference_id_idx" ON "financial_transactions"("reference_id");

-- CreateIndex
CREATE INDEX "financial_journal_entries_transaction_id_idx" ON "financial_journal_entries"("transaction_id");

-- CreateIndex
CREATE INDEX "financial_journal_entries_account_id_idx" ON "financial_journal_entries"("account_id");

-- CreateIndex
CREATE INDEX "evv_records_tenant_id_idx" ON "evv_records"("tenant_id");

-- CreateIndex
CREATE INDEX "evv_records_visit_id_idx" ON "evv_records"("visit_id");

-- CreateIndex
CREATE INDEX "evv_records_psw_id_idx" ON "evv_records"("psw_id");

-- CreateIndex
CREATE INDEX "service_authorizations_tenant_id_idx" ON "service_authorizations"("tenant_id");

-- CreateIndex
CREATE INDEX "service_authorizations_client_id_idx" ON "service_authorizations"("client_id");

-- CreateIndex
CREATE INDEX "consent_forms_tenant_id_idx" ON "consent_forms"("tenant_id");

-- CreateIndex
CREATE INDEX "consent_forms_client_id_idx" ON "consent_forms"("client_id");

-- CreateIndex
CREATE INDEX "mileage_logs_tenant_id_idx" ON "mileage_logs"("tenant_id");

-- CreateIndex
CREATE INDEX "mileage_logs_psw_id_idx" ON "mileage_logs"("psw_id");

-- CreateIndex
CREATE INDEX "referrals_tenant_id_idx" ON "referrals"("tenant_id");

-- CreateIndex
CREATE INDEX "referrals_status_idx" ON "referrals"("status");

-- CreateIndex
CREATE INDEX "family_members_tenant_id_idx" ON "family_members"("tenant_id");

-- CreateIndex
CREATE INDEX "family_members_client_id_idx" ON "family_members"("client_id");

-- CreateIndex
CREATE INDEX "performance_reviews_tenant_id_idx" ON "performance_reviews"("tenant_id");

-- CreateIndex
CREATE INDEX "performance_reviews_psw_id_idx" ON "performance_reviews"("psw_id");

-- CreateIndex
CREATE INDEX "webhook_endpoints_tenant_id_idx" ON "webhook_endpoints"("tenant_id");

-- CreateIndex
CREATE INDEX "webhook_deliveries_endpoint_id_idx" ON "webhook_deliveries"("endpoint_id");
