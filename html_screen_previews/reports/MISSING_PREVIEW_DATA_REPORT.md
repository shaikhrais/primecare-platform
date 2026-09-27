# Database Integrity Gaps Report

This report lists the exact data definitions missing in `governance.db` that prevented rendering realistic interactive screens.

## Gaps Breakdown

### 1. Missing Sidebar Definitions
These roles do not have `sidebar_items` records and loaded a fallback:
*None*

### 2. Missing Topbar Definitions
Screens loading fallback topbars because `topbar_items` were missing:
0 screen instances.

### 3. Missing Screen Layout Sections
These screens have zero `screen_sections` records and render empty viewports:
*None*

### 4. Missing Screen Layout Section Elements
These screens have sections but zero `screen_section_elements` inside:
*None*

### 5. Missing API Endpoint Mappings
These screens have zero `screen_api_map` records (potential missing API connection):
*None*
