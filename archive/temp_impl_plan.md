# Screen Layout Normalization

The architectural requirement states that all content screens must be wrapped strictly by their role-based layout (`AdminLayout`, `ProviderLayout`, `ClientLayout`) acting as the Master Scaffold. Individual screens should not directly instantiate `Scaffold`, as nested Scaffolds disrupt semantic structure and layout flow. 

However, current analysis indicates 40+ screens in `lib/offices/` directly instantiate `Scaffold(backgroundColor: Colors.transparent, body: ...)`.

## Proposed Changes

To correct this, I will implement a global refactor to convert all screens into pure content widgets.

### [Global Screen Patch]
I will execute an automated Dart transformation script across `apps/primecare_v4/lib/offices/**/*.dart`.
- The script will locate all `Widget build` methods returning a `Scaffold`.
- It will unwrap the `Scaffold` and promote its `body` widget to be the root return element of the `build` method.
- E.g., `return Scaffold(backgroundColor: Colors.transparent, body: CustomScrollView(...));` becomes `return CustomScrollView(...);`

## User Review Required

> [!WARNING]
> This patch will physically alter 40+ dashboard files across all 36 roles.
> I will run `dart analyze` immediately afterwards to ensure no orphaned brackets or syntax errors are introduced. 

## Open Questions

Is there any specific screen that **needs** its own `Scaffold` (for example, a screen that uses `FloatingActionButton` heavily, or a standalone auth screen not in the layout wrapper)? 
Assuming no, I will proceed with stripping `Scaffold` strictly from `lib/offices/` screens since they are all governed by `MasterLayout`.

## Verification Plan

### Automated Tests
- Run `dart analyze` across `apps/primecare_v4` to verify strict Dart grammar parity.
- Confirm zero compilation issues.

### Manual Verification
- Render the frontend and verify navigation routing cascades perfectly into the `MasterLayout`.
