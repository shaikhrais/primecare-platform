# Shared disabled-tab initial state

Batch summary: initialize shared tab buttons and panels to an unselected, hidden state before the existing first-enabled-tab selection. All-disabled groups must not display every panel with no selected tab. Preserve caller-owned content, registered identifiers, theme, labels and existing navigation. No grants or business activation.

On exact878a5340 source, the new all-disabled public-API DOM regression fails: tabs have no explicit unselected state and panels start visible. The mixed-state regression already passes and remains unchanged: a disabled first item is skipped and the first enabled item owns the visible panel.

PrimeComponentFactory.tabs now sets aria-selected=false, tabIndex=-1 and panel.hidden=true during construction. The existing choose path still activates the first enabled tab. All-disabled groups remain inactive, with original content nodes retained inside hidden panels. This is presentation state, not an authorization boundary.

Local evidence:9 lifecycle/state tests+4 existing model tests pass;21 shared fixture cases pass, without double-counting the fixture checks imported by the model suite. TypeScript, browser script syntax and whitespace checks pass. Actual browser fixture adds all-disabled and mixed-state panels, checks selected/hidden/disabled states and retains keyboard focus on the enabled second tab with Home. Original controls, menus, tabs, modal/form/code/countdown/async tests remain. Real browser and native verification run only in GitHub Actions.

Pre-repair exact878a5340 all25listed workflows succeeded, including work-modules43182274434,ThemeCenter43182275172,crossbatch43182275145,boundary43182274175,contract43182274208 and workspace43182274395. Thus the prior web Save/recovery focus batch is verified. These results are not acceptance of this new change.

Strict findings previous0/current0/new removals0.72source mappings remain reconciled;0fully accepted/72pending,0/344screens0/147workflows promoted. Native historical receipts, replayv2/29dependency pins and all thresholds are unchanged.
