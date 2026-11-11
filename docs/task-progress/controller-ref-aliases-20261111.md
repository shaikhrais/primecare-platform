# Generated controller reference initialization repair

19 generated StateNotifier controllers declare both final Ref ref and final Ref _ref, while their constructor initializes only _ref. The public non-null final field is uninitialized, so these consumers cannot compile when directly imported by the new native coverage.

Keep the existing constructor, private injected reference, state model, actions and callbacks. Replace only the uninitialized public field with a read-only getter returning that existing injected reference. Do not introduce a second provider reference, global state, account scope, network operation or permission change.

Exact input/output receipts gate the utility and compose before prior palette/control source proofs. Native compile fixtures already cover the actual affected finance/operations libraries. Add an actual IntakePipelineController provider test with two independent containers to verify reference identity and state isolation. Native execution must still pass before acceptance.
