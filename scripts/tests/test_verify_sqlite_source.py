"""Synthetic, socket-free fixtures. Run only in GitHub Actions for this task."""
import email.message
from contextlib import redirect_stderr
import hashlib
import importlib.util
import io
from pathlib import Path
import socket
import stat
import tempfile
import unittest
from unittest.mock import Mock, patch
import zipfile

SPEC = importlib.util.spec_from_file_location("pilot", Path(__file__).parents[1] / "verify_sqlite_source.py")
pilot = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(pilot)
GOOD = ('#define SQLITE_SOURCE_ID "' + pilot.SOURCE_ID + '"\nint fixture;\n').encode()


def archive(data=GOOD, extra=None, source_info=None):
    buffer = io.BytesIO()
    with zipfile.ZipFile(buffer, "w", compression=zipfile.ZIP_DEFLATED) as output:
        output.writestr(source_info or pilot.MEMBER, data)
        if extra:
            for name, body in extra:
                output.writestr(name, body)
    return buffer.getvalue()


class Response(io.BytesIO):
    def __init__(self, body=b"zip fixture", status=200, headers=None, url=pilot.URL):
        super().__init__(body)
        self.status = status
        self.headers = email.message.Message()
        for key, value in (headers or {"Content-Type": "application/zip"}).items():
            self.headers[key] = value
        self.url = url

    def geturl(self):
        return self.url


class Opener:
    def __init__(self, responses):
        self.responses = iter(responses)
        self.calls = []

    def open(self, request, timeout):
        self.calls.append((request, timeout))
        return next(self.responses)


class VerifierTests(unittest.TestCase):
    def setUp(self):
        self.addCleanup(patch.stopall)
        patch.object(socket, "socket", side_effect=AssertionError("Network forbidden in fixtures")).start()
        patch.object(socket, "create_connection", side_effect=AssertionError("Network forbidden in fixtures")).start()

    def accept_synthetic_pin(self):
        return patch.object(pilot, "SOURCE_SHA3", hashlib.sha3_256(GOOD).hexdigest())

    def test_verified_source_only(self):
        with self.accept_synthetic_pin():
            self.assertEqual(pilot.verified_source(archive(extra=[("sqlite-amalgamation-3530400/sqlite3.h", b"untrusted header")])), GOOD)

    def test_actual_pin_rejects_synthetic_source(self):
        with self.assertRaisesRegex(pilot.Rejected, "source-hash"):
            pilot.verified_source(archive())

    def test_source_id_is_checked_after_hash(self):
        altered = b"#define SQLITE_SOURCE_ID \"other\"\n"
        with patch.object(pilot, "SOURCE_SHA3", hashlib.sha3_256(altered).hexdigest()):
            with self.assertRaisesRegex(pilot.Rejected, "source-id"):
                pilot.verified_source(archive(altered))

    def test_invalid_zip(self):
        with self.assertRaises(zipfile.BadZipFile):
            pilot.verified_source(b"not a zip")

    def test_traversal_and_unexpected_members(self):
        for name in ("../sqlite3.c", "/sqlite3.c", "C:\\sqlite3.c", "sqlite-amalgamation-3530400/extra.h"):
            with self.subTest(name=name), self.assertRaisesRegex(pilot.Rejected, "member-name"):
                pilot.verified_source(archive(extra=[(name, b"x")]))

    def test_symlink_rejected(self):
        info = zipfile.ZipInfo(pilot.MEMBER)
        info.create_system = 3
        info.external_attr = (stat.S_IFLNK | 0o777) << 16
        with self.assertRaisesRegex(pilot.Rejected, "member-type"):
            pilot.verified_source(archive(source_info=info))

    def test_duplicate_member_rejected(self):
        with self.assertWarns(UserWarning):
            data = archive(extra=[(pilot.MEMBER, GOOD)])
        with self.assertRaisesRegex(pilot.Rejected, "duplicate-member"):
            pilot.verified_source(data)

    def test_source_bound(self):
        with patch.object(pilot, "MAX_SOURCE", 8):
            with self.assertRaisesRegex(pilot.Rejected, "member-size"):
                pilot.verified_source(archive())

    def test_archive_bound(self):
        with patch.object(pilot, "MAX_ARCHIVE", 2):
            with self.assertRaisesRegex(pilot.Rejected, "archive-size"):
                pilot.verified_source(archive())

    def test_member_count_bound(self):
        with self.assertRaisesRegex(pilot.Rejected, "member-count"):
            pilot.verified_source(archive(extra=[(str(i), b"x") for i in range(8)]))

    def test_no_archive_extraction(self):
        with self.accept_synthetic_pin(), patch.object(zipfile.ZipFile, "extract", side_effect=AssertionError), patch.object(zipfile.ZipFile, "extractall", side_effect=AssertionError):
            self.assertEqual(pilot.verified_source(archive()), GOOD)

    def test_ok_response(self):
        opener = Opener([Response()])
        self.assertEqual(pilot.fetch_archive(opener), b"zip fixture")
        self.assertEqual(opener.calls[0][1], 12)

    def test_official_redirect(self):
        opener = Opener([Response(status=302, headers={"Location": "https://www.sqlite.org/2026/sqlite-amalgamation-3530400.zip"}), Response(url="https://www.sqlite.org/2026/sqlite-amalgamation-3530400.zip")])
        self.assertEqual(pilot.fetch_archive(opener), b"zip fixture")

    def test_redirect_limit(self):
        opener = Opener([Response(status=302, headers={"Location": pilot.URL}) for _ in range(3)])
        with self.assertRaisesRegex(pilot.Rejected, "redirect-limit"):
            pilot.fetch_archive(opener)

    def test_redirect_targets(self):
        for url in ("http://sqlite.org/2026/sqlite-amalgamation-3530400.zip", "https://evil.invalid/source.zip", pilot.URL + "?token=secret", "https://user:secret@sqlite.org/2026/sqlite-amalgamation-3530400.zip", pilot.URL + "#fragment", "https://sqlite.org:443/2026/sqlite-amalgamation-3530400.zip"):
            with self.subTest(url=url), self.assertRaisesRegex(pilot.Rejected, "redirect-target"):
                pilot.allowed_url(url)

    def test_504_html_not_source(self):
        opener = Opener([Response(b"secret diagnostic body", status=504, headers={"Content-Type": "text/html"})])
        with self.assertRaisesRegex(pilot.Rejected, "^http-status$"):
            pilot.fetch_archive(opener)

    def test_html_success_rejected(self):
        with self.assertRaisesRegex(pilot.Rejected, "content-type"):
            pilot.fetch_archive(Opener([Response(headers={"Content-Type": "text/html"})]))

    def test_encoded_body_rejected(self):
        with self.assertRaisesRegex(pilot.Rejected, "content-encoding"):
            pilot.fetch_archive(Opener([Response(headers={"Content-Type": "application/zip", "Content-Encoding": "gzip"})]))

    def test_invalid_lengths(self):
        for length in ("-1", "secret", "99999999"):
            with self.subTest(length=length), self.assertRaises(pilot.Rejected):
                pilot.fetch_archive(Opener([Response(headers={"Content-Type": "application/zip", "Content-Length": length})]))

    def test_declared_length_mismatch(self):
        with self.assertRaisesRegex(pilot.Rejected, "truncated-body"):
            pilot.fetch_archive(Opener([Response(headers={"Content-Type": "application/zip", "Content-Length": "100"})]))

    def test_undeclared_body_bound(self):
        with patch.object(pilot, "MAX_ARCHIVE", 5):
            with self.assertRaisesRegex(pilot.Rejected, "byte-limit"):
                pilot.fetch_archive(Opener([Response()]))

    def test_toolchain_injection_rejected_before_command(self):
        with patch.dict(pilot.os.environ, {"CPATH": "/untrusted"}), patch.object(pilot.shutil, "which", side_effect=AssertionError):
            with self.assertRaisesRegex(pilot.Rejected, "injected-toolchain"):
                pilot.tool_paths()

    def test_graph_requires_sqlite_352(self):
        for version in ("2.9.4", "3.5.3"):
            graph = {"packages": [{"name": "sqlite3", "version": version}, {"name": "drift", "dependencies": ["sqlite3"]}]}
            with patch.object(pilot, "read_json", return_value=graph):
                with self.assertRaisesRegex(pilot.Rejected, "sqlite-version"):
                    pilot.graph_identity(Path("unused"))

    def test_graph_identity_covers_other_packages(self):
        a = {"packages": [{"name": "sqlite3", "version": "3.5.2"}, {"name": "drift", "version": "2.33.0", "dependencies": ["sqlite3"]}]}
        b = {"packages": [{"name": "sqlite3", "version": "3.5.2"}, {"name": "drift", "version": "2.34.0", "dependencies": ["sqlite3"]}]}
        with patch.object(pilot, "read_json", side_effect=[a, b]):
            self.assertNotEqual(pilot.graph_identity(Path("unused")), pilot.graph_identity(Path("unused")))

    def test_json_writes_never_overwrite(self):
        with tempfile.TemporaryDirectory() as temporary:
            target = Path(temporary) / "metadata.json"
            pilot.output_json(target, {"safe": True})
            with self.assertRaises(FileExistsError):
                pilot.output_json(target, {})

    def test_raw_url_controls_rejected_before_parser(self):
        for control in ('\x00', '\t', '\n', '\r', '\x1f', ' ', '\x7f', '\x85', '\x9f'):
            for value in (control + pilot.URL, pilot.URL[:12] + control + pilot.URL[12:]):
                with self.subTest(control=repr(control)), patch.object(pilot.urllib.parse, "urlsplit", side_effect=AssertionError("parser must not see controls")):
                    with self.assertRaisesRegex(pilot.Rejected, "^url-control$"):
                        pilot.allowed_url(value)

    def test_raw_location_controls_rejected_before_urljoin(self):
        for location in ('\n' + pilot.URL, '/2026/\tsqlite-amalgamation-3530400.zip', pilot.URL + '\r'):
            opener = Opener([Response(status=302, headers={"Location": location})])
            with self.subTest(location=repr(location)), patch.object(pilot.urllib.parse, "urljoin", side_effect=AssertionError("join must not see controls")):
                with self.assertRaisesRegex(pilot.Rejected, "^url-control$"):
                    pilot.fetch_archive(opener)
            self.assertEqual(len(opener.calls), 1)

    def test_response_url_controls_rejected(self):
        with self.assertRaisesRegex(pilot.Rejected, "^url-control$"):
            pilot.fetch_archive(Opener([Response(url='\t' + pilot.URL)]))

    def owned_environment(self, temporary):
        root = Path(temporary).resolve()
        return patch.dict(pilot.os.environ, {
            "RUNNER_TEMP": str(root),
            "PILOT_STATE": str(root / "sqlite-source-pilot-state"),
            "PUB_CACHE": str(root / "sqlite-source-pilot-pub"),
        })

    def test_owned_cache_remains_bound_after_setup(self):
        with tempfile.TemporaryDirectory() as temporary, self.owned_environment(temporary):
            pilot.initialize()
            cache = pilot.check_owned_cache()
            (cache / "setup-created-fixture").write_text("permitted content in same owned directory")
            self.assertEqual(pilot.check_owned_cache(), cache)

    def test_cache_environment_redirect_rejected(self):
        with tempfile.TemporaryDirectory() as temporary, self.owned_environment(temporary):
            pilot.initialize()
            with patch.dict(pilot.os.environ, {"PUB_CACHE": str(Path(temporary) / "shared-cache")}):
                with self.assertRaisesRegex(pilot.Rejected, "^cache-environment$"):
                    pilot.check_owned_cache()

    def test_cache_alias_path_rejected(self):
        with tempfile.TemporaryDirectory() as temporary, self.owned_environment(temporary):
            pilot.initialize()
            expected = pilot.os.environ["PUB_CACHE"]
            with patch.dict(pilot.os.environ, {"PUB_CACHE": expected + "/../sqlite-source-pilot-pub"}):
                with self.assertRaisesRegex(pilot.Rejected, "^cache-environment$"):
                    pilot.check_owned_cache()

    def test_cache_directory_replacement_rejected(self):
        with tempfile.TemporaryDirectory() as temporary, self.owned_environment(temporary):
            pilot.initialize()
            cache = pilot.check_owned_cache()
            cache.rename(Path(temporary) / "original-cache")
            cache.mkdir()
            with self.assertRaisesRegex(pilot.Rejected, "^cache-ownership$"):
                pilot.check_owned_cache()

    def test_cache_symlink_redirect_rejected(self):
        with tempfile.TemporaryDirectory() as temporary, self.owned_environment(temporary):
            pilot.initialize()
            cache = pilot.check_owned_cache()
            original = Path(temporary) / "original-cache"
            cache.rename(original)
            cache.symlink_to(original, target_is_directory=True)
            with self.assertRaisesRegex(pilot.Rejected, "^owned-directory$"):
                pilot.check_owned_cache()

    def test_cache_must_be_created_fresh(self):
        with tempfile.TemporaryDirectory() as temporary, self.owned_environment(temporary):
            Path(pilot.os.environ["PUB_CACHE"]).mkdir()
            with self.assertRaisesRegex(pilot.Rejected, "^existing-pilot-directory$"):
                pilot.initialize()

    def test_driver_injection_rejected_before_tool_lookup(self):
        for name in pilot.DRIVER_ENV:
            with self.subTest(name=name), patch.dict(pilot.os.environ, {name: "private override"}), patch.object(pilot.shutil, "which", side_effect=AssertionError("no driver lookup")):
                with self.assertRaisesRegex(pilot.Rejected, "^injected-driver$"):
                    pilot.tool_paths()

    def test_fixed_launcher_bytes_always_disable_default_configs(self):
        self.assertEqual(pilot.launcher_bytes(Path('/usr/lib/llvm-18/bin/clang')),
                         b'#!/bin/sh\nexec \'/usr/lib/llvm-18/bin/clang\' --no-default-config "$@"\n')
        self.assertEqual(pilot.launcher_bytes(Path('/usr/lib/llvm-18/bin/clang++')),
                         b'#!/bin/sh\nexec \'/usr/lib/llvm-18/bin/clang++\' --no-default-config "$@"\n')

    def test_launcher_target_rejects_dynamic_or_untrusted_paths(self):
        for target in ('clang', '/tmp/clang', '/usr/bin/../private/clang', '/usr/bin/$CC', '/usr/bin/clang\nextra'):
            with self.subTest(target=target), self.assertRaisesRegex(pilot.Rejected, '^launcher-target$'):
                pilot.launcher_bytes(Path(target))

    def launcher_fixture(self, root):
        # Synthetic files only. Never execute a launcher or child process here.
        system = root / 'system'
        state = root / 'state'
        system.mkdir()
        state.mkdir()
        paths = {key: system / name for key, name in {
            'compiler': 'clang', 'clang++': 'clang++', 'archiver': 'llvm-ar',
            'linker': 'ld.lld', 'shell': 'sh',
        }.items()}
        for path in paths.values():
            path.write_text('synthetic trusted target ' + path.name)
        # The exact /usr-only production byte generator has separate fixtures.
        patch.object(pilot, 'launcher_bytes', side_effect=lambda path: ('fixture launcher for ' + str(path)).encode()).start()
        metadata = pilot.create_launchers(state, paths)
        before = {
            'system_tools': {key: str(path) for key, path in paths.items()},
            'system_tool_realpaths': {key: str(path.resolve()) for key, path in paths.items()},
            'system_tool_sha256': {key: pilot.sha(path) for key, path in paths.items()},
            **metadata,
        }
        self.selected_launcher = patch.object(pilot.shutil, 'which', return_value=str(state / 'compiler/clang++')).start()
        return state, paths, before

    def test_owned_launchers_and_system_targets_are_bound(self):
        with tempfile.TemporaryDirectory() as temporary:
            state, paths, before = self.launcher_fixture(Path(temporary))
            pilot.check_launchers(before, state)
            self.assertFalse((state / 'compiler/clang').is_symlink())
            self.assertFalse((state / 'compiler/clang++').is_symlink())

    def test_launcher_content_drift_rejected(self):
        with tempfile.TemporaryDirectory() as temporary:
            state, paths, before = self.launcher_fixture(Path(temporary))
            launcher = state / 'compiler/clang'
            launcher.chmod(0o700)
            launcher.write_text('unexpected executable bytes')
            launcher.chmod(0o500)
            with self.assertRaisesRegex(pilot.Rejected, '^launcher-drift$'):
                pilot.check_launchers(before, state)

    def test_symlink_compiler_launcher_rejected(self):
        with tempfile.TemporaryDirectory() as temporary:
            state, paths, before = self.launcher_fixture(Path(temporary))
            launcher = state / 'compiler/clang'
            launcher.unlink()
            launcher.symlink_to(paths['compiler'])
            with self.assertRaisesRegex(pilot.Rejected, '^launcher-type$'):
                pilot.check_launchers(before, state)

    def test_real_target_drift_rejected(self):
        with tempfile.TemporaryDirectory() as temporary:
            state, paths, before = self.launcher_fixture(Path(temporary))
            paths['compiler'].write_text('changed target')
            with self.assertRaisesRegex(pilot.Rejected, '^system-tool-drift$'):
                pilot.check_launchers(before, state)

    def test_path_bypass_of_launcher_rejected(self):
        with tempfile.TemporaryDirectory() as temporary:
            state, paths, before = self.launcher_fixture(Path(temporary))
            self.selected_launcher.return_value = str(paths['clang++'])
            with self.assertRaisesRegex(pilot.Rejected, '^launcher-selection$'):
                pilot.check_launchers(before, state)

    def test_linker_sibling_redirect_rejected(self):
        with tempfile.TemporaryDirectory() as temporary:
            state, paths, before = self.launcher_fixture(Path(temporary))
            sibling = state / 'compiler/ld.lld'
            sibling.unlink()
            sibling.symlink_to(paths['archiver'])
            with self.assertRaisesRegex(pilot.Rejected, '^launcher-sibling$'):
                pilot.check_launchers(before, state)

    def test_unexpected_launcher_directory_member_rejected(self):
        with tempfile.TemporaryDirectory() as temporary:
            state, paths, before = self.launcher_fixture(Path(temporary))
            (state / 'compiler/extra').write_text('unexpected')
            with self.assertRaisesRegex(pilot.Rejected, '^launcher-members$'):
                pilot.check_launchers(before, state)

    def test_driver_injection_rejected_before_launcher_read(self):
        with patch.dict(pilot.os.environ, {'CCC_OVERRIDE_OPTIONS': 'private override'}), patch.object(pilot, 'directory_identity', side_effect=AssertionError('no launcher access')):
            with self.assertRaisesRegex(pilot.Rejected, '^injected-driver$'):
                pilot.check_launchers({}, Path('/unused'))

    def fake_command(self):
        process = Mock()
        process.pid = 123456
        process.stdout.fileno.return_value = 99
        process.wait.return_value = 0
        self.spawn = patch.object(pilot.subprocess, "Popen", return_value=process).start()
        self.ready = patch.object(pilot.select, "select", return_value=([99], [], [])).start()
        self.read = patch.object(pilot.os, "read", side_effect=[b"ok", b""]).start()
        self.kill = patch.object(pilot.os, "killpg").start()
        self.clock = patch.object(pilot.time, "monotonic", return_value=0).start()
        return process

    def test_command_success_closes_and_reaps(self):
        process = self.fake_command()
        self.assertEqual(pilot.run(["fixture"]), "ok")
        process.wait.assert_called_once_with(timeout=pilot.COMMAND_TIMEOUT)
        process.stdout.close.assert_called_once()
        self.kill.assert_not_called()
        self.assertTrue(self.spawn.call_args.kwargs["start_new_session"])
        self.assertEqual(self.spawn.call_args.kwargs["stderr"], pilot.subprocess.DEVNULL)

    def test_command_cap_kills_and_reaps_without_extra_read(self):
        process = self.fake_command()
        self.read.side_effect = lambda descriptor, size: b"x" * size
        with patch.object(pilot, "MAX_COMMAND_OUTPUT", 4):
            with self.assertRaisesRegex(pilot.Rejected, "^prerequisite-output$"):
                pilot.run(["fixture"])
        self.read.assert_called_once_with(99, 5)
        self.kill.assert_called_once_with(process.pid, pilot.signal.SIGKILL)
        process.wait.assert_called_once_with(timeout=pilot.COMMAND_CLEANUP_TIMEOUT)
        process.stdout.close.assert_called_once()

    def test_command_exact_cap_can_succeed(self):
        process = self.fake_command()
        self.read.side_effect = [b"abcd", b""]
        with patch.object(pilot, "MAX_COMMAND_OUTPUT", 4):
            self.assertEqual(pilot.run(["fixture"]), "abcd")
        self.assertEqual(self.read.call_args_list[-1].args, (99, 1))
        self.kill.assert_not_called()
        process.stdout.close.assert_called_once()

    def test_command_timeout_kills_and_reaps(self):
        process = self.fake_command()
        self.clock.side_effect = [0, 0, pilot.COMMAND_TIMEOUT + 1]
        self.ready.return_value = ([], [], [])
        with self.assertRaisesRegex(pilot.Rejected, "^prerequisite-timeout$"):
            pilot.run(["fixture"])
        self.read.assert_not_called()
        self.kill.assert_called_once_with(process.pid, pilot.signal.SIGKILL)
        process.wait.assert_called_once_with(timeout=pilot.COMMAND_CLEANUP_TIMEOUT)
        process.stdout.close.assert_called_once()

    def test_command_wait_timeout_kills_and_reaps(self):
        process = self.fake_command()
        self.read.side_effect = [b""]
        process.wait.side_effect = [pilot.subprocess.TimeoutExpired("private command", 30), 0]
        with self.assertRaisesRegex(pilot.Rejected, "^prerequisite-timeout$"):
            pilot.run(["fixture"])
        self.kill.assert_called_once_with(process.pid, pilot.signal.SIGKILL)
        self.assertEqual(process.wait.call_count, 2)
        self.assertEqual(process.wait.call_args.kwargs["timeout"], pilot.COMMAND_CLEANUP_TIMEOUT)
        process.stdout.close.assert_called_once()

    def test_command_spawn_error_is_sanitized(self):
        with patch.object(pilot.subprocess, "Popen", side_effect=OSError("private URL and environment")):
            with self.assertRaisesRegex(pilot.Rejected, "^prerequisite-command$"):
                pilot.run(["fixture"])

    def test_command_read_error_is_sanitized_and_reaped(self):
        process = self.fake_command()
        self.read.side_effect = OSError("private response")
        with self.assertRaisesRegex(pilot.Rejected, "^prerequisite-command$"):
            pilot.run(["fixture"])
        self.kill.assert_called_once_with(process.pid, pilot.signal.SIGKILL)
        process.wait.assert_called_once_with(timeout=pilot.COMMAND_CLEANUP_TIMEOUT)
        process.stdout.close.assert_called_once()

    def test_command_nonzero_exit_is_preserved(self):
        process = self.fake_command()
        process.wait.return_value = 7
        with self.assertRaisesRegex(pilot.Rejected, "^prerequisite-command$"):
            pilot.run(["fixture"])
        self.kill.assert_not_called()
        process.stdout.close.assert_called_once()

    def test_command_cleanup_timeout_is_reported_and_stream_closed(self):
        process = self.fake_command()
        self.read.side_effect = lambda descriptor, size: b"x" * size
        process.wait.side_effect = pilot.subprocess.TimeoutExpired("private command", 5)
        with patch.object(pilot, "MAX_COMMAND_OUTPUT", 4):
            with self.assertRaisesRegex(pilot.Rejected, "^prerequisite-cleanup$"):
                pilot.run(["fixture"])
        self.kill.assert_called_once_with(process.pid, pilot.signal.SIGKILL)
        process.stdout.close.assert_called_once()

    def test_main_unexpected_error_does_not_log_secret_text(self):
        error_output = io.StringIO()
        with patch.object(pilot.sys, "argv", ['pilot', 'initialize']), patch.object(pilot, "initialize", side_effect=RuntimeError("private URL/environment/body")), redirect_stderr(error_output):
            self.assertEqual(pilot.main(), 1)
        self.assertEqual(error_output.getvalue(), 'SQLite source pilot rejected: unexpected-input-or-prerequisite\n')


class GeneratedSourceGuardTests(unittest.TestCase):
    def setUp(self):
        self.addCleanup(patch.stopall)
        patch.object(socket, "socket", side_effect=AssertionError("Network forbidden in fixtures")).start()
        patch.object(socket, "create_connection", side_effect=AssertionError("Network forbidden in fixtures")).start()
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.workspace = Path(temporary.name).resolve()
        self.state = self.workspace / "state"
        self.state.mkdir()
        self.name = "apps/primecare_clinic/linux/flutter/generated_plugin_registrant.cc"
        self.file = self.workspace / self.name
        self.file.parent.mkdir(parents=True)
        self.old, self.new = b"tracked fixture\n", b"generated fixture\n"
        def identity(data):
            return {"bytes": len(data), "sha256": hashlib.sha256(data).hexdigest(),
                    "git_blob_sha1": pilot.blob(data)}
        self.pins = {self.name: {"tracked": identity(self.old), "resolved": identity(self.new)}}
        patch.object(pilot, "GENERATED_PINS", self.pins).start()
        self.file.write_bytes(self.old)
        self.file.chmod(0o644)
        self.changes = []
        self.staged_changes = []
        self.tree = "100644 blob " + pilot.blob(self.old) + "\t" + self.name + "\0"
        def git_output(command, cwd=None):
            self.assertEqual(cwd, self.workspace)
            if command[:3] == ["git", "ls-tree", "-z"]:
                return self.tree
            if "--cached" in command:
                self.assertEqual(command, ["git", "diff", "--no-ext-diff", "--no-textconv",
                                           "--name-only", "-z", "--cached", "HEAD", "--", "."])
                return "".join(name + "\0" for name in self.staged_changes)
            self.assertEqual(command, ["git", "diff", "--no-ext-diff", "--no-textconv",
                                       "--name-only", "-z", "HEAD", "--", "."])
            return "".join(name + "\0" for name in self.changes)
        self.run = patch.object(pilot, "run", side_effect=git_output).start()
        patch.object(pilot.subprocess, "Popen", side_effect=AssertionError("No fixture subprocess")).start()

    def baseline(self):
        pilot.capture_generated_checkout(self.workspace, self.state)
        self.file.write_bytes(self.new)
        self.changes = [self.name]
        return pilot.capture_generated_baseline(self.workspace, self.state, "graph-pin", "lock-pin")

    def configured(self):
        generated = self.baseline()
        before = {"graph_sha256": "graph-pin", "lock_sha256": "lock-pin", "generated_files": generated}
        pubspec = self.workspace / pilot.APP / "pubspec.yaml"
        pubspec.write_text("source-mode fixture\n")
        pubspec.chmod(0o644)
        self.changes.append(f"{pilot.APP}/pubspec.yaml")
        return before, {"pubspec_after_sha256": pilot.sha(pubspec)}

    def test_generated_checkout_and_resolution_are_recorded_separately(self):
        before = self.baseline()
        self.assertEqual(before["stage"], "after-initial-pub-get-before-source-configuration")
        self.assertEqual(before["checkout"], pilot.expected_generated("tracked"))
        self.assertEqual(before["resolved"], pilot.expected_generated("resolved"))
        self.assertEqual((before["graph_sha256"], before["lock_sha256"]), ("graph-pin", "lock-pin"))

    def test_generated_initial_checkout_rejects_unexpected_tracked_change(self):
        self.changes = ["unexpected.dart"]
        with self.assertRaisesRegex(pilot.Rejected, "^initial-tracked-drift$"):
            pilot.capture_generated_checkout(self.workspace, self.state)

    def test_generated_tracked_blob_and_mode_are_pinned(self):
        for tree in (self.tree.replace("100644", "100755"), self.tree.replace(pilot.blob(self.old), "0" * 40)):
            self.tree = tree
            with self.assertRaisesRegex(pilot.Rejected, "^generated-head-preimage$"):
                pilot.check_generated_head(self.workspace)

    def test_generated_symlink_is_rejected(self):
        target = self.workspace / "target"
        target.write_bytes(self.old)
        self.file.unlink()
        self.file.symlink_to(target)
        with self.assertRaisesRegex(pilot.Rejected, "^generated-file-type$"):
            pilot.generated_files(self.workspace, "tracked")

    def test_generated_executable_mode_is_rejected(self):
        self.file.chmod(0o755)
        with self.assertRaisesRegex(pilot.Rejected, "^generated-file-type$"):
            pilot.generated_files(self.workspace, "tracked")

    def test_generated_oversized_file_is_rejected_before_read(self):
        with patch.object(pilot, "MAX_GENERATED_FILE", 2):
            with self.assertRaisesRegex(pilot.Rejected, "^generated-file-size$"):
                pilot.generated_files(self.workspace, "tracked")

    def test_generated_unknown_resolution_output_is_rejected(self):
        pilot.capture_generated_checkout(self.workspace, self.state)
        self.file.write_bytes(b"different generator output\n")
        self.changes = [self.name]
        with self.assertRaisesRegex(pilot.Rejected, "^generated-file-content$"):
            pilot.capture_generated_baseline(self.workspace, self.state, "graph-pin", "lock-pin")

    def test_generated_resolution_rejects_other_tracked_mutations(self):
        pilot.capture_generated_checkout(self.workspace, self.state)
        self.file.write_bytes(self.new)
        self.changes = [self.name, "unexpected.dart"]
        with self.assertRaisesRegex(pilot.Rejected, "^initial-resolution-tracked-drift$"):
            pilot.capture_generated_baseline(self.workspace, self.state, "graph-pin", "lock-pin")

    def test_generated_resolution_requires_original_checkout_record(self):
        pilot.capture_generated_checkout(self.workspace, self.state)
        (self.state / "generated-checkout.json").write_text('{}')
        with self.assertRaisesRegex(pilot.Rejected, "^generated-checkout-record$"):
            pilot.capture_generated_baseline(self.workspace, self.state, "graph-pin", "lock-pin")

    def test_generated_final_guard_accepts_only_exact_pinned_changes(self):
        before, source = self.configured()
        pilot.guard_generated_source(self.workspace, before, source)

    def test_generated_final_guard_rejects_later_content_drift(self):
        before, source = self.configured()
        self.file.write_bytes(b"later mutation\n")
        with self.assertRaisesRegex(pilot.Rejected, "^generated-file-content$"):
            pilot.guard_generated_source(self.workspace, before, source)

    def test_generated_final_guard_rejects_later_executable_mode(self):
        before, source = self.configured()
        self.file.chmod(0o755)
        with self.assertRaisesRegex(pilot.Rejected, "^generated-file-type$"):
            pilot.guard_generated_source(self.workspace, before, source)

    def test_generated_final_guard_rejects_baseline_graph_or_lock_tampering(self):
        before, source = self.configured()
        for key in ("graph_sha256", "lock_sha256"):
            with patch.dict(before["generated_files"], {key: "different"}):
                with self.assertRaisesRegex(pilot.Rejected, "^generated-baseline-record$"):
                    pilot.guard_generated_source(self.workspace, before, source)

    def test_generated_final_guard_rejects_other_tracked_mutations(self):
        before, source = self.configured()
        self.changes.append("unexpected.dart")
        with self.assertRaisesRegex(pilot.Rejected, "^unexpected-tracked-drift$"):
            pilot.guard_generated_source(self.workspace, before, source)

    def test_generated_final_guard_rejects_staged_mutation_even_with_matching_worktree(self):
        before, source = self.configured()
        self.staged_changes = [self.name]
        with self.assertRaisesRegex(pilot.Rejected, "^staged-source-drift$"):
            pilot.guard_generated_source(self.workspace, before, source)

    def test_generated_final_guard_rejects_configuration_mode_change(self):
        before, source = self.configured()
        (self.workspace / pilot.APP / "pubspec.yaml").chmod(0o755)
        with self.assertRaisesRegex(pilot.Rejected, "^configuration-type$"):
            pilot.guard_generated_source(self.workspace, before, source)

    def test_generated_final_guard_rejects_unexpected_configuration_bytes(self):
        before, source = self.configured()
        (self.workspace / pilot.APP / "pubspec.yaml").write_text("other config\n")
        with self.assertRaisesRegex(pilot.Rejected, "^configuration-drift$"):
            pilot.guard_generated_source(self.workspace, before, source)

    def test_generated_tracked_change_names_are_nul_delimited_without_duplicates(self):
        for output in ("missing-terminator", "duplicate\0duplicate\0"):
            with patch.object(pilot, "run", side_effect=["", output]):
                with self.assertRaisesRegex(pilot.Rejected, "^tracked-change-format$"):
                    pilot.tracked_changes(self.workspace)


if __name__ == "__main__":
    unittest.main()
