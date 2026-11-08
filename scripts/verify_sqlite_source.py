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
    roots = package_roots(app)
    check_hook(roots)
    flutter = Path(shutil.which("flutter")).resolve(strict=True).parent.parent
    require(blob((flutter / SELECTOR).read_bytes()) == SELECTOR_BLOB, "flutter-selector-preimage")
    paths = tool_paths()
    packages = system_file_owners(paths.values())
    launchers = create_launchers(state, paths)
    snapshot = {
        "graph_sha256": graph_identity(graph), "lock_sha256": sha(app / "pubspec.lock"),
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


def main():
    try:
        require(len(sys.argv) == 2 and sys.argv[1] in {"initialize", "cache-check", "preflight", "prepare", "recheck"}, "usage")
        action = sys.argv[1]
        if action == "initialize":
            initialize()
            return 0
        check_owned_cache()
        if action == "cache-check":
            return 0
        workspace = Path(os.environ["GITHUB_WORKSPACE"]).resolve(strict=True)
        state = Path(os.environ["PILOT_STATE"]).resolve(strict=True)
        if action == "preflight":
            preflight(workspace, state, state / "graph-before.json")
        elif action == "prepare":
            prepare(workspace, state)
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
