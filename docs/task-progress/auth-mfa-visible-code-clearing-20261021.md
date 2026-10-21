# MFA visible code clearing — 2026-10-21

The shared Flutter auth field only synchronized its text controller when the previous widget value differed from the new widget value. A fast MFA rejection can clear controller state before an intermediate frame renders: both widget values remain empty while the text controller still holds the submitted digits.

The controlled field now reconciles its displayed text against the supplied value on rebuild. Uncontrolled fields retain their text. Password visibility resets when text is replaced. MFA code input is ignored outside an active challenge or during verification.

The existing English/French/Spanish MFA tests now assert that the rendered text controller is empty after a rejected six-digit submission and after a shorter invalid submission, without an intermediate pump. Invalid short input does not invoke the verifier. A separate test proves code input without a challenge is discarded.

This uses the existing registered MFA code control (screen949/API16496); no route, control, permission, message, schema or business record is added. It grants no independent review or whole-auth acceptance credit.

Source: d7f7a0c1ed575994d72080f312adfacdeb3a8be0. Verification39687717988 passed 301 core/session tests, 104 UI/auth tests, four clinic routing tests, static analysis, catalog reproduction and the clinic release web build.

Auth Gateway Verification39687718076 passed all 11 jobs, including shared auth checks for eight apps, Flutter auth, Dart services and runtime smoke. Workflow contract review39687718193 passed both contract-plan and generated-code jobs.

All nine portal deployments succeeded at the same source, including their exact live source-stamp and JavaScript hash checks: clinic39687718268, client39687718077, corporate39687718051, support39687718062, franchise39687718138, marketing39687718163, governance39687718217, business-development39687718073 and enterprise-blueprint39687718161. No API or database change was needed. These checks do not substitute for a real-device MFA journey or independent accessibility/security review.
