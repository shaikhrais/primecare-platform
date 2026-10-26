# Floating staff phone dialer

Source `f568f17c97ae1e95dcaf2cc6d05f58a4d7c8760d` adds one shared floating
phone dock across permitted staff portals and Code Admin. Reload the portal,
then tap **PrimeCare Phone** in the bottom corner. **Calls → Open dialer** also
expands it. Tap the header again to minimize; Escape does the same.

The desktop panel is 360 × 640 px, constrained by the visible viewport. It
minimizes to a 248 × 64 px launcher. The body scrolls on shorter screens and
the footer remains accessible. Android visual viewport changes reposition the
dock above the keyboard. Number entry and an active call survive minimizing
and portal-section redraws within the current page.

Use **+**, country code and the number, then **Call phone**. **Enable mic**
checks microphone access without reserving or starting a call. During a
connected call the keypad sends explicit SDK tones for phone menus. **Mute**
and **End call** control the current call. No number or tone history is stored.
Keep the page open; a full reload ends the browser media session.

The existing native staff permissions, current session checks, server caller
identity and opaque call tickets are preserved. Clients cannot use external
calling. Minimizing neither starts a call nor requests microphone access.

## Verification

Twenty focused unit/gateway/PWA checks, scoped strict TypeScript and portal
bundling passed. Real Chromium fixtures passed at widths 320, 390, 768 and
1280 px, plus a 390 × 420 px viewport. They checked 48 px touch targets,
keypad editing, collapse/reopen, call preservation, simulated SDK DTMF,
mute, end, token renewal and denied-microphone behavior. Mobile screenshots
were visually reviewed. Provider SDK and audio hardware are fixtures;
automation places zero real telephone calls.

Deployment: [external calling workflow](https://github.com/shaikhrais/primecare-platform/actions/runs/40347040727).
Regression: [internal calling workflow](https://github.com/shaikhrais/primecare-platform/actions/runs/40347040719).

All 15 external deployment jobs and all 17 internal regression jobs passed.
Production staff and Code Admin/MFA checks verified the mobile dock, single
instance, native authorization and collapse/reopen; synthetic records were
removed. No live carrier audio was tested.
