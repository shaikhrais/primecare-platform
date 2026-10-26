-- Extend only the known communication kind constraint; preserve all other checks/data.
DO $migration$
DECLARE old_expr text; new_expr text; candidate text; matches integer;
BEGIN
 PERFORM pg_advisory_xact_lock(hashtextextended('primecare-external-call-storage-v1',0));
 CREATE TEMP TABLE external_call_kind_old(state jsonb CHECK(jsonb_typeof(state->'kind')='string' AND state->>'kind' IN ('workflow','conversation','outbound_mail','inbound_mail'))) ON COMMIT DROP;
 CREATE TEMP TABLE external_call_kind_new(state jsonb CHECK(jsonb_typeof(state->'kind')='string' AND state->>'kind' IN ('workflow','conversation','outbound_mail','inbound_mail','external_call'))) ON COMMIT DROP;
 SELECT pg_get_expr(conbin,conrelid) INTO STRICT old_expr FROM pg_constraint WHERE conrelid='pg_temp.external_call_kind_old'::regclass;
 SELECT pg_get_expr(conbin,conrelid) INTO STRICT new_expr FROM pg_constraint WHERE conrelid='pg_temp.external_call_kind_new'::regclass;
 SELECT count(*),min(conname) INTO matches,candidate FROM pg_constraint WHERE conrelid='public.business_work_aggregates'::regclass AND contype='c' AND pg_get_expr(conbin,conrelid) IN(old_expr,new_expr);
 IF matches<>1 THEN RAISE EXCEPTION 'Unrecognized communication kind constraint; preserved'; END IF;
 IF EXISTS(SELECT 1 FROM pg_constraint WHERE conrelid='public.business_work_aggregates'::regclass AND conname=candidate AND pg_get_expr(conbin,conrelid)=old_expr) THEN
  EXECUTE format('ALTER TABLE public.business_work_aggregates DROP CONSTRAINT %I, ADD CONSTRAINT %I CHECK (%s)',candidate,candidate,new_expr);
 END IF;
 IF NOT EXISTS(SELECT 1 FROM pg_constraint WHERE conrelid='public.business_work_aggregates'::regclass AND conname=candidate AND convalidated AND pg_get_expr(conbin,conrelid)=new_expr) THEN RAISE EXCEPTION 'Call storage validation failed'; END IF;
 DROP TABLE pg_temp.external_call_kind_old,pg_temp.external_call_kind_new;
END $migration$;
