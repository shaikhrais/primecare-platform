# Role dashboard audit

This is a static source/governance audit, not proof of live functionality. Authenticated login and browser results are reported separately in RUNTIME_REPORT.md. No user passwords were read.

Active roles: 64. Roles with concrete static findings: 64.

| Role | App | Findings |
|---|---|---|
| chiropractor | clinic | empty_action; incomplete_api_contract; simulated_success |
| physio | clinic | empty_action; incomplete_api_contract; simulated_success |
| rmt | clinic | empty_action; incomplete_api_contract; simulated_success |
| social_worker | clinic | empty_action; incomplete_api_contract; simulated_success |
| therapist | clinic | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| clinical_director | clinic | empty_action; incomplete_api_contract; not_marked_production_ready; screen_role_mismatch; simulated_success |
| intake | clinic | empty_action; incomplete_api_contract; simulated_success |
| rn | clinic | empty_action; incomplete_api_contract; simulated_success |
| physician | clinic | empty_action; incomplete_api_contract; simulated_success |
| cns | clinic | empty_action; incomplete_api_contract; simulated_success |
| pediatric | clinic | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| caregiver | clinic | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| guest | client | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| portal | client | empty_action; incomplete_api_contract; simulated_success |
| patient | client | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| dynamic | support | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| infrastructure | governance | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| system_verification | governance | post_login_route_not_in_screen_registry |
| training | governance | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| ceo | corporate | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| cfo | corporate | post_login_route_not_in_screen_registry |
| ciso | corporate | post_login_route_not_in_screen_registry |
| coo | corporate | post_login_route_not_in_screen_registry |
| cto | corporate | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| cx_director | corporate | post_login_route_not_in_screen_registry |
| finance_director | corporate | post_login_route_not_in_screen_registry |
| hr_director | corporate | post_login_route_not_in_screen_registry |
| legal | corporate | post_login_route_not_in_screen_registry |
| owner | franchise | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| shareholder | corporate | post_login_route_not_in_screen_registry |
| training_director | corporate | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| community_outreach | marketing | post_login_route_not_in_screen_registry |
| compliance | governance | post_login_route_not_in_screen_registry |
| franchise_sales | franchise | post_login_route_not_in_screen_registry |
| gm | support | post_login_route_not_in_screen_registry |
| governance | governance | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| bus_dev | business_development | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| marketing | marketing | post_login_route_not_in_screen_registry |
| local_marketing | marketing | post_login_route_not_in_screen_registry |
| ops_manager | support | post_login_route_not_in_screen_registry |
| partnership | business_development | post_login_route_not_in_screen_registry |
| regional_bdm | business_development | post_login_route_not_in_screen_registry |
| regional_manager_usa | support | post_login_route_not_in_screen_registry |
| scrum_master | support | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| hr_hiring | support | post_login_route_not_in_screen_registry |
| territory_expansion | business_development | post_login_route_not_in_screen_registry |
| territory_sales | business_development | post_login_route_not_in_screen_registry |
| volunteer_coordinator | support | post_login_route_not_in_screen_registry |
| premium_concierge | support | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| vip_manager | support | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| psw | clinic | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| hsw | clinic | empty_action; incomplete_api_contract; simulated_success |
| rn_field_supervisor | clinic | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| np | clinic | empty_action; incomplete_api_contract; simulated_success |
| rpn | clinic | empty_action; incomplete_api_contract; simulated_success |
| lpn | clinic | empty_action; incomplete_api_contract; simulated_success |
| employee | support | empty_action; incomplete_api_contract; simulated_success |
| volunteer | support | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| admin | support | empty_action; incomplete_api_contract; simulated_success |
| scheduler | support | post_login_route_not_in_screen_registry |
| customer_support | support | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| training_coordinator | governance | empty_action; incomplete_api_contract; simulated_success |
| qa_specialist | support | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
| family | client | empty_action; incomplete_api_contract; not_marked_production_ready; simulated_success |
