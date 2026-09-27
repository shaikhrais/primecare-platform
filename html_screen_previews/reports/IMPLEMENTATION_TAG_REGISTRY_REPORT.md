# Implementation Tag Registry Report

Lists the official implementation tags registered in the system from `implementation_tags` table.

| Tag Code | Category | Name | Description | Allowed Values |
|----------|----------|------|-------------|----------------|
| implementation_state | implementation | Implementation State | Lifecycle state of the UI implementation | `not_started`, `template_only`, `placeholder`, `mock_data`, `partial`, `implemented`, `api_connected`, `cypress_verified`, `human_reviewed`, `production_ready` |
| content_state | lifecycle | Content State | How data and content are loaded into the entity | `empty`, `placeholder`, `sample`, `mock`, `real`, `api_loaded`, `user_customized` |
| api_state | api | API State | State of the API connection integration | `no_api_required`, `api_missing`, `api_planned`, `api_mocked`, `api_connected`, `api_tested`, `api_failed` |
| action_state | lifecycle | Action State | Interactive trigger action state | `no_action`, `disabled`, `placeholder_action`, `local_action`, `api_action`, `validated_action`, `tested_action` |
| test_state | testing | Test State | Cypress/unit test lifecycle state | `no_test`, `test_defined`, `test_generated`, `test_failed`, `test_passed` |
| review_state | review | Review State | Human or architectural design review state | `not_reviewed`, `needs_review`, `reviewed`, `approved`, `rejected` |
| visual_state | quality | Visual State | Interactive states for UI view preview switcher | `loading`, `empty`, `error`, `success`, `ready` |
