"""Bounded CI-only SQLite source pilot. No automatic binary fallback.

The archive is an untrusted transport envelope, not an authenticated artifact.
Only the directly pinned sqlite3.c bytes may leave memory or reach a compiler.
"""
import hashlib
import io
import json
import os
from pathlib import Path
import re
import select
import shlex
import shutil
import signal
import ssl
import stat
import subprocess
import sys
import tempfile
import time
import urllib.error
import urllib.parse
import urllib.request
import zipfile

URL = "https://sqlite.org/2026/sqlite-amalgamation-3530400.zip"
SOURCE_SHA3 = "67f423e9ebbbdc473cbc4772c872ee6b89f31fde4ed0279a5c25d5f65c043a16"
SOURCE_ID = "2026-07-24 19:02:57 bf7c7f30031888f4e796e429ab3978879485813aaca6f641c7b33e4e09459bcc"
MEMBER = "sqlite-amalgamation-3530400/sqlite3.c"
MAX_ARCHIVE = 8 * 1024 * 1024
MAX_SOURCE = 16 * 1024 * 1024
MAX_COMMAND_OUTPUT = 4 * 1024 * 1024
COMMAND_TIMEOUT = 30
COMMAND_CLEANUP_TIMEOUT = 5
APP = "apps/primecare_clinic"
PREIMAGES = {
    f"{APP}/pubspec.yaml": "526a535a32b24956e3a4d598ceb9cd4da7418516",
    f"{APP}/test/auth_routing_test.dart": "ff689f39721e2d2c458d6d1f4089aaf5a08172f0",
}
# Exact original/generated identities reconstructed from GitHub run 42473442695.
# These five outputs are checked, never restored or broadly excluded.
GENERATED_PINS = {'apps/primecare_clinic/ios/Runner/GeneratedPluginRegistrant.m': {'tracked': {'bytes': 5022,
                                                                              'git_blob_sha1': 'dab3f2bddeb185ced499624a866cf5ce33dc8f08',
                                                                              'sha256': 'cc8c323265e0c4d6a49b1aa1bdd6b7ad96f03cedf3c0180d81322bbd84eef80a'},
                                                                  'resolved': {'bytes': 5010,
                                                                               'git_blob_sha1': '1dec1dad0e9879ac16c27b45bb912788fd16fbaf',
                                                                               'sha256': '95e8568b5a7d74372bc6777b2fa672bd288116f6d15974896996ccf3e8cfa051'}},
 'apps/primecare_clinic/linux/flutter/generated_plugin_registrant.cc': {'tracked': {'bytes': 1217,
                                                                                    'git_blob_sha1': '5f3ef8516e64d6722545b09c7bc62be0233f0fea',
                                                                                    'sha256': 'b3b1a3333be2553bcd41784c6fe3ca4cd03d8bcebb88222dbd7669bbc574f5a0'},
                                                                        'resolved': {'bytes': 1496,
                                                                                     'git_blob_sha1': 'a1d4325dd8588c6b592e40dde6f37abd60e9cf0e',
                                                                                     'sha256': '62606a70c31d260baf33ddf8c26180790f64326def916884cd5de25d77455380'}},
 'apps/primecare_clinic/linux/flutter/generated_plugins.cmake': {'tracked': {'bytes': 814,
                                                                             'git_blob_sha1': '51541247aeb0a02d6658be7efd4493ac5d3f1eb8',
                                                                             'sha256': '3583bd8d4a5382e2f502df38e4b1137b2840ead9cc9713a81d12a13b55e7e196'},
                                                                 'resolved': {'bytes': 836,
                                                                              'git_blob_sha1': 'e22c77970463e6e7c63df364f43001bf75741df4',
                                                                              'sha256': 'a9b628a624dac71550301eb24bb021f1212d8d3c615976824605869472877a5c'}},
 'apps/primecare_clinic/windows/flutter/generated_plugin_registrant.cc': {'tracked': {'bytes': 1167,
                                                                                      'git_blob_sha1': '91d8b7dd8ed2b7e03f8bbec877165a698767707c',
                                                                                      'sha256': '2ffe2cfe8a8fa50a54d64c129d179ba155b9944298a460fec6ddc498a47c20b9'},
                                                                          'resolved': {'bytes': 1331,
                                                                                       'git_blob_sha1': '0cee578ef15adb1902c42be9b438ca105d3e16ce',
                                                                                       'sha256': 'db2f9031d4b57c5864d938d2c13c5a1af09c72d1dee3ec7c0f0b92b6c7946705'}},
 'apps/primecare_clinic/windows/flutter/generated_plugins.cmake': {'tracked': {'bytes': 869,
                                                                               'git_blob_sha1': 'b8281a9884a7768a6d6d3e3939b3f4ca43ea8e96',
                                                                               'sha256': 'e4fc586e95fe18328878b25b7d630a53e2b6ae26c036728b1864d139794e4297'},
                                                                   'resolved': {'bytes': 893,
                                                                                'git_blob_sha1': 'd4d1f7d86f17a960e7ff72c89cca474d3a274ee3',
                                                                                'sha256': 'efbf9204fb94b907c87d2ef5aab049e3367649dff2039350db0f4b7236ecf675'}}}
MAX_GENERATED_FILE = 16 * 1024

HOOK_PREIMAGES = {
    "hook/build.dart": "7df76a598b3eec21fad1313a963de0c8771d4155",
    "lib/src/hook/compile/description.dart": "56339a7b7d7b190bbce3d364b649481c547a85c2",
    "lib/src/hook/compile/used_symbols.dart": "309788168db6528ec3e97533ae0e841de774472e",
}
SELECTOR = "packages/flutter_tools/lib/src/isolated/native_assets/linux/native_assets.dart"
SELECTOR_BLOB = "4e1b82dd2558a4a5dd2828889b3c0a9ba13a271f"
TOOLCHAIN_ENV = (
    "CC CXX AR LD CFLAGS CPPFLAGS CXXFLAGS LDFLAGS CPATH C_INCLUDE_PATH "
    "CPLUS_INCLUDE_PATH LIBRARY_PATH COMPILER_PATH GCC_EXEC_PREFIX "
    "LD_PRELOAD LD_LIBRARY_PATH SDKROOT SYSROOT"
).split()
DRIVER_ENV = (
    "CLANG_CONFIG_FILE_USER_DIR CLANG_CONFIG_FILE_SYSTEM_DIR CLANG_CONFIG_FILE "
    "CLANG_NO_DEFAULT_CONFIG CCC_OVERRIDE_OPTIONS CCC_ADD_ARGS CL _CL_ "
    "CC_PRINT_OPTIONS CC_PRINT_OPTIONS_FILE CC_PRINT_HEADERS CC_PRINT_HEADERS_FILE "
    "CC_PRINT_HEADERS_FORMAT CC_PRINT_HEADERS_FILTERING CC_PRINT_PROC_STAT "
    "CC_PRINT_PROC_STAT_FILE FORCE_CLANG_DIAGNOSTICS_CRASH CLANG_CRASH_DIAGNOSTICS_DIR"
).split()


class Rejected(Exception):
    """Only fixed, developer-authored reason codes reach CI logs."""


def require(condition, reason):
    if not condition:
        raise Rejected(reason)


def blob(data):
    return hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def bounded_read(stream, limit):
    data = stream.read(limit + 1)
    require(len(data) <= limit, "byte-limit")
    return data


def reject_url_controls(url):
    # urlsplit/urljoin normalize some raw C0 characters. Reject before parsing.
    require(isinstance(url, str) and not any(
        ord(character) <= 0x20 or 0x7f <= ord(character) <= 0x9f
        for character in url
    ), "url-control")


def allowed_url(url):
    reject_url_controls(url)
    parsed = urllib.parse.urlsplit(url)
    require(
        parsed.scheme == "https"
        and parsed.netloc in {"sqlite.org", "www.sqlite.org"}
        and parsed.path == "/2026/sqlite-amalgamation-3530400.zip"
        and not parsed.query and not parsed.fragment,
        "redirect-target",
    )


class NoRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, req, fp, code, msg, headers, newurl):
        return None


def fetch_archive(opener):
    url = URL
    for redirects in range(3):
        allowed_url(url)
        request = urllib.request.Request(url, headers={
            "User-Agent": "PrimeCare-SQLite-source-pilot/1",
            "Accept": "application/zip", "Accept-Encoding": "identity",
        })
        try:
            response = opener.open(request, timeout=12)
        except urllib.error.HTTPError as error:
            response = error
        with response:
            if response.status in {301, 302, 303, 307, 308}:
                require(redirects < 2, "redirect-limit")
                location = response.headers.get("Location")
                require(isinstance(location, str) and len(location) <= 256, "redirect-location")
                reject_url_controls(location)
                url = urllib.parse.urljoin(url, location)
                allowed_url(url)
                continue
            require(response.status == 200, "http-status")
            allowed_url(response.geturl())
            mime = response.headers.get_content_type()
            require(mime in {"application/zip", "application/octet-stream", "application/x-zip-compressed"}, "content-type")
            require(response.headers.get("Content-Encoding", "identity") == "identity", "content-encoding")
            length = response.headers.get("Content-Length")
            if length is not None:
                require(re.fullmatch(r"[0-9]{1,8}", length) is not None, "content-length")
                require(int(length) <= MAX_ARCHIVE, "byte-limit")
            data = bounded_read(response, MAX_ARCHIVE)
            if length is not None:
                require(len(data) == int(length), "truncated-body")
            return data
    raise Rejected("redirect-limit")


def verified_source(archive):
    require(0 < len(archive) <= MAX_ARCHIVE, "archive-size")
    with zipfile.ZipFile(io.BytesIO(archive)) as package:
        members = package.infolist()
        require(1 <= len(members) <= 8, "member-count")
        names = set()
        total = 0
        for item in members:
            name = item.filename
            require(name not in names, "duplicate-member")
            names.add(name)
            require(item.orig_filename == name, "member-name")
            require(name in {
                "sqlite-amalgamation-3530400/", MEMBER,
                "sqlite-amalgamation-3530400/sqlite3.h",
                "sqlite-amalgamation-3530400/sqlite3ext.h",
                "sqlite-amalgamation-3530400/shell.c",
            }, "member-name")
            mode = stat.S_IFMT(item.external_attr >> 16)
            require(mode in {0, stat.S_IFREG, stat.S_IFDIR}, "member-type")
            require(not item.flag_bits & 1, "encrypted-member")
            require(item.compress_type in {zipfile.ZIP_STORED, zipfile.ZIP_DEFLATED}, "compression")
            require(0 <= item.file_size <= MAX_SOURCE, "member-size")
            total += item.file_size
        require(total <= 24 * 1024 * 1024 and MEMBER in names, "archive-members")
        item = package.getinfo(MEMBER)
        require(not item.is_dir() and stat.S_IFMT(item.external_attr >> 16) in {0, stat.S_IFREG}, "source-type")
        with package.open(item) as source:
            data = bounded_read(source, MAX_SOURCE)
        require(len(data) == item.file_size, "source-size")
    require(hashlib.sha3_256(data).hexdigest() == SOURCE_SHA3, "source-hash")
    require(re.search(rb'^#define SQLITE_SOURCE_ID\s+"' + re.escape(SOURCE_ID.encode()) + rb'"\s*$', data, re.M) is not None, "source-id")
    return data


def output_json(path, value):
    with path.open("x", encoding="utf-8") as output:
        json.dump(value, output, indent=2, sort_keys=True)
        output.write("\n")


def read_json(path):
    require(path.is_file() and not path.is_symlink() and path.stat().st_size <= 4 * 1024 * 1024, "metadata-file")
    return json.loads(path.read_text())


def run(command, cwd=None):
    # Linux only. Drain at most cap+1 bytes, then kill the owned process group.
    # No shell, stderr capture, raw arguments, environment or exception logging.
    process = None
    reaped = False
    try:
        process = subprocess.Popen(command, cwd=cwd, stdin=subprocess.DEVNULL,
                                   stdout=subprocess.PIPE, stderr=subprocess.DEVNULL,
                                   start_new_session=True)
        deadline = time.monotonic() + COMMAND_TIMEOUT
        output = bytearray()
        descriptor = process.stdout.fileno()
        while True:
            remaining = deadline - time.monotonic()
            require(remaining > 0, "prerequisite-timeout")
            ready, _, _ = select.select([descriptor], [], [], remaining)
            if not ready:
                continue
            chunk = os.read(descriptor, min(65536, MAX_COMMAND_OUTPUT + 1 - len(output)))
            if not chunk:
                break
            output.extend(chunk)
            require(len(output) <= MAX_COMMAND_OUTPUT, "prerequisite-output")
        remaining = deadline - time.monotonic()
        require(remaining > 0, "prerequisite-timeout")
        result = process.wait(timeout=remaining)
        reaped = True
        require(result == 0, "prerequisite-command")
        return output.decode("utf-8")
    except subprocess.TimeoutExpired:
        raise Rejected("prerequisite-timeout") from None
    except (OSError, UnicodeError):
        raise Rejected("prerequisite-command") from None
    finally:
        if process is not None:
            try:
                if not reaped:
                    try:
                        os.killpg(process.pid, signal.SIGKILL)
                    except ProcessLookupError:
                        pass
                    process.wait(timeout=COMMAND_CLEANUP_TIMEOUT)
            except (OSError, subprocess.TimeoutExpired):
                raise Rejected("prerequisite-cleanup") from None
            finally:
                process.stdout.close()


def owned_paths():
    temporary = Path(os.environ["RUNNER_TEMP"]).resolve(strict=True)
    state = temporary / "sqlite-source-pilot-state"
    cache = temporary / "sqlite-source-pilot-pub"
    require(os.environ.get("PILOT_STATE") == str(state), "state-directory")
    require(os.environ.get("PUB_CACHE") == str(cache), "cache-environment")
    return state, cache


def directory_identity(path):
    info = path.lstat()
    require(stat.S_ISDIR(info.st_mode) and not path.is_symlink()
            and path.resolve(strict=True) == path, "owned-directory")
    return {"path": str(path), "device": info.st_dev, "inode": info.st_ino}


def initialize():
    state, cache = owned_paths()
    require(not os.path.lexists(state) and not os.path.lexists(cache), "existing-pilot-directory")
    state.mkdir(mode=0o700)
    cache.mkdir(mode=0o700)
    require(not any(cache.iterdir()), "nonempty-initial-cache")
    output_json(state / "ownership.json", {
        "state": directory_identity(state), "cache": directory_identity(cache),
        "cache_created_empty": True,
    })


def check_owned_cache():
    state, cache = owned_paths()
    # Reject symlinks before reading the ownership record.
    current_state = directory_identity(state)
    current_cache = directory_identity(cache)
    ownership = read_json(state / "ownership.json")
    require(ownership == {"state": current_state, "cache": current_cache,
                          "cache_created_empty": True}, "cache-ownership")
    return cache


def expected_generated(phase):
    return {path: {**pins[phase], "mode": "100644"}
            for path, pins in GENERATED_PINS.items()}


def generated_files(workspace, phase):
    records = {}
    for name in GENERATED_PINS:
        path = workspace / name
        info = path.lstat()
        require(stat.S_ISREG(info.st_mode) and stat.S_IMODE(info.st_mode) == 0o644
                and path.resolve(strict=True) == path, "generated-file-type")
        require(info.st_size <= MAX_GENERATED_FILE, "generated-file-size")
        with path.open("rb") as stream:
            data = bounded_read(stream, MAX_GENERATED_FILE)
        records[name] = {"bytes": len(data), "sha256": hashlib.sha256(data).hexdigest(),
                         "git_blob_sha1": blob(data), "mode": "100644"}
    require(records == expected_generated(phase), "generated-file-content")
    return records


def check_generated_head(workspace):
    output = run(["git", "ls-tree", "-z", "-r", "HEAD", "--", *GENERATED_PINS], cwd=workspace)
    expected = {"100644 blob " + pins["tracked"]["git_blob_sha1"] + "\t" + path
                for path, pins in GENERATED_PINS.items()}
    entries = output.split("\0")
    require(entries[-1] == "" and len(entries) == len(expected) + 1
            and set(entries[:-1]) == expected, "generated-head-preimage")


def tracked_changes(workspace):
    require(run(["git", "diff", "--no-ext-diff", "--no-textconv", "--name-only",
                 "-z", "--cached", "HEAD", "--", "."], cwd=workspace) == "", "staged-source-drift")
    output = run(["git", "diff", "--no-ext-diff", "--no-textconv", "--name-only",
                  "-z", "HEAD", "--", "."], cwd=workspace)
    if not output:
        return set()
    entries = output.split("\0")
    require(entries[-1] == "" and len(entries) <= 1025
            and len(set(entries[:-1])) == len(entries) - 1, "tracked-change-format")
    return set(entries[:-1])


def capture_generated_checkout(workspace, state):
    check_generated_head(workspace)
    require(not tracked_changes(workspace), "initial-tracked-drift")
    output_json(state / "generated-checkout.json", {
        "stage": "before-initial-pub-get",
        "files": generated_files(workspace, "tracked"),
    })


def capture_generated_baseline(workspace, state, graph_sha256, lock_sha256):
    checkout = read_json(state / "generated-checkout.json")
    require(checkout == {"stage": "before-initial-pub-get",
                         "files": expected_generated("tracked")}, "generated-checkout-record")
    check_generated_head(workspace)
    require(tracked_changes(workspace) == set(GENERATED_PINS), "initial-resolution-tracked-drift")
    return {
        "stage": "after-initial-pub-get-before-source-configuration",
        "checkout": checkout["files"], "resolved": generated_files(workspace, "resolved"),
        "graph_sha256": graph_sha256, "lock_sha256": lock_sha256,
    }


def guard_generated_source(workspace, before, source):
    expected = {
        "stage": "after-initial-pub-get-before-source-configuration",
        "checkout": expected_generated("tracked"), "resolved": expected_generated("resolved"),
        "graph_sha256": before["graph_sha256"], "lock_sha256": before["lock_sha256"],
    }
    require(before["generated_files"] == expected, "generated-baseline-record")
    check_generated_head(workspace)
    require(generated_files(workspace, "resolved") == before["generated_files"]["resolved"],
            "generated-file-drift")
    pubspec = workspace / APP / "pubspec.yaml"
    info = pubspec.lstat()
    require(stat.S_ISREG(info.st_mode) and stat.S_IMODE(info.st_mode) == 0o644
            and pubspec.resolve(strict=True) == pubspec, "configuration-type")
    require(sha(pubspec) == source["pubspec_after_sha256"], "configuration-drift")
    require(tracked_changes(workspace) == {*GENERATED_PINS, f"{APP}/pubspec.yaml"},
            "unexpected-tracked-drift")


def graph_identity(path):
    graph = read_json(path)
    packages = graph["packages"]
    require(len(packages) <= 1000, "package-count")
    by_name = {entry["name"]: entry for entry in packages}
    require(len(by_name) == len(packages), "duplicate-package")
    require(by_name["sqlite3"]["version"] == "3.5.2", "sqlite-version")
    require("sqlite3" in by_name["drift"]["dependencies"], "drift-graph")
    # Preserve the entire resolved graph, not just SQLite/version equality.
    return hashlib.sha256(json.dumps(graph, sort_keys=True, separators=(",", ":")).encode()).hexdigest()


def package_roots(app):
    config_file = app / ".dart_tool/package_config.json"
    config = read_json(config_file)
    roots = {}
    for entry in config["packages"]:
        uri = urllib.parse.urljoin(config_file.as_uri(), entry["rootUri"])
        parsed = urllib.parse.urlsplit(uri)
        require(parsed.scheme == "file" and parsed.netloc == "" and not parsed.query and not parsed.fragment, "package-uri")
        roots[entry["name"]] = Path(urllib.parse.unquote(parsed.path)).resolve(strict=True)
    return roots


def package_file_identity(roots):
    result = {}
    for name, root in roots.items():
        result[name] = {"root": str(root), "pubspec_sha256": sha(root / "pubspec.yaml")}
    return result


def check_hook(roots):
    root = roots["sqlite3"]
    cache = check_owned_cache()
    require(root == cache / "hosted/pub.dev/sqlite3-3.5.2", "sqlite-package-root")
    for path, expected in HOOK_PREIMAGES.items():
        require(blob((root / path).read_bytes()) == expected, "hook-preimage")


def reject_toolchain_environment():
    require(not any(os.environ.get(key) for key in TOOLCHAIN_ENV), "injected-toolchain")
    require(not any(key in os.environ for key in DRIVER_ENV), "injected-driver")


def tool_paths():
    reject_toolchain_environment()
    selected = shutil.which("clang++")
    require(selected is not None, "missing-clang")
    directory = Path(selected).resolve(strict=True).parent
    paths = {"clang++": directory / "clang++", "shell": Path("/bin/sh")}
    for key, options in {"compiler": ["clang"], "archiver": ["llvm-ar", "ar"], "linker": ["ld.lld", "ld"]}.items():
        candidates = [directory / name for name in options if (directory / name).is_file()]
        require(bool(candidates), "missing-tool")
        paths[key] = candidates[0]
    for path in paths.values():
        require(str(path.resolve(strict=True)).startswith("/usr/") and os.access(path, os.X_OK), "unexpected-tool-path")
    return paths


def system_file_owners(paths):
    owners = set()
    for path in paths:
        real = path.resolve(strict=True)
        require(str(real).startswith(("/usr/include/", "/usr/lib/", "/usr/bin/")), "unexpected-system-path")
        output = run(["dpkg-query", "-S", str(real)])
        matches = [line.rsplit(": ", 1)[0] for line in output.splitlines() if line.endswith(": " + str(real))]
        require(len(matches) == 1 and re.fullmatch(r"[a-z0-9.+:-]+", matches[0]), "unowned-system-file")
        owners.add(matches[0])
    for owner in sorted(owners):
        require(run(["dpkg", "--verify", owner]) == "", "system-package-integrity")
    return {owner: run(["dpkg-query", "-W", "-f=${Version}", owner]).strip() for owner in sorted(owners)}


def launcher_bytes(target):
    require(target.is_absolute() and str(target).startswith("/usr/")
            and ".." not in target.parts
            and re.fullmatch(r"/usr/[A-Za-z0-9_./+-]+", str(target)) is not None, "launcher-target")
    # Fixed target, no target/environment/PATH expansion, eval, or extra logic.
    return ("#!/bin/sh\nexec '" + str(target)
            + "' --no-default-config \"$@\"\n").encode()


def create_launchers(state, system_paths):
    directory = state / "compiler"
    directory.mkdir(mode=0o700)
    hashes = {}
    selected = {}
    for name, key in (("clang", "compiler"), ("clang++", "clang++")):
        path = directory / name
        data = launcher_bytes(system_paths[key])
        with path.open("xb") as output:
            output.write(data)
        path.chmod(0o500)
        hashes[str(path)] = hashlib.sha256(data).hexdigest()
        selected[key] = str(path)
    siblings = {}
    for key in ("archiver", "linker"):
        target = system_paths[key]
        (directory / target.name).symlink_to(target)
        siblings[target.name] = str(target)
        selected[key] = str(target.resolve(strict=True))
    return {"tools": selected, "launcher_sha256": hashes,
            "launcher_siblings": siblings, "launcher_directory": directory_identity(directory)}


def check_launchers(before, state):
    reject_toolchain_environment()
    directory = state / "compiler"
    require(directory_identity(directory) == before["launcher_directory"], "launcher-directory")
    expected_members = {"clang", "clang++", *before["launcher_siblings"]}
    require({path.name for path in directory.iterdir()} == expected_members, "launcher-members")
    for key, target in before["system_tools"].items():
        path = Path(target)
        require(str(path.resolve(strict=True)) == before["system_tool_realpaths"][key]
                and sha(path) == before["system_tool_sha256"][key], "system-tool-drift")
    for name, key in (("clang", "compiler"), ("clang++", "clang++")):
        path = directory / name
        require(stat.S_ISREG(path.lstat().st_mode) and stat.S_IMODE(path.stat().st_mode) == 0o500,
                "launcher-type")
        require(path.read_bytes() == launcher_bytes(Path(before["system_tools"][key]))
                and sha(path) == before["launcher_sha256"][str(path)], "launcher-drift")
    for name, target in before["launcher_siblings"].items():
        path = directory / name
        require(path.is_symlink() and path.readlink() == Path(target), "launcher-sibling")
    selected = shutil.which("clang++")
    require(selected == str(directory / "clang++"), "launcher-selection")
    # Match Flutter's pinned selector: clang++ real directory, then sibling tools.
    require(str(Path(selected).resolve(strict=True)) == before["tools"]["clang++"], "launcher-selection")
    for key, names in {"compiler": ["clang"], "archiver": ["llvm-ar", "ar"], "linker": ["ld.lld", "ld"]}.items():
        candidates = [directory / name for name in names if (directory / name).is_file()]
        require(bool(candidates) and str(candidates[0].resolve(strict=True)) == before["tools"][key],
                "launcher-selection")


def preflight(workspace, state, graph):
    require(os.environ.get("GITHUB_ACTIONS") == "true" and os.environ.get("RUNNER_OS") == "Linux" and os.environ.get("RUNNER_ARCH") == "X64", "ci-platform")
    for path, expected in PREIMAGES.items():
        require(blob((workspace / path).read_bytes()) == expected, "app-preimage")
    app = workspace / APP
    require(not (app / "pubspec_overrides.yaml").exists(), "dependency-overrides")
    require(not (app / ".dart_tool/hooks_runner").exists(), "existing-hook-cache")
    require(not (app / "build/native_assets").exists(), "existing-native-assets")
    graph_sha256 = graph_identity(graph)
    lock_sha256 = sha(app / "pubspec.lock")
    generated = capture_generated_baseline(workspace, state, graph_sha256, lock_sha256)
    roots = package_roots(app)
    check_hook(roots)
    flutter = Path(shutil.which("flutter")).resolve(strict=True).parent.parent
    require(blob((flutter / SELECTOR).read_bytes()) == SELECTOR_BLOB, "flutter-selector-preimage")
    paths = tool_paths()
    packages = system_file_owners(paths.values())
    launchers = create_launchers(state, paths)
    snapshot = {
        "graph_sha256": graph_sha256, "lock_sha256": lock_sha256,
        "generated_files": generated,
        "packages": package_file_identity(roots),
        "system_tools": {name: str(path) for name, path in paths.items()},
        "system_tool_realpaths": {name: str(path.resolve(strict=True)) for name, path in paths.items()},
        "system_tool_sha256": {name: sha(path) for name, path in paths.items()},
        "system_packages": packages,
        **launchers,
        "runner_image": {key: os.environ.get(key, "unknown") for key in ("ImageOS", "ImageVersion")},
    }
    output_json(state / "before.json", snapshot)


def prepare(workspace, state):
    check_owned_cache()
    before = read_json(state / "before.json")
    # The live fetch/configuration must start from the measured resolved baseline.
    require(capture_generated_baseline(workspace, state, before["graph_sha256"],
                                       before["lock_sha256"]) == before["generated_files"],
            "generated-baseline-drift")
    check_launchers(before, state)
    def expired(signum, frame):
        raise Rejected("overall-timeout")
    previous = signal.signal(signal.SIGALRM, expired)
    signal.alarm(45)
    try:
        # Default ProxyHandler retains configured proxy/NO_PROXY behavior.
        opener = urllib.request.build_opener(urllib.request.ProxyHandler(), NoRedirect(),
                                            urllib.request.HTTPSHandler(context=ssl.create_default_context()))
        source = verified_source(fetch_archive(opener))
    finally:
        signal.alarm(0)
        signal.signal(signal.SIGALRM, previous)
    source_dir = Path(tempfile.mkdtemp(prefix="sqlite-verified-", dir=state))
    source_path = source_dir / "sqlite3.c"
    with source_path.open("xb") as output:
        output.write(source)
    source_path.chmod(0o444)
    roots = package_roots(workspace / APP)
    description = (roots["sqlite3"] / "lib/src/hook/compile/description.dart").read_text()
    match = re.search(r"const _defaultDefines = '''\n(.*?)\n''';", description, re.S)
    require(match is not None, "default-defines")
    defines = match.group(1).split()
    require(all(re.fullmatch(r"SQLITE_[A-Z0-9_]+(?:=[0-9]+)?", item) for item in defines), "default-defines")
    compiler = before["tools"]["compiler"]
    # Preprocessing only: enumerate every real header before native compilation.
    # The same fixed launcher also protects the hook's recognizer --version calls.
    check_launchers(before, state)
    deps = run([compiler, "-M", "-MT", "sqlite-pilot", "-x", "c", "-fPIC",
                *["-D" + value for value in defines], str(source_path)])
    require(deps.startswith("sqlite-pilot:"), "header-dependencies")
    headers = [Path(value) for value in shlex.split(deps.split(":", 1)[1].replace("\\\n", " "))]
    require(source_path in headers and 1 <= len(headers) <= 512, "header-dependencies")
    headers = [path for path in headers if path != source_path]
    packages = system_file_owners(headers)
    manifest = {
        "source_path": str(source_path), "source_sha3_256": SOURCE_SHA3,
        "source_id": SOURCE_ID, "default_defines": defines,
        "compiler_launcher_disables_default_configs": True,
        "header_sha256": {str(path.resolve(strict=True)): sha(path) for path in headers},
        "header_packages": packages,
    }
    pubspec = workspace / APP / "pubspec.yaml"
    original = pubspec.read_bytes()
    require(blob(original) == PREIMAGES[f"{APP}/pubspec.yaml"], "app-preimage")
    suffix = "\nhooks:\n  user_defines:\n    sqlite3:\n      source: source\n      path: " + json.dumps(str(source_path)) + "\n"
    manifest["pubspec_after_sha256"] = hashlib.sha256(original + suffix.encode()).hexdigest()
    output_json(state / "source.json", manifest)
    pubspec.write_bytes(original + suffix.encode())
    print("Verified SQLite C source; only the clinic CI checkout uses explicit source mode.")


def recheck(workspace, state, graph):
    check_owned_cache()
    before = read_json(state / "before.json")
    source = read_json(state / "source.json")
    app = workspace / APP
    require(sha(app / "pubspec.yaml") == source["pubspec_after_sha256"], "configuration-drift")
    require(blob((app / "test/auth_routing_test.dart").read_bytes()) == PREIMAGES[f"{APP}/test/auth_routing_test.dart"], "test-drift")
    require(sha(app / "pubspec.lock") == before["lock_sha256"], "lock-drift")
    require(graph_identity(graph) == before["graph_sha256"], "graph-drift")
    roots = package_roots(app)
    check_hook(roots)
    # Clinic's deliberate pubspec append is the sole package identity difference.
    identities = package_file_identity(roots)
    identities["primecare_clinic"] = before["packages"]["primecare_clinic"]
    require(identities == before["packages"], "package-drift")
    check_launchers(before, state)
    require(all(sha(Path(path)) == value for path, value in source["header_sha256"].items()), "header-drift")
    c_file = Path(source["source_path"])
    require(list(c_file.parent.iterdir()) == [c_file] and not c_file.is_symlink(), "source-directory")
    require(hashlib.sha3_256(c_file.read_bytes()).hexdigest() == SOURCE_SHA3, "source-drift")
    guard_generated_source(workspace, before, source)


def main():
    try:
        require(len(sys.argv) == 2 and sys.argv[1] in {"initialize", "cache-check", "checkout-check", "preflight", "prepare", "recheck", "source-guard"}, "usage")
        action = sys.argv[1]
        if action == "initialize":
            initialize()
            return 0
        check_owned_cache()
        if action == "cache-check":
            return 0
        workspace = Path(os.environ["GITHUB_WORKSPACE"]).resolve(strict=True)
        state = Path(os.environ["PILOT_STATE"]).resolve(strict=True)
        if action == "checkout-check":
            capture_generated_checkout(workspace, state)
        elif action == "preflight":
            preflight(workspace, state, state / "graph-before.json")
        elif action == "prepare":
            prepare(workspace, state)
        elif action == "source-guard":
            guard_generated_source(workspace, read_json(state / "before.json"),
                                   read_json(state / "source.json"))
            print("Verified tracked-source guard: five pinned plugin outputs regenerated before source configuration and unchanged afterward.")
        else:
            recheck(workspace, state, state / "graph-after.json")
    except Rejected as error:
        print("SQLite source pilot rejected: " + str(error), file=sys.stderr)
        return 1
    except Exception:
        print("SQLite source pilot rejected: unexpected-input-or-prerequisite", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
