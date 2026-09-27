-- Schema Migration: V6__issues_protocol
-- Created: 2026-07-16

CREATE TABLE IF NOT EXISTS issues (
    issue_id TEXT PRIMARY KEY,
    project_id TEXT,
    title TEXT NOT NULL,
    description TEXT,
    category TEXT NOT NULL,
    severity TEXT NOT NULL,
    priority INTEGER,
    status TEXT NOT NULL,
    environment TEXT,
    deployment_id TEXT,
    screen_id TEXT,
    route TEXT,
    component_id TEXT,
    test_id TEXT,
    first_test_run_id TEXT,
    latest_test_run_id TEXT,
    suspected_root_cause TEXT,
    confirmed_root_cause TEXT,
    affected_module TEXT,
    reproduction_steps TEXT,
    expected_result TEXT,
    actual_result TEXT,
    failure_message TEXT,
    failure_signature TEXT,
    failure_hash TEXT,
    assigned_agent TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    resolved_at TEXT,
    closed_at TEXT
);

CREATE TABLE IF NOT EXISTS issue_occurrences (
    occurrence_id TEXT PRIMARY KEY,
    issue_id TEXT NOT NULL,
    test_run_id TEXT,
    deployment_id TEXT,
    screen_id TEXT,
    route TEXT,
    current_url TEXT,
    page_title TEXT,
    screen_identifier TEXT,
    http_status INTEGER,
    screenshot_id TEXT,
    console_error_count INTEGER,
    network_error_count INTEGER,
    occurred_at TEXT NOT NULL,
    FOREIGN KEY (issue_id) REFERENCES issues(issue_id)
);

CREATE TABLE IF NOT EXISTS issue_status_history (
    history_id TEXT PRIMARY KEY,
    issue_id TEXT NOT NULL,
    previous_status TEXT,
    new_status TEXT NOT NULL,
    reason TEXT,
    changed_by TEXT,
    deployment_id TEXT,
    test_run_id TEXT,
    changed_at TEXT NOT NULL,
    FOREIGN KEY (issue_id) REFERENCES issues(issue_id)
);

CREATE TABLE IF NOT EXISTS fix_attempts (
    fix_attempt_id TEXT PRIMARY KEY,
    issue_id TEXT NOT NULL,
    attempt_number INTEGER NOT NULL,
    description TEXT,
    suspected_fix TEXT,
    files_changed TEXT,
    code_change_summary TEXT,
    commit_id TEXT,
    build_id TEXT,
    deployment_id TEXT,
    retest_run_id TEXT,
    result TEXT,
    failure_reason TEXT,
    started_at TEXT NOT NULL,
    completed_at TEXT,
    FOREIGN KEY (issue_id) REFERENCES issues(issue_id)
);

CREATE TABLE IF NOT EXISTS code_changes (
    change_id TEXT PRIMARY KEY,
    fix_attempt_id TEXT,
    issue_id TEXT,
    file_path TEXT NOT NULL,
    change_type TEXT,
    before_summary TEXT,
    after_summary TEXT,
    reason TEXT,
    commit_id TEXT,
    created_at TEXT NOT NULL,
    FOREIGN KEY (fix_attempt_id) REFERENCES fix_attempts(fix_attempt_id),
    FOREIGN KEY (issue_id) REFERENCES issues(issue_id)
);

CREATE TABLE IF NOT EXISTS issue_links (
    link_id TEXT PRIMARY KEY,
    issue_id TEXT NOT NULL,
    linked_entity_type TEXT NOT NULL,
    linked_entity_id TEXT NOT NULL,
    relationship_type TEXT NOT NULL,
    created_at TEXT NOT NULL,
    FOREIGN KEY (issue_id) REFERENCES issues(issue_id)
);

CREATE TABLE IF NOT EXISTS activity_log (
    activity_id TEXT PRIMARY KEY,
    run_id TEXT,
    issue_id TEXT,
    fix_attempt_id TEXT,
    deployment_id TEXT,
    activity_type TEXT NOT NULL,
    description TEXT,
    metadata_json TEXT,
    created_by TEXT,
    created_at TEXT NOT NULL
);
