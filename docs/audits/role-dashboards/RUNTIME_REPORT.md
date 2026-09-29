# Live all-role dashboard audit

64 QA accounts were created and verified in the isolated PrimeCare QA tenant. Existing identities and passwords were not overwritten. The real CEO account was not changed.

Passwords remain in the TEST_DEFAULT_PASSWORD GitHub secret. Test account emails are qa.<role>@test.primecare.local.

## Results

- API login and session-role checks: 0/64 passed.
- Browser login with visible session identity: 0/64 passed.
- Dashboard observations: {'not_verified': 64}.
- All 64 live API login attempts returned HTTP 403; browser checks were skipped by the API prerequisite. These are blocked/unverified checks, not 64 proven credential failures.
- Fully functional business dashboards: none verified. Rendering or successful authentication is not proof that buttons, metrics, permissions, persistence, and business workflows work.

Static analysis separately found 40 role entries with simulated success/inactive actions/incomplete API contracts and 24 role entries whose configured landing route is absent from the screen registry.

| Role | API session | Browser session | Dashboard | Actual path / failure phase |
|---|---|---|---|---|
| admin | not_verified | not_verified | not_verified | 403 |
| bus_dev | not_verified | not_verified | not_verified | 403 |
| caregiver | not_verified | not_verified | not_verified | 403 |
| ceo | not_verified | not_verified | not_verified | 403 |
| cfo | not_verified | not_verified | not_verified | 403 |
| chiropractor | not_verified | not_verified | not_verified | 403 |
| ciso | not_verified | not_verified | not_verified | 403 |
| clinical_director | not_verified | not_verified | not_verified | 403 |
| cns | not_verified | not_verified | not_verified | 403 |
| community_outreach | not_verified | not_verified | not_verified | 403 |
| compliance | not_verified | not_verified | not_verified | 403 |
| coo | not_verified | not_verified | not_verified | 403 |
| cto | not_verified | not_verified | not_verified | 403 |
| customer_support | not_verified | not_verified | not_verified | 403 |
| cx_director | not_verified | not_verified | not_verified | 403 |
| dynamic | not_verified | not_verified | not_verified | 403 |
| employee | not_verified | not_verified | not_verified | 403 |
| family | not_verified | not_verified | not_verified | 403 |
| finance_director | not_verified | not_verified | not_verified | 403 |
| franchise_sales | not_verified | not_verified | not_verified | 403 |
| gm | not_verified | not_verified | not_verified | 403 |
| governance | not_verified | not_verified | not_verified | 403 |
| guest | not_verified | not_verified | not_verified | 403 |
| hr_director | not_verified | not_verified | not_verified | 403 |
| hr_hiring | not_verified | not_verified | not_verified | 403 |
| hsw | not_verified | not_verified | not_verified | 403 |
| infrastructure | not_verified | not_verified | not_verified | 403 |
| intake | not_verified | not_verified | not_verified | 403 |
| legal | not_verified | not_verified | not_verified | 403 |
| local_marketing | not_verified | not_verified | not_verified | 403 |
| lpn | not_verified | not_verified | not_verified | 403 |
| marketing | not_verified | not_verified | not_verified | 403 |
| np | not_verified | not_verified | not_verified | 403 |
| ops_manager | not_verified | not_verified | not_verified | 403 |
| owner | not_verified | not_verified | not_verified | 403 |
| partnership | not_verified | not_verified | not_verified | 403 |
| patient | not_verified | not_verified | not_verified | 403 |
| pediatric | not_verified | not_verified | not_verified | 403 |
| physician | not_verified | not_verified | not_verified | 403 |
| physio | not_verified | not_verified | not_verified | 403 |
| portal | not_verified | not_verified | not_verified | 403 |
| premium_concierge | not_verified | not_verified | not_verified | 403 |
| psw | not_verified | not_verified | not_verified | 403 |
| qa_specialist | not_verified | not_verified | not_verified | 403 |
| regional_bdm | not_verified | not_verified | not_verified | 403 |
| regional_manager_usa | not_verified | not_verified | not_verified | 403 |
| rmt | not_verified | not_verified | not_verified | 403 |
| rn | not_verified | not_verified | not_verified | 403 |
| rn_field_supervisor | not_verified | not_verified | not_verified | 403 |
| rpn | not_verified | not_verified | not_verified | 403 |
| scheduler | not_verified | not_verified | not_verified | 403 |
| scrum_master | not_verified | not_verified | not_verified | 403 |
| shareholder | not_verified | not_verified | not_verified | 403 |
| social_worker | not_verified | not_verified | not_verified | 403 |
| system_verification | not_verified | not_verified | not_verified | 403 |
| territory_expansion | not_verified | not_verified | not_verified | 403 |
| territory_sales | not_verified | not_verified | not_verified | 403 |
| therapist | not_verified | not_verified | not_verified | 403 |
| training | not_verified | not_verified | not_verified | 403 |
| training_coordinator | not_verified | not_verified | not_verified | 403 |
| training_director | not_verified | not_verified | not_verified | 403 |
| vip_manager | not_verified | not_verified | not_verified | 403 |
| volunteer | not_verified | not_verified | not_verified | 403 |
| volunteer_coordinator | not_verified | not_verified | not_verified | 403 |

## Evidence

- Provisioning and disposable-database checks: https://github.com/shaikhrais/primecare-platform/actions/runs/36561427430 (provisioning succeeded; the original browser phase was canceled because its selectors needed correction).
- Corrected live audit: https://github.com/shaikhrais/primecare-platform/actions/runs/36561797647
- Single-request diagnostic: https://github.com/shaikhrais/primecare-platform/actions/runs/36562305065. HTTP 403, plain-text response containing code 1010, no PrimeCare gateway header. This indicates an upstream access rejection; no further login attempts were made. The workflow completed its evidence collection, but did not pass authentication or dashboard acceptance.

The audit does not execute arbitrary dashboard buttons, which could alter business records. Missing end-to-end business acceptance coverage is recorded rather than assumed to pass.
