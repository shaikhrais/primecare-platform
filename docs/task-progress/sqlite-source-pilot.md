# Private-review revision 2: clinic/Linux SQLite source pilot

Status: authored for independent review, not published, not run. No local tests,
syntax checks, analyzer, compiler, source archive download or binary download were
performed. A future GitHub Actions result is required before any runtime claim.

Revision 1 remains an unchanged, unreviewed historical checkpoint. Revision 2
addresses the independent review's Clang configuration, owned-cache identity,
subprocess capture bound and raw-URL control-character findings. These changes
require a new full source review and coordinator GO before publication.

## Exact scope

Add one pull-request workflow restricted to existing PR #222, its own repository,
and Linux x64 on GitHub-hosted ubuntu-24.04. Use Flutter 3.41.5, contents:read,
fresh pilot-owned Pub cache/state, checkout credentials disabled, no secrets,
no services, no deployment or production access. Preserve all existing workflows
and app source files in Git. Do not create a branch. The only deliberate tracked
modification inside the disposable CI checkout is an explicit hooks.user_defines
section appended to the exact clinic pubspec preimage. A dedicated SQLite query
probe is copied to a new test filename only inside that checkout.
Two tiny compiler launchers are generated only in the owned CI state directory;
only the job PATH is prepended with that directory. No system tool is replaced.

New files:
- .github/workflows/sqlite-source-pilot.yml
- scripts/verify_sqlite_source.py
- scripts/inspect_sqlite_source_pilot.dart
- scripts/tests/test_verify_sqlite_source.py
- scripts/tests/sqlite_source_probe_test.dart
- docs/task-progress/sqlite-source-pilot.md

The pilot does not replace failed binary delivery automatically. Existing binary
checksums are untouched, and existing required workflows remain authoritative.
There is no runtime engine migration, system-SQLite fallback, database change,
API change, permission change, Gradle fix, PDFium fix or iOS support claim.

## Baseline and authoritative provenance

Repository baseline: shaikhrais/primecare-platform PR222 head
68ea5da9409c1e3fecee39231f7a2d493cd5dae3. Read .agents/AGENTS.md at that
commit (Git blob f8d33822e886b5b5eed8b8e9eb2f9144289dafab). Existing-PR
authorization overrides its generic main-only rule for this task. Its production
governance authority and no-operational-SQLite rules remain fully applicable.

Clinic pubspec.yaml Git blob: 526a535a32b24956e3a4d598ceb9cd4da7418516.
Clinic test/auth_routing_test.dart Git blob: ff689f39721e2d2c458d6d1f4089aaf5a08172f0.
GitHub returned 404 for clinic pubspec.lock at this head. Do not claim a committed
lock exists. The pilot captures a fresh resolved graph, requires sqlite3 exactly
3.5.2 and the drift-to-sqlite3 dependency edge, then enforces its lock and compares
the entire graph before and after configuration/testing. Other package roots
may resolve sqlite3 2.9.4; they are not configured or overridden by this pilot.

Official SQLite 3.53.4 release notes:
https://www.sqlite.org/releaselog/3_53_4.html
- sqlite3.c SHA3-256: 67f423e9ebbbdc473cbc4772c872ee6b89f31fde4ed0279a5c25d5f65c043a16
- SQLITE_SOURCE_ID: 2026-07-24 19:02:57 bf7c7f30031888f4e796e429ab3978879485813aaca6f641c7b33e4e09459bcc

Both were directly verified from that versioned official page. The source archive
URL is https://sqlite.org/2026/sqlite-amalgamation-3530400.zip. An archive digest
seen only in historical search results is deliberately NOT used or represented
as live-verified. This is a different source-verification strategy, not unchanged
binary verification: the ZIP is merely an untrusted bounded transport envelope.
Only the sqlite3.c member matching the authoritative SHA3 pin reaches disk or a
compiler. No external sqlite3.h, sqlite3ext.h, shell.c or other member is extracted.

The official amalgamation documentation explicitly says sqlite3.h is embedded
within sqlite3.c, and the core plus optional FTS5/RTREE/DBSTAT/SESSION code is in
the same translation unit: https://www.sqlite.org/amalgamation.html

The sqlite3-3.5.2 hook compiles sources:[sourceFile] and includes the source file's
directory, plus user additions. This pilot supplies no hook additions and leaves
the default compiler defines and hook flags unchanged. The launcher described
below adds only Clang's --no-default-config safety option. Its fresh source directory contains only
verified sqlite3.c. Hook files are checked against official Git blobs:
- hook/build.dart: 7df76a598b3eec21fad1313a963de0c8771d4155
- lib/src/hook/compile/description.dart: 56339a7b7d7b190bbce3d364b649481c547a85c2
- lib/src/hook/compile/used_symbols.dart: 309788168db6528ec3e97533ae0e841de774472e
https://github.com/simolus3/sqlite3.dart/tree/sqlite3-3.5.2/sqlite3
https://github.com/simolus3/sqlite3.dart/blob/sqlite3-3.5.2/sqlite3/doc/hook.md

## Toolchain trust and evidence limits

Trust the existing GitHub-hosted runner and its installed package database.
This is NOT immutable-image or independently signed toolchain attestation.
Record ImageOS/ImageVersion, selected paths, launcher and real-target SHA256 values,
package versions and header SHA256 values. Missing tools, unexpected paths, unowned files, package
integrity failures or injected compiler/linker/include settings fail the job.
Never silently install, select a different source, or weaken a failed check.

Flutter's actual Linux selector is checked against its official 3.41.5 Git blob
4e1b82dd2558a4a5dd2828889b3c0a9ba13a271f. It selects clang++ through PATH,
resolves its real path, then selects sibling clang, llvm-ar/ar, and ld.lld/ld:
https://github.com/flutter/flutter/blob/3.41.5/packages/flutter_tools/lib/src/isolated/native_assets/linux/native_assets.dart
The initial system compiler, C++ driver, linker, archiver and /bin/sh target must
belong to installed system packages and pass dpkg --verify. Their named absolute
paths, resolved target paths and bytes are bound separately from the launchers.
The helper writes regular, non-symlink clang and clang++ executable files with
exactly a /bin/sh shebang followed by exec of the fixed, single-quoted target,
--no-default-config and quoted "$@". No target lookup, environment interpolation,
eval or other launcher logic is present. Sibling linker/archiver links retain
the original selector's tool names and fixed verified targets. Unexpected files,
launcher/target drift, replaced links or a PATH selection bypass fail the job.

Using regular files matters because Flutter resolves clang++ symlinks before
finding sibling tools. After the job PATH is prepended, the pinned selector
therefore finds the owned launchers. Header preprocessing and every compiler call
from the native hook, including its early --version recognizer calls, use those
launchers. Clang's default user/system/executable-directory configuration loading
is disabled before any of those calls. The helper rejects injected toolchain and
driver settings, including CCC_OVERRIDE_OPTIONS, CLANG_CONFIG_FILE_USER_DIR and
CLANG_CONFIG_FILE_SYSTEM_DIR, before launcher use and immediately before testing.
The pinned hook and strict source-only user_defines allow no contradictory extra
flags or explicit config input. No installed Config/config.h prerequisite is
assumed and no package is installed to satisfy this gate.

Authoritative implementation references:
- Clang disables default configuration before searching those directories:
  https://github.com/llvm/llvm-project/blob/llvmorg-18.1.8/clang/lib/Driver/Driver.cpp
  (Git blob 93cddf742d521d25dc9ad397804cd829e44cbbd3, loadDefaultConfigFiles).
- CCC_OVERRIDE_OPTIONS can rewrite arguments before driver construction:
  https://github.com/llvm/llvm-project/blob/llvmorg-18.1.8/clang/tools/driver/driver.cpp
  (Git blob 1407c7fcdab769bcf7e93aba0ad48d6131d023ac).
- Configured-compiler recognition invokes --version before CBuilder flags:
  https://github.com/dart-lang/native/blob/main/pkgs/native_toolchain_c/lib/src/native_toolchain/recognizer.dart
  (reviewed Git blob 9eddd3904a44c60b084f6dd36afb615f6ed1dbad).
- The published ubuntu-24.04 toolset currently defaults to Clang 18; the actual
  job's selected package identity is still checked and recorded:
  https://github.com/actions/runner-images/blob/main/images/ubuntu/toolsets/toolset-2404.json

After C-source verification, preprocessing with that launcher and the exact
upstream default defines enumerates required headers. Every header must resolve
to an allowlisted system path, belong to a package, and pass package integrity
verification before the native build. Hashes are rechecked before/after testing.
These are checked prerequisites and a bounded header-dependency preflight, not a
claim to have independently attested every process or linker input.

The cache is created empty at exactly RUNNER_TEMP/sqlite-source-pilot-pub before
Flutter setup. An exclusive ownership record binds both state/cache directory
paths and device/inode identities. The environment path, directory type, resolved
path and identity are checked immediately after Flutter setup, at preflight,
before source work and at every recheck. A setup action may not silently redirect
PUB_CACHE to a shared location or replace the owned directory. The Flutter action
also receives explicit pub-cache:false and the exact pub-cache-path.

The Linux-only subprocess helper drains stdout with select/os.read and accepts
at most 4 MiB plus one overflow-detection byte. It never accumulates an unbounded
PIPE result before checking. Drain/wait has a 30-second deadline. Overflow,
timeout or read failure kills the owned process group and reaps it with a further
five-second cleanup bound; a cleanup failure is itself reported as failure.
Stderr is discarded and errors expose fixed reason codes only. Authored tests
mock process/pipe/time interfaces, so they need neither sockets nor real children.

## GitHub-only verification sequence

1. Run synthetic socket-free Python fixtures before Flutter setup or live fetch.
   Retain the original 25 cases and add launcher/env, cache identity, capture
   overflow/timeout/cleanup, sanitized error and raw-control-character cases.
2. Resolve clinic dependencies, capture graph/lock/package identity, validate exact
   sqlite3 3.5.2 hook and Flutter selector, verify selected system tools, then
   create and bind the fixed compiler launchers for all later compiler calls.
3. Fetch only the fixed official HTTPS source URL, retaining normal TLS validation
   and configured proxies/NO_PROXY. Permit at most two redirects between sqlite.org
   and www.sqlite.org at the exact path, no query/credentials/fragments. Reject
   raw URL and Location controls before urlsplit/urljoin can normalize them. Use a
   12-second operation timeout and 45-second total fetch/verification alarm.
4. Bound ZIP transport to 8 MiB, entries to eight, individual source to 16 MiB,
   total declared content to 24 MiB. Reject duplicate/unexpected/traversal names,
   symlinks, encryption, unsupported compression, malformed/oversized bodies,
   non-success status and non-ZIP media. Never log response bodies, untrusted
   URLs, exception strings or environment values. Failed bytes stay in memory
   only and are never extracted, retained as files, compiled or executed.
5. Verify source SHA3/source ID, inspect system header prerequisites, append explicit
   source configuration to the known clinic pubspec only, enforce the captured
   lock, and reject graph/package/config/source/tool/header drift.
6. Run the unchanged clinic test/auth_routing_test.dart plus the isolated probe.
   The probe executes an in-memory SELECT against the loaded SQLite, checking
   version, source ID and returned value. All original assertions and failure
   statuses remain intact; no continue-on-error or success masking.
7. Parse the generated SQLite hook input/output using the resolved hooks and
   code_assets APIs, rather than guessing user-defines JSON nesting. Require
   source mode, the verified absolute C path, no extra flags/includes/defines,
   expected package/toolchain mapping, both launcher and underlying target hashes,
   bundled output in that hook's output
   directory, source dependency registration, no precompiled download path,
   and matching bytes in Flutter's native-assets mapping. Version/source-ID
   equality alone is explicitly insufficient evidence of source mode.
8. Recheck dependency/config/input integrity and tracked changes. Retain only the
   safe ownership/before/source/result JSON metadata for seven days, not archives
   or C source.

## Review and remaining uncertainty

All files remain unexecuted until reviewed and explicitly published by the
coordinator to the existing PR. Publication must re-read the PR head and validate
new-file absence plus unchanged pinned preimages. The first GitHub run may expose
tool availability, dependency-resolution, parser/API or fixture mistakes. It may
fail before compilation, during source compilation, during the original auth
assertions, or during evidence verification. Report those stages separately.
No source-build success or release readiness can be claimed from this document.

Current native failure is a delivery failure: the rejected digest matches the
reviewed 504 HTML response (92 bytes), not a proven SQLite ABI defect. Preserve
the official Linux binary SHA256 b17729184e5a2818055ecbddd5ed6642521bfe6e56aafa472330e483c0e2e0d2.
The pilot's result cannot turn the existing failing binary-delivery gate green.
