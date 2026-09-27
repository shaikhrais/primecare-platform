# Screen Section Sample Report

This report displays 5 sample screens mapped to section-based architecture.

## Dashboard Screen Example: RmtDashboardScreen (`rmt_dashboard`)
| Section Code | Section Name | Section Type | Elements (Test ID, Type, Action Required, API Usage) |
| --- | --- | --- | --- |
| `rmt_dashboard_header` | Header Section | header | `screen_root` (ID: `rmt_dashboard-screen`, Type: layout, Action: 0)<br>`page_title` (ID: `rmt_dashboard-title`, Type: header, Action: 0) |
| `rmt_dashboard_summary_cards` | Summary Cards Section | metrics | `primary_content` (ID: `rmt_dashboard-content`, Type: layout, Action: 0)<br>`rmtdashboard_screen` (ID: `rmtdashboard-screen`, Type: layout, Action: 0)<br>`rmtdashboard_loading` (ID: `rmtdashboard-loading`, Type: loading, Action: 0)<br>`rmtdashboard_title` (ID: `rmtdashboard-title`, Type: header, Action: 0) |
| `rmt_dashboard_chart_overview` | Chart Overview Section | chart | *No elements* |
| `rmt_dashboard_recent_activity` | Recent Activity Section | list | *No elements* |
| `rmt_dashboard_quick_actions` | Quick Actions Section | action_bar | `rmtdashboard_btn_3` (ID: `rmtdashboard-btn-3`, Type: button, Action: 1, API: api_v1_rmt_update_patch)<br>`rmtdashboard_btn_3_${apt.id}` (ID: `rmtdashboard-btn-3-${apt.id}`, Type: button, Action: 1, API: api_v1_rmt_update_patch)<br>`rmtdashboard_btn_4_${apt.id}` (ID: `rmtdashboard-btn-4-${apt.id}`, Type: button, Action: 1, API: api_v1_rmt_update_patch)<br>`rmtdashboard_btn_2` (ID: `rmtdashboard-btn-2`, Type: button, Action: 1, API: api_v1_rmt_update_patch)<br>`rmtdashboard_btn_1` (ID: `rmtdashboard-btn-1`, Type: button, Action: 1, API: api_v1_rmt_update_patch) |

## Form Screen Example: Registry Entry Editor (`registry_entry_editor`)
| Section Code | Section Name | Section Type | Elements (Test ID, Type, Action Required, API Usage) |
| --- | --- | --- | --- |
| `registry_entry_editor_header` | Header Section | header | `screen_root` (ID: `registry_entry_editor-screen`, Type: layout, Action: 0)<br>`page_title` (ID: `registry_entry_editor-title`, Type: header, Action: 0)<br>`registry_entry_editor-screen-title` (ID: `registry_entry_editor-screen-title`, Type: text, Action: 0, API: api_v1_registry_entry_editor_update_patch) |
| `registry_entry_editor_form_body` | Form Body Section | form | `primary_content` (ID: `registry_entry_editor-content`, Type: layout, Action: 0)<br>`registry_entry_editor_textfield_input_1` (ID: `registry_entry_editor_textfield_input_1`, Type: field, Action: 0, API: api_v1_registry_entry_editor_update_patch) |
| `registry_entry_editor_validation_messages` | Validation Messages Section | errors | *No elements* |
| `registry_entry_editor_action_bar` | Action Bar Section | action_bar | *No elements* |

## List Screen Example: CoordinatorWaitlistScreen (`coordinator_waitlist`)
| Section Code | Section Name | Section Type | Elements (Test ID, Type, Action Required, API Usage) |
| --- | --- | --- | --- |
| `coordinator_waitlist_header` | Header Section | header | `screen_root` (ID: `coordinator_waitlist-screen`, Type: layout, Action: 0)<br>`page_title` (ID: `coordinator_waitlist-title`, Type: header, Action: 0) |
| `coordinator_waitlist_filter_bar` | Filter Bar Section | filters | *No elements* |
| `coordinator_waitlist_data_table` | Data Table Section | table | `primary_content` (ID: `coordinator_waitlist-content`, Type: layout, Action: 0)<br>`coordinatorwaitlist_screen` (ID: `coordinatorwaitlist-screen`, Type: layout, Action: 0, API: api_v1_coordinator_waitlist_list_get)<br>`coordinatorwaitlist_title` (ID: `coordinatorwaitlist-title`, Type: header, Action: 0, API: api_v1_coordinator_waitlist_list_get)<br>`coordinatorwaitlist_content` (ID: `coordinatorwaitlist-content`, Type: layout, Action: 0, API: api_v1_coordinator_waitlist_list_get)<br>`coordinatorwaitlist_loading` (ID: `coordinatorwaitlist-loading`, Type: loading, Action: 0, API: api_v1_coordinator_waitlist_list_get) |
| `coordinator_waitlist_pagination` | Pagination Section | pagination | *No elements* |
| `coordinator_waitlist_action_bar` | Action Bar Section | action_bar | `coordinatorwaitlist_btn_4` (ID: `coordinatorwaitlist-btn-4`, Type: button, Action: 1, API: api_v1_coordinator_waitlist_list_get)<br>`coordinatorwaitlist_btn_1` (ID: `coordinatorwaitlist-btn-1`, Type: button, Action: 1, API: api_v1_coordinator_waitlist_list_get)<br>`coordinatorwaitlist_btn_5` (ID: `coordinatorwaitlist-btn-5`, Type: button, Action: 1, API: api_v1_coordinator_waitlist_list_get)<br>`coordinatorwaitlist_btn_2` (ID: `coordinatorwaitlist-btn-2`, Type: button, Action: 1, API: api_v1_coordinator_waitlist_list_get)<br>`coordinatorwaitlist_btn_3` (ID: `coordinatorwaitlist-btn-3`, Type: button, Action: 1, API: api_v1_coordinator_waitlist_list_get) |

## Profile Screen Example: CaregiverClientProfileScreen (`caregiver_client_profile`)
| Section Code | Section Name | Section Type | Elements (Test ID, Type, Action Required, API Usage) |
| --- | --- | --- | --- |
| `caregiver_client_profile_header` | Header Section | header | `screen_root` (ID: `caregiver_client_profile-screen`, Type: layout, Action: 0)<br>`page_title` (ID: `caregiver_client_profile-title`, Type: header, Action: 0) |
| `caregiver_client_profile_identity_summary` | Identity Summary Section | summary | *No elements* |
| `caregiver_client_profile_details_form` | Details Form Section | form | `primary_content` (ID: `caregiver_client_profile-content`, Type: layout, Action: 0) |
| `caregiver_client_profile_preferences_or_documents` | Preferences and Documents Section | settings | `caregiverclientprofile_screen` (ID: `caregiverclientprofile-screen`, Type: layout, Action: 0)<br>`caregiverclientprofile_title` (ID: `caregiverclientprofile-title`, Type: header, Action: 0)<br>`caregiverclientprofile_content` (ID: `caregiverclientprofile-content`, Type: layout, Action: 0) |
| `caregiver_client_profile_action_bar` | Action Bar Section | action_bar | `caregiverclientprofile_btn_1` (ID: `caregiverclientprofile-btn-1`, Type: button, Action: 1)<br>`caregiverclientprofile_btn_2` (ID: `caregiverclientprofile-btn-2`, Type: button, Action: 1)<br>`caregiverclientprofile_btn_3` (ID: `caregiverclientprofile-btn-3`, Type: button, Action: 1) |

## Notes Screen Example: PswVisitNotesScreen (`psw_visit_notes`)
| Section Code | Section Name | Section Type | Elements (Test ID, Type, Action Required, API Usage) |
| --- | --- | --- | --- |
| `psw_visit_notes_header` | Header Section | header | `screen_root` (ID: `psw_visit_notes-screen`, Type: layout, Action: 0)<br>`page_title` (ID: `psw_visit_notes-title`, Type: header, Action: 0) |
| `psw_visit_notes_client_context` | Client Context Section | summary | *No elements* |
| `psw_visit_notes_notes_form` | Notes Form Section | form | `primary_content` (ID: `psw_visit_notes-content`, Type: layout, Action: 0)<br>`pswvisitnotes_screen` (ID: `pswvisitnotes-screen`, Type: layout, Action: 0)<br>`pswvisitnotes_title` (ID: `pswvisitnotes-title`, Type: header, Action: 0)<br>`pswvisitnotes_loading` (ID: `pswvisitnotes-loading`, Type: loading, Action: 0)<br>`pswvisitnotes_content` (ID: `pswvisitnotes-content`, Type: layout, Action: 0)<br>`visit_notes_textarea` (ID: `visit-notes-textarea`, Type: textarea, Action: 0) |
| `psw_visit_notes_notes_history` | Notes History Section | list | *No elements* |
| `psw_visit_notes_action_bar` | Action Bar Section | action_bar | `pswvisitnotes_btn_3` (ID: `pswvisitnotes-btn-3`, Type: button, Action: 1, API: api_v1_psw_visit_notes_update_patch)<br>`pswvisitnotes_btn_1` (ID: `pswvisitnotes-btn-1`, Type: button, Action: 1, API: api_v1_psw_visit_notes_update_patch)<br>`pswvisitnotes_btn_2` (ID: `pswvisitnotes-btn-2`, Type: button, Action: 1, API: api_v1_psw_visit_notes_update_patch)<br>`pswvisitnotes_btn_4` (ID: `pswvisitnotes-btn-4`, Type: button, Action: 1, API: api_v1_psw_visit_notes_update_patch)<br>`save_button` (ID: `save-button`, Type: button, Action: 1, API: api_v1_psw_visit_notes_update_patch) |
