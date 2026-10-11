# Shared Admin layout

Inheritance: `AdminScreen`, `AdminAuditScreen`, and `AdminTasksScreen` → `BasePrimecareScreen` → `BasePrimecareLayout` → Flutter `StatelessWidget`.

`BasePrimecareLayout` owns window classification and typography. `PrimecareLayoutData` supplies the shared spacing and content limits. `PrimecareDetailLayout` stacks account actions on narrow windows or when accessibility text needs more space. Business data, permissions, requests and canonical role/status values remain in the inherited Admin workflow.

| Available window width, logical pixels | Layout | Page padding | Maximum content width |
| --- | --- | --- | --- |
| Below 600 | Mobile; detail actions below text | 12 | Available width |
| 600–1023 | Tablet | 20 | Available width |
| 1024–1919 | Desktop | 24 | 1200 |
| 1920–2559 | Wide desktop | 32 | 1440 |
| 2560 and above | Ultra-wide / unscaled 4K window | 32 | 1600 |

At ultra-wide widths the inherited theme increases text size by 20%; user accessibility text scaling still applies. Widths refer to the app window, not physical inches. A 75-inch 4K display can expose a smaller logical viewport depending on OS scaling, browser zoom and window size, and follows the corresponding policy. Physical display size and viewing distance are not reliably available to the app.

All three Admin screens scroll vertically, and account action groups wrap. `PrimecareFormDialog` centrally constrains dialogs to the available screen and scrolls translated titles and form content together, keeping wrapping actions outside the scroll area. Its preferred width is 420 logical pixels, or 560 for ultra-wide windows. The language menu remains available on mobile while its repeated language name is hidden to leave room for the screen title. Shared EN/ES/FR labels are unchanged. Resizing rebuilds presentation without replacing controllers or reloading business data.

Verification added: 15 screen scenarios across 320, 600, 1024, 1920 and 3840 logical pixels in EN/ES/FR; three mobile editor scenarios at double-size accessibility text with a resize to 4K; and one search-state preservation/no-extra-request scenario. Each screen scenario checks workspace, audit and task overview with long account data. Flutter CI results are pending.

The nine implemented tasks remain workspace summary, account directory, search/status filtering, creation, editing, activation/deactivation, tenant audit, account-specific audit and language selection. No Admin operation or permission is added by a layout breakpoint.
