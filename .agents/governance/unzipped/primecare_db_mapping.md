# PrimeCare App Shell DB Mapping

## Sidebar

Tables:
- app_shells
- sidebar_masters
- sidebar_groups
- sidebar_items
- sidebar_route_map
- role_screen_map

Template:
`primecare_sidebar.html`

Every sidebar item must come from `sidebar_items`.

## Topbar

Tables:
- topbar_masters
- topbar_items
- topbar_action_map
- global_features
- role_shell_permissions

Template:
`primecare_topbar.html`

Default topbar features:
- global_search
- notification_center
- chat
- help
- profile_avatar
- logout
- language_switcher
- theme_toggle

## Content container

Tables:
- screens
- screen_shell_integration
- screen_sections
- screen_section_elements
- section_region_placement

Template:
`primecare_content_container.html`

Important:
Content container receives screen sections only. It does not create sidebar/topbar.

## Theme

Tables:
- theme_profiles
- theme_design_tokens
- component_theme_token_map
- layout_theme_token_map
- screen_theme_overrides

CSS variables should be generated from these tokens.

## PrimeCare UI package

Tables:
- primecare_ui_component_registry
- element_primecare_component_map
- primecare_ui_tag_registry
- component_selection_rules

Flow:
screen_section_elements.element_type -> component_selection_rules -> primecare_ui_component_registry -> generated component usage.

## Validation

Before code generation:
- every authenticated screen has app_shell
- every role with screens has sidebar_items
- every topbar has profile/logout
- every screen has screen_shell_integration
- every section has section_region_placement
- every element has component mapping
- every theme has required design tokens
