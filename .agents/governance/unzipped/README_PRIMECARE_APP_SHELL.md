# PrimeCare App Shell Template System

This template system separates the shared app shell from screen content.

Core rule:

Screens should NOT implement sidebar or topbar.

Structure:

PrimeCareAppShell
  PrimeCareSidebar
  PrimeCareTopbar
  PrimeCareContentContainer
    ScreenContent
      Sections
        Elements

Files:
- primecare_app_shell.html
- primecare_sidebar.html
- primecare_topbar.html
- primecare_content_container.html
- primecare_theme.css
- primecare_default_theme.json
- primecare_db_mapping.md

Theme flow:

theme_profiles -> theme_design_tokens -> layout_theme_token_map -> component_theme_token_map -> generated CSS variables / Flutter theme tokens

DB-to-template flow:

app_shells -> sidebar_masters/sidebar_groups/sidebar_items -> topbar_masters/topbar_items -> screen_shell_integration -> screen_sections -> screen_section_elements

Implementation guidance:
1. Save these as canonical shell templates in packages/primecare_ui/lib or your template folder.
2. Do not duplicate sidebar/topbar inside screen files.
3. Generate screen files only for content sections.
4. Use stable data-testid names from DB.
5. Use theme tokens from DB, not hardcoded colors.
