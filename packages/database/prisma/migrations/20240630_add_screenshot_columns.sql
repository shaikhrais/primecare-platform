/* Migration to add screenshot related columns to screens table */
ALTER TABLE screens ADD COLUMN screenshot_status TEXT DEFAULT 'NOT_CHECKED';
ALTER TABLE screens ADD COLUMN screenshot_file_path TEXT;
ALTER TABLE screens ADD COLUMN screenshot_generated_at TEXT;
ALTER TABLE screens ADD COLUMN screenshot_file_size INTEGER DEFAULT 0;
ALTER TABLE screens ADD COLUMN visual_quality_score REAL DEFAULT 0.0;
