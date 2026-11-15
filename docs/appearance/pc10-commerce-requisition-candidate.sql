-- PROPOSAL ONLY. Not a registered model, production migration, or authorization.
-- Quoted-draft choice B in pc10-commerce-requisition-review.md. No old rows are modified.
-- Never run against production; future migration must replace this fixture gate
-- only after reviewed live schema/ownership/contract registration and approval.
BEGIN;
DO $$ BEGIN
 IF current_setting('primecare.commerce_requisition_fixture', true) IS DISTINCT FROM '1' THEN
  RAISE EXCEPTION 'Unapproved Commerce draft design: isolated fixture opt-in required';
 END IF;
END $$;

CREATE TABLE commerce_tenant_suppliers (
 tenant_id TEXT NOT NULL REFERENCES tenants(id),
 supplier_id TEXT NOT NULL REFERENCES suppliers(id),
 status TEXT NOT NULL CHECK (status IN ('active','withdrawn')),
 revision BIGINT NOT NULL CHECK (revision BETWEEN 1 AND 9007199254740991),
 PRIMARY KEY (tenant_id,supplier_id)
);
CREATE TABLE commerce_catalogue_quotes (
 tenant_id TEXT NOT NULL,
 supplier_id TEXT NOT NULL,
 item_id TEXT NOT NULL REFERENCES inventory_items(id),
 revision BIGINT NOT NULL CHECK (revision BETWEEN 1 AND 9007199254740991),
 publication_state TEXT NOT NULL CHECK (publication_state IN ('draft','published','withdrawn')),
 currency TEXT NOT NULL CHECK (currency ~ '^[A-Z]{3}$'),
 unit_price NUMERIC(20,4) NOT NULL CHECK (unit_price >= 0),
 -- Timestamp/publication/editor authority and versioned quote history remain
 -- explicit review decisions; this design does not auto-publish a quote.
 PRIMARY KEY (tenant_id,supplier_id,item_id),
 FOREIGN KEY (tenant_id,supplier_id) REFERENCES commerce_tenant_suppliers(tenant_id,supplier_id)
 -- Existing inventory_items lacks UNIQUE(tenant_id,id); add a reviewed
 -- composite identity/FK or validate item ownership transactionally before use.
);
CREATE TABLE commerce_draft_requisitions (
 id TEXT PRIMARY KEY,
 tenant_id TEXT NOT NULL REFERENCES tenants(id),
 actor_user_id TEXT NOT NULL REFERENCES users(id),
 supplier_id TEXT NOT NULL,
 idempotency_key UUID NOT NULL,
 payload_version SMALLINT NOT NULL CHECK (payload_version=1),
 payload_sha256 TEXT NOT NULL CHECK (payload_sha256 ~ '^[0-9a-f]{64}$'),
 revision BIGINT NOT NULL CHECK (revision=1),
 status TEXT NOT NULL CHECK (status='draft'),
 currency TEXT NOT NULL CHECK (currency ~ '^[A-Z]{3}$'),
 estimate_amount NUMERIC(20,4) NOT NULL CHECK (estimate_amount>=0),
 created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
 -- No client-controlled supplier address, card data or financial/provider IDs.
 UNIQUE (tenant_id,actor_user_id,idempotency_key),
 UNIQUE (tenant_id,id,currency),
 FOREIGN KEY (tenant_id,supplier_id) REFERENCES commerce_tenant_suppliers(tenant_id,supplier_id)
);
CREATE TABLE commerce_draft_requisition_lines (
 tenant_id TEXT NOT NULL,
 requisition_id TEXT NOT NULL,
 item_id TEXT NOT NULL REFERENCES inventory_items(id),
 quantity INTEGER NOT NULL CHECK (quantity BETWEEN 1 AND 10000),
 quote_revision BIGINT NOT NULL CHECK (quote_revision BETWEEN 1 AND 9007199254740991),
 currency TEXT NOT NULL CHECK (currency ~ '^[A-Z]{3}$'),
 unit_price NUMERIC(20,4) NOT NULL CHECK (unit_price>=0),
 line_estimate NUMERIC(20,4) NOT NULL CHECK (line_estimate>=0 AND line_estimate=quantity*unit_price),
 PRIMARY KEY (tenant_id,requisition_id,item_id),
 FOREIGN KEY (tenant_id,requisition_id,currency) REFERENCES commerce_draft_requisitions(tenant_id,id,currency)
);
-- Required beyond this draft DDL: actor/tenant ownership checks; locked published
-- quote/membership validation; canonical payload receipt state machine; one to
--100 unique lines; aggregate estimate equality; immutability/update protection;
-- explicit monetary overflow rejection before NUMERIC coercion; actual approved
-- currency set; quota/audit and source editor permissions; verified retention.
-- PostgreSQL NUMERIC input can round >4 fractional places on insertion: future
-- ingestion must reject excess precision before casting, never rely on DDL alone.
ROLLBACK;
