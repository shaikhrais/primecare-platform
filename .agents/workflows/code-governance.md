# PrimeCare Strict Code Governance SOP 

**Purpose:** 
This workflow is the ultimate source of truth for **Code Governance** across the PrimeCare monorepo. It ensures that 100% of newly written code—whether by a human developer or an AI Agent—adheres mathematically to the zero-error "loose code" elimination rules embedded in the root `analysis_options.yaml`.

## The Problem With "Loose Code"
Historically, Dart permits `dynamic` types resulting in loose data resolution. In enterprise health-tech applications, implicit downcasts and deferred typing cause invisible runtime crashes (`NoSuchMethodError` or `type 'dynamic' is not a subtype of type...`).

## The Governance Rules (MANDATORY for all New Code)

### Rule 1: Zero Dynamic Method Invocation
You are expressly **FORBIDDEN** from leaving variables untyped or operating on `dynamic` shapes (like arbitrary JSON responses) without strict casting.
- **BAD**: `final name = result['firstName'];` 
- **GOOD**: `final String name = result['firstName'] as String;`

### Rule 2: Strict Inference on Collections & Async
Every collection generic, `List/Map`, and `Future` MUST have explicit typing.
- **BAD**: `Future.delayed(Duration(seconds: 1))`
- **GOOD**: `Future<void>.delayed(const Duration(seconds: 1))`
- **BAD**: `final list = [];`
- **GOOD**: `final List<String> list = <String>[];`

### Rule 3: Zero Implicit Function Parameter Types
You may not define function callbacks or lambdas without explicitly resolving parameter/return types.
- **BAD**: `onChanged: (val) { ... }`
- **GOOD**: `onChanged: (String val) { ... }`

### Rule 4: Progressive Refactoring (Pay-on-Touch) for Legacy Code
**Legacy Quarantine**: To prevent old, un-governed code from blocking platform builds, we injected `// ignore_for_file:` headers at the very top of legacy adapter and UI files. This "Stop the Bleeding" action silenced the 300+ hidden errors across older layers, achieving a "Zero-Error" globally stable state without rewriting thousands of lines of code blindly.

When you (or an AI agent) naturally update old files to add new features, the standard operating procedure is:
1. **Delete the `ignore_for_file` block** at the top of the file.
2. This will instantly expose its hidden legacy errors. 
3. You must then modernize its typings and fix those errors safely in tandem with your feature upgrade. 
4. You may **NEVER** re-apply the `ignore_for_file` bypass directive on newly authored code or refactored components.

---

## Developer & Agent Implementation Checklist

Whenever you (the AI Agent) are tasked with generating a new module, provider, API router, adapter, or UI component:

1. **Verify Strict Typings during implementation:**
   Review your newly authored functions and objects: Have you explicitly stated `Map<String, dynamic>`? Have you safely mapped generic arrays?
2. **Execute Local Validation:**
   After writing any Dart files, you MUST run:
   ```bash
   dart format .
   dart analyze
   ```
3. **Commit ONLY on "Zero-Errors":**
   If `dart analyze` reports *any* strict typing issues (`avoid_dynamic_calls`, `inference_failure`, etc.), you must fix the code. Bypassing the checks via `--no-verify` or inserting an ignore header is strictly prohibited on new files.

> [!CAUTION] 
> This repository enforces `strict-casts: true`, `strict-inference: true`, and `strict-raw-types: true` at the root. Legacy files have been isolated, so any new errors generated are entirely the fault of the latest code edit. Fix the root cause immediately!
