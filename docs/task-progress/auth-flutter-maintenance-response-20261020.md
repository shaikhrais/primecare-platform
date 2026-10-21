# Flutter maintenance acknowledgement and deployment scheduling repair

Research inspected the registered maintenance catalogue, Worker maintenance save/test acknowledgements, auth register projection and the existing TypeScript maintenance client before changes. Flutter used a generic HTTP-success fallback that falsely displayed account creation for empty save/test responses.

The existing three mutations now require their own acknowledgements. Maintenance creation requires HTTP201 and a nonempty returned account identity matching submitted normalized email, maintenance role, active status and the captured tenant. Settings/test actions require their exact existing message and HTTP200. Malformed results preserve account drafts and cannot refresh or clear them. Reads/mutation replies from a replaced token/user/tenant are ignored; configuration from the previous actor is not rendered for the replacement actor.

Four widget scenarios cover malformed/cross-tenant responses, confirmed save/test/create behavior and actor replacement. They are included in Auth Gateway Verification. Local YAML, embedded Python and whitespace checks passed; execution is pending CI. The preceding recovery/navigation repair passed all eleven jobs in run39526571253, including the new reset-session and navigation regressions.

Both web publishers now share the same per-project concurrency key with cancel-in-progress=false. This serializes publishing to one Cloudflare project while preserving active deployments. It does not choose a runtime authority or convert TypeScript receipts into Flutter acceptance. Source hashes before/after the Flutter browser journey still guard against sequential replacement.
Reference: https://docs.github.com/en/actions/how-tos/write-workflows/choose-when-workflows-run/control-workflow-concurrency

The new live Flutter producer is re-requested for this exact source; its earlier pending deploy had not begun browser or synthetic-data execution at inspection. No production role/route/grant, bootstrap policy, translation approval or full acceptance status is changed.

Fresh pinned production snapshot run39526605713 reports 23 auth processes:19 implemented-unverified,4 policy-blocked,0 fully verified. The three bootstrap duties need approved operator/environment bindings; role switching lacks approved assignment/session/tenant/grant/audit semantics. Independent reviews, physical-device/PWA/manual accessibility and full actor/failure coverage remain open.
