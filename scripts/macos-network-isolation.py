"""Scoped CI packet filtering without nesting App Sandbox; fail closed and clean up."""
import grp
import json
import os
import pwd
import re
import secrets
import signal
import time
import socket
import subprocess
import sys
import threading
import uuid


class NetworkIsolation:
    def __init__(self):
        self.group = 'pcnet_' + uuid.uuid4().hex[:12]
        self.anchor = 'com.apple/' + self.group
        self.gid = None
        self.token = None
        self.created = False
        self.loaded = False
        self.verified = False

    @staticmethod
    def privileged(*args, **kwargs):
        return subprocess.run(['sudo', '-n', *args], check=True, capture_output=True, text=True, timeout=20, **kwargs)

    def command(self, command, environment):
        if not self.created:
            raise RuntimeError('Network isolation group is unavailable')
        # Enter the dedicated group via a tiny root bootstrap, then drop all
        # supplementary groups and root before exec. The runner sudo policy
        # need not permit an arbitrary run-as group for the runner account.
        bootstrap = 'import os,sys;os.setgroups([]);os.setgid(int(sys.argv[2]));os.setuid(int(sys.argv[1]));os.execv(sys.argv[3],sys.argv[3:])'
        return ['sudo', '-n', '/usr/bin/env', '-i', sys.executable, '-I', '-S', '-c', bootstrap,
                str(os.getuid()), str(self.gid), '/usr/bin/env', '-i',
                *[f'{key}={value}' for key, value in environment.items()], *command]


    def __enter__(self):
        if sys.platform != 'darwin' or os.getuid() == 0:
            raise RuntimeError('Non-root macOS Actions runner required')
        try:
            for _ in range(100):
                candidate = 40000 + secrets.randbelow(20000)
                try:
                    grp.getgrgid(candidate)
                except KeyError:
                    self.gid = candidate
                    break
            if self.gid is None:
                raise RuntimeError('No unused isolation group ID')
            self.privileged('/usr/sbin/dseditgroup', '-o', 'create', '-i', str(self.gid), self.group)
            self.created = True
            # Refuse to change the main ruleset or install an unreferenced anchor.
            rules = self.privileged('/sbin/pfctl', '-s', 'rules').stdout
            if 'anchor "com.apple/*"' not in rules:
                raise RuntimeError('Expected existing Apple wildcard filter anchor')
            self.verify_probes(blocked=False)
            policy = f'block drop out quick proto {{ tcp, udp }} all group {self.gid}\n'
            self.privileged('/sbin/pfctl', '-n', '-a', self.anchor, '-f', '-', input=policy)
            self.loaded = True
            self.privileged('/sbin/pfctl', '-a', self.anchor, '-f', '-', input=policy)
            enabled = self.privileged('/sbin/pfctl', '-E')
            match = re.search(r'Token\s*:\s*(\d+)', enabled.stdout + enabled.stderr)
            if not match:
                raise RuntimeError('PF enable reference token missing')
            self.token = match.group(1)
            if 'Status: Enabled' not in self.privileged('/sbin/pfctl', '-s', 'info').stdout:
                raise RuntimeError('Packet filtering did not enable')
            self.verify_probes(blocked=True)
            self.verified = True
            return self
        except BaseException:
            self.close()
            raise

    def verify_probes(self, blocked):
        environment = {'PATH': '/usr/bin:/bin:/usr/sbin:/sbin'}
        probe = '''import json,os,socket,sys
family=int(sys.argv[1]);kind=int(sys.argv[2]);host=sys.argv[3];port=int(sys.argv[4]);nonce=sys.argv[5].encode();s=socket.socket(family,kind);s.settimeout(1)
try:
 s.connect((host,port))
 if kind==socket.SOCK_DGRAM:
  s.send(nonce);ok=s.recv(128)==nonce
 else:ok=True
except OSError:ok=False
finally:s.close()
print(json.dumps({'uid':os.getuid(),'gid':os.getgid(),'connected':ok}))
'''
        # Real positive/negative loopback TCP+UDP probes cover IPv4 and IPv6.
        targets = []
        servers = []
        stop = threading.Event()
        try:
            for family, host in [(socket.AF_INET, '127.0.0.1'), (socket.AF_INET6, '::1')]:
                for kind in [socket.SOCK_STREAM, socket.SOCK_DGRAM]:
                    server = socket.socket(family, kind)
                    server.bind((host, 0))
                    server.settimeout(0.1)
                    if kind == socket.SOCK_STREAM:
                        server.listen(2)
                    servers.append(server)
                    def serve(sock=server, mode=kind):
                        while not stop.is_set():
                            try:
                                if mode == socket.SOCK_STREAM:
                                    connection, _ = sock.accept()
                                    connection.close()
                                else:
                                    payload, peer = sock.recvfrom(128)
                                    sock.sendto(payload, peer)
                            except (TimeoutError, OSError):
                                pass
                    threading.Thread(target=serve, daemon=True).start()
                    targets.append((family, kind, host, server.getsockname()[1]))
            targets.append((socket.AF_INET, socket.SOCK_STREAM, '1.1.1.1', 443))
            for family, kind, host, port in targets:
                result = subprocess.run(self.command([sys.executable, '-c', probe, str(family), str(kind), host, str(port), secrets.token_hex(8)], environment), check=False, capture_output=True, text=True, timeout=8)
                if result.returncode != 0:
                    raise RuntimeError('Probe child failed: ' + result.stderr[-2048:])
                value = json.loads(result.stdout)
                if value.get('uid') != os.getuid() or value.get('gid') != self.gid or value.get('connected') is not (not blocked):
                    raise RuntimeError(f'Network isolation probe failed: blocked={blocked}, family={family}, kind={kind}, host={host}, result={value}')
        finally:
            stop.set()
            for server in servers:
                server.close()

    def stop_children(self):
        if not self.created or self.gid is None:
            return
        def children():
            result = subprocess.run(['/bin/ps', '-axo', 'pid=,gid='], check=True, capture_output=True, text=True, timeout=5)
            return [int(parts[0]) for line in result.stdout.splitlines()
                    if len(parts := line.split()) == 2 and parts[1] == str(self.gid)]
        for sig in (signal.SIGTERM, signal.SIGKILL):
            for pid in children():
                try:
                    os.kill(pid, sig)
                except ProcessLookupError:
                    pass
            deadline = time.monotonic() + 2
            while children() and time.monotonic() < deadline:
                time.sleep(0.05)
        if children():
            # Keep the restriction installed if a child cannot be stopped.
            # The disposable Actions runner will then tear down the machine.
            raise RuntimeError('Isolated children remain; packet filter retained')

    def close(self):
        self.stop_children()
        errors = []
        for active, command in [
            (self.loaded, ('/sbin/pfctl', '-a', self.anchor, '-F', 'rules')),
            (self.token is not None, ('/sbin/pfctl', '-X', self.token or '')),
            (self.created, ('/usr/sbin/dseditgroup', '-o', 'delete', self.group))]:
            if active:
                try:
                    self.privileged(*command)
                except Exception as error:
                    errors.append(str(error))
        self.loaded = self.created = self.verified = False
        self.token = None
        if errors:
            raise RuntimeError('Network isolation cleanup failed: ' + '; '.join(errors))

    def __exit__(self, *_):
        self.close()
