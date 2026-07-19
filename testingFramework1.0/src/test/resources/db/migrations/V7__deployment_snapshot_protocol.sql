-- Schema Migration: V7__deployment_snapshot_protocol
-- Created: 2026-07-16

CREATE TABLE IF NOT EXISTS deployment_snapshots (
    snapshot_id TEXT PRIMARY KEY,
    deployment_id TEXT NOT NULL,
    commit_id TEXT,
    application_version TEXT,
    deployment_url TEXT NOT NULL,
    route_hash TEXT,
    role_hash TEXT,
    screen_hash TEXT,
    sidebar_hash TEXT,
    localization_hash TEXT,
    api_hash TEXT,
    component_hash TEXT,
    status TEXT NOT NULL,
    created_at TEXT NOT NULL,
    completed_at TEXT
);

CREATE TABLE IF NOT EXISTS deployment_role_screens (
    deployment_id TEXT NOT NULL,
    snapshot_id TEXT NOT NULL,
    role_id TEXT NOT NULL,
    screen_id TEXT NOT NULL,
    route_id TEXT,
    sidebar_visible INTEGER DEFAULT 0,
    direct_access_allowed INTEGER DEFAULT 0,
    can_view INTEGER DEFAULT 0,
    can_create INTEGER DEFAULT 0,
    can_edit INTEGER DEFAULT 0,
    can_delete INTEGER DEFAULT 0,
    can_approve INTEGER DEFAULT 0,
    expected_access_result TEXT,
    source_type TEXT,
    PRIMARY KEY (
        deployment_id,
        role_id,
        screen_id
    )
);

CREATE TABLE IF NOT EXISTS role_test_plans (
    plan_id TEXT PRIMARY KEY,
    deployment_id TEXT NOT NULL,
    snapshot_id TEXT NOT NULL,
    role_id TEXT NOT NULL,
    expected_landing_screen_id TEXT,
    expected_landing_route TEXT,
    allowed_screen_count INTEGER,
    denied_screen_count INTEGER,
    sidebar_screen_count INTEGER,
    direct_route_count INTEGER,
    plan_status TEXT,
    generated_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS deployment_routes (
    deployment_id TEXT NOT NULL,
    snapshot_id TEXT NOT NULL,
    route_id TEXT NOT NULL,
    route_path TEXT NOT NULL,
    route_pattern TEXT,
    screen_id TEXT,
    route_type TEXT,
    requires_authentication INTEGER DEFAULT 0,
    expected_title TEXT,
    expected_heading TEXT,
    expected_screen_identifier TEXT,
    expected_redirect_route TEXT,
    parent_route_id TEXT,
    fallback_route_id TEXT,
    active INTEGER DEFAULT 1,
    PRIMARY KEY (
        deployment_id,
        route_id
    )
);

CREATE TABLE IF NOT EXISTS route_chains (
    route_chain_id TEXT PRIMARY KEY,
    deployment_id TEXT NOT NULL,
    role_id TEXT,
    chain_name TEXT NOT NULL,
    starting_state TEXT,
    target_type TEXT,
    chain_json TEXT NOT NULL,
    chain_hash TEXT,
    active INTEGER DEFAULT 1,
    created_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS deployment_screen_identity (
    deployment_id TEXT NOT NULL,
    snapshot_id TEXT NOT NULL,
    screen_id TEXT NOT NULL,
    screen_name TEXT,
    expected_title TEXT,
    expected_route TEXT,
    expected_route_pattern TEXT,
    expected_heading TEXT,
    expected_root_identifier TEXT,
    secondary_identifiers_json TEXT,
    screen_category TEXT,
    requires_authentication INTEGER DEFAULT 0,
    screen_version_hash TEXT,
    PRIMARY KEY (
        deployment_id,
        screen_id
    )
);

CREATE TABLE IF NOT EXISTS deployment_screen_components (
    deployment_id TEXT NOT NULL,
    snapshot_id TEXT NOT NULL,
    screen_id TEXT NOT NULL,
    component_id TEXT NOT NULL,
    component_type TEXT,
    locator_strategy TEXT DEFAULT 'data-cy',
    locator_value TEXT NOT NULL,
    semantics_identifier TEXT,
    expected_text TEXT,
    required INTEGER DEFAULT 1,
    expected_visible INTEGER DEFAULT 1,
    expected_enabled INTEGER,
    applicable_roles_json TEXT,
    interaction_type TEXT,
    component_version_hash TEXT,
    PRIMARY KEY (
        deployment_id,
        screen_id,
        component_id
    )
);

CREATE TABLE IF NOT EXISTS deployment_sidebar_items (
    deployment_id TEXT NOT NULL,
    snapshot_id TEXT NOT NULL,
    role_id TEXT NOT NULL,
    sidebar_item_id TEXT NOT NULL,
    parent_item_id TEXT,
    screen_id TEXT,
    route_id TEXT,
    label_key TEXT,
    display_order INTEGER,
    expected_visible INTEGER DEFAULT 1,
    permission_key TEXT,
    PRIMARY KEY (
        deployment_id,
        role_id,
        sidebar_item_id
    )
);

CREATE TABLE IF NOT EXISTS deployment_error_definitions (
    deployment_id TEXT NOT NULL,
    error_type TEXT NOT NULL,
    http_status INTEGER,
    expected_title TEXT,
    expected_route_pattern TEXT,
    expected_screen_identifier TEXT,
    expected_text TEXT,
    retry_allowed INTEGER DEFAULT 0,
    screenshot_classification TEXT,
    PRIMARY KEY (
        deployment_id,
        error_type
    )
);

CREATE TABLE IF NOT EXISTS deployment_dependencies (
    dependency_id TEXT PRIMARY KEY,
    deployment_id TEXT NOT NULL,
    source_entity_type TEXT NOT NULL,
    source_entity_id TEXT NOT NULL,
    target_entity_type TEXT NOT NULL,
    target_entity_id TEXT NOT NULL,
    dependency_type TEXT NOT NULL,
    critical INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS deployment_change_impact (
    change_impact_id TEXT PRIMARY KEY,
    previous_deployment_id TEXT,
    current_deployment_id TEXT NOT NULL,
    entity_type TEXT NOT NULL,
    entity_id TEXT NOT NULL,
    change_type TEXT NOT NULL,
    previous_hash TEXT,
    current_hash TEXT,
    regression_scope TEXT,
    created_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS testing_work_queue (
    work_item_id TEXT PRIMARY KEY,
    deployment_id TEXT NOT NULL,
    role_id TEXT,
    screen_id TEXT,
    route_id TEXT,
    test_id TEXT,
    issue_id TEXT,
    work_type TEXT NOT NULL,
    priority INTEGER DEFAULT 50,
    status TEXT NOT NULL,
    dependency_json TEXT,
    attempts INTEGER DEFAULT 0,
    created_at TEXT NOT NULL,
    started_at TEXT,
    completed_at TEXT
);
