-- Schema Migration: V3__plan_tables
-- Created: 2026-07-14

-- 1. Test Execution Plans Table
CREATE TABLE IF NOT EXISTS test_execution_plans (
    plan_id INTEGER PRIMARY KEY AUTOINCREMENT,
    plan_uuid TEXT NOT NULL UNIQUE,
    execution_id INTEGER,
    application_id INTEGER,
    requested_screen_key TEXT,
    requested_screen_id INTEGER,
    requested_module TEXT,
    requested_level INTEGER,
    requested_from_level INTEGER,
    requested_to_level INTEGER,
    requested_layers TEXT,
    execution_mode TEXT NOT NULL,
    include_dependencies INTEGER NOT NULL DEFAULT 1,
    stop_on_failure INTEGER NOT NULL DEFAULT 1,
    continue_on_failure INTEGER NOT NULL DEFAULT 0,
    role_key TEXT,
    environment TEXT,
    created_at TEXT NOT NULL,
    started_at TEXT,
    completed_at TEXT,
    status TEXT NOT NULL DEFAULT 'PLANNED',
    FOREIGN KEY(execution_id) REFERENCES test_executions(execution_id)
);

-- 2. Test Execution Plan Items Table
CREATE TABLE IF NOT EXISTS test_execution_plan_items (
    plan_item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    plan_id INTEGER NOT NULL,
    plan_item_uuid TEXT NOT NULL UNIQUE,
    screen_id INTEGER NOT NULL,
    layer_id INTEGER NOT NULL,
    execution_order INTEGER NOT NULL,
    required INTEGER NOT NULL DEFAULT 1,
    applicable INTEGER NOT NULL DEFAULT 1,
    dependency_layers TEXT,
    skip_reason TEXT,
    status TEXT NOT NULL DEFAULT 'PLANNED',
    result_id INTEGER,
    created_at TEXT NOT NULL,
    started_at TEXT,
    completed_at TEXT,
    FOREIGN KEY(plan_id) REFERENCES test_execution_plans(plan_id),
    FOREIGN KEY(screen_id) REFERENCES screens(screen_id),
    FOREIGN KEY(layer_id) REFERENCES testing_layers(layer_id),
    FOREIGN KEY(result_id) REFERENCES test_results(result_id)
);

-- 3. Screen Test Cases Table (Round 2 addition)
CREATE TABLE IF NOT EXISTS screen_test_cases (
    screen_test_case_id INTEGER PRIMARY KEY AUTOINCREMENT,
    screen_id INTEGER NOT NULL,
    layer_id INTEGER NOT NULL,
    test_case_key TEXT NOT NULL,
    test_case_name TEXT NOT NULL,
    test_class TEXT,
    test_method TEXT,
    source_type TEXT NOT NULL,
    execution_order INTEGER NOT NULL DEFAULT 100,
    required INTEGER NOT NULL DEFAULT 1,
    active INTEGER NOT NULL DEFAULT 1,
    dependency_test_case_keys TEXT,
    tags TEXT,
    description TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    UNIQUE(screen_id, test_case_key),
    FOREIGN KEY(screen_id) REFERENCES screens(screen_id),
    FOREIGN KEY(layer_id) REFERENCES testing_layers(layer_id)
);

-- 4. Indexes
CREATE INDEX IF NOT EXISTS idx_test_plan_items_plan
ON test_execution_plan_items(plan_id);

CREATE INDEX IF NOT EXISTS idx_test_plan_items_screen_layer
ON test_execution_plan_items(screen_id, layer_id);

CREATE INDEX IF NOT EXISTS idx_test_plan_items_status
ON test_execution_plan_items(status);

CREATE INDEX IF NOT EXISTS idx_screen_test_cases_screen_layer
ON screen_test_cases(screen_id, layer_id);

-- 5. Screen Test Coverage View
CREATE VIEW IF NOT EXISTS screen_test_coverage AS
SELECT
    s.screen_id,
    s.screen_key,
    s.screen_name,
    tl.layer_code,
    COUNT(stc.screen_test_case_id) AS registered_test_count,
    SUM(
        CASE WHEN stc.required = 1
        THEN 1 ELSE 0 END
    ) AS required_test_count
FROM screens s
CROSS JOIN testing_layers tl
LEFT JOIN screen_test_cases stc
    ON stc.screen_id = s.screen_id
   AND stc.layer_id = tl.layer_id
   AND stc.active = 1
WHERE s.active = 1
GROUP BY
    s.screen_id,
    s.screen_key,
    s.screen_name,
    tl.layer_code;
