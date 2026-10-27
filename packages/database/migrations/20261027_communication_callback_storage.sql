-- Generated additive callback storage baseline. Do not edit.
-- Candidate callback persistence for the registered reception.callback.request task.
-- Production application requires an independently reviewed storage registration.
-- Does not create grants, users, provider tools or confirmed human appointments.
CREATE TABLE IF NOT EXISTS public.communication_callback_requests (
 intent_id text PRIMARY KEY REFERENCES public.communication_voice_tasks(id),
 tenant_id text NOT NULL,
 user_id text NOT NULL,
 contact_version bigint NOT NULL CHECK(contact_version BETWEEN 1 AND 9007199254740990),
 reason text NOT NULL CHECK(reason IN ('appointment_help','general')),
 window_starts_at timestamptz NOT NULL,
 window_ends_at timestamptz NOT NULL,
 status text NOT NULL DEFAULT 'requested' CHECK(status='requested'),
 created_at timestamptz NOT NULL DEFAULT clock_timestamp(),
 CHECK(window_starts_at<window_ends_at),
 CHECK(length(btrim(tenant_id)) BETWEEN 1 AND 200),
 CHECK(length(btrim(user_id)) BETWEEN 1 AND 200)
);
CREATE INDEX IF NOT EXISTS communication_callback_requests_pending
 ON public.communication_callback_requests(tenant_id,window_starts_at,intent_id);
