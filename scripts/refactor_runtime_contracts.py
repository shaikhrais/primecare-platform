#!/usr/bin/env python3
"""Reproduce runtime contract and Flutter service separation from pinned source."""
import argparse
import json
import re
import subprocess
from pathlib import Path
from refactor_platform_governance import class_end
ROOT = Path(__file__).resolve().parents[1]
SOURCE = 'af61336bac522e2ab4a82cd61c562f2a57807258'
CORE = 'packages/flutter_core/lib/'
MODELS = 'packages/primecare_models/lib/src/models/'
MANIFEST = ROOT / 'docs/refactoring/runtime-contract-migration.json'
def original(path):
    return subprocess.check_output(['git', 'show', SOURCE + ':' + path], cwd=ROOT, text=True)
def take_class(source, name):
    match = re.search(r'(?m)^(?:///[^\n]*\n)*(?:sealed |abstract )?class ' + name + r'\b', source)
    assert match, name
    end = class_end(source, match.start())
    return match.start(), end, source[match.start():end]
def snake(name):
    return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()
def render():
    files = {}
    auth = original(CORE + 'auth_service.dart').replace("import 'package:flutter/foundation.dart';\n", '')
    start, end, state = take_class(auth, 'AuthState')
    ctor = state.index('  AuthState(')
    copy = state.index('  AuthState copyWith(')
    parent = state[:ctor].replace('class AuthState {', 'abstract class BaseAuthenticationState {') + state[ctor:copy].replace('  AuthState(', '  BaseAuthenticationState(') + '}\n'
    adapter_ctor = state[ctor:copy].replace('this.', 'super.')
    adapter_ctor = re.sub(r'(?m)^(    super\.\w+) = [^\n]+,', r'\1,', adapter_ctor)
    files[MODELS + 'base_authentication_state.dart'] = parent
    files[MODELS + 'auth_state.dart'] = "import 'base_authentication_state.dart';\n\nclass AuthState extends BaseAuthenticationState {\n" + adapter_ctor + state[copy:] + '\n'
    auth = auth[:start] + auth[end:]
    auth = auth.replace("import 'package:flutter_core/flutter_core.dart';", "import 'package:flutter_core/flutter_core.dart' hide AuthState;")
    start, end, notifier = take_class(auth, 'AuthNotifier')
    files[CORE + 'src/application/controllers/auth_notifier.dart'] = "part of '../../../auth_service.dart';\n\n" + notifier.rstrip() + '\n'
    auth = auth[:start] + auth[end:]
    files[CORE + 'auth_service.dart'] = auth[:auth.index('// Global listenable')] + "export 'package:primecare_models/src/models/auth_state.dart';\nimport 'package:primecare_models/src/models/auth_state.dart';\npart 'src/application/controllers/auth_notifier.dart';\n\n" + auth[auth.index('// Global listenable'):]

    result = original(CORE + 'src/resilience/result.dart')
    header = result[:take_class(result, 'Result')[0]]
    directives = []
    for name in ['Result', 'Success', 'Failure']:
        _, _, content = take_class(result, name)
        filename = snake(name) + '.dart'
        directives.append("part 'result/" + filename + "';\n")
        files[MODELS + 'result/' + filename] = "part of '../result.dart';\n\n" + content.rstrip() + '\n'
    files[MODELS + 'result.dart'] = header + ''.join(directives)
    files[CORE + 'src/resilience/result.dart'] = "// Compatibility export for API and UI result contracts.\nexport 'package:primecare_models/src/models/result.dart';\n"

    gate = original(CORE + 'src/resilience/execution_gate_service.dart')
    event_start = gate.index('/// Types of events')
    category_start = gate.index('/// Categories for telemetry')
    service_start, service_end, service = take_class(gate, 'ExecutionGateService')
    event = gate[event_start:category_start]
    enum_end = event.index('/// Represents a structured event')
    files[MODELS + 'aura_event_type.dart'] = event[:enum_end].rstrip() + '\n'
    event = event[enum_end:].replace('class AuraEvent {', 'class AuraEvent extends BaseEntity<String> {').replace('  final String id;\n', '').replace('required this.id,', 'required super.id,')
    files[MODELS + 'aura_event.dart'] = "import 'base_entity.dart';\nimport 'aura_event_type.dart';\nimport 'insight_impact.dart';\n\n" + event.rstrip() + '\n'
    files[MODELS + 'execution_gate_category.dart'] = gate[category_start:service_start].rstrip() + '\n'
    files[CORE + 'src/infrastructure/telemetry/execution_gate_service.dart'] = "part of '../../resilience/execution_gate_service.dart';\n\n" + service.rstrip() + '\n'
    files[CORE + 'src/resilience/execution_gate_service.dart'] = gate[:event_start].replace("import 'package:primecare_models/src/models/insight_impact.dart';\n", '') + "export 'package:primecare_models/src/models/aura_event.dart';\nexport 'package:primecare_models/src/models/aura_event_type.dart';\nexport 'package:primecare_models/src/models/execution_gate_category.dart';\nimport 'package:primecare_models/src/models/execution_gate_category.dart';\npart '../infrastructure/telemetry/execution_gate_service.dart';\n\n" + gate[service_end:]

    for filename, name in [('aura_command_service.dart', 'AuraCommandService'), ('aura_pulse_service.dart', 'AuraPulseService'), ('aura_behavioral_telemetry.dart', 'AuraBehavioralTelemetry'), ('intelligence_service.dart', 'IntelligenceService')]:
        source = original(CORE + filename)
        start, end, content = take_class(source, name)
        path = 'src/application/services/' + filename
        prefix = "part of '../../../" + filename + "';\n\n"
        if name == 'IntelligenceService':
            old = 'class IntelligenceService {\n  final ExecutionGateService _telemetry;\n\n  IntelligenceService(this._telemetry);'
            new = 'class IntelligenceService extends BaseGuardedService {\n  IntelligenceService(ExecutionGateService telemetry) : super(telemetry);'
            assert old in content
            content = content.replace(old, new).replace('_telemetry', 'telemetry').replace('Result.guardFuture<List<IntelligenceInsight>>(', 'guard<List<IntelligenceInsight>>(')
            source = source[:start] + "import 'src/application/services/base_business_service.dart';\n" + source[start:]
            start, end, _ = take_class(source, name)
        files[CORE + path] = prefix + content.rstrip() + '\n'
        files[CORE + filename] = source[:start] + "part '" + path + "';\n" + source[end:]

    files[CORE + 'src/controllers/base_value_notifier.dart'] = "import 'package:flutter_riverpod/flutter_riverpod.dart';\n\n/// Shared lifecycle and updates for existing scalar Aura state controllers.\nabstract class BaseValueNotifier<T> extends Notifier<T> {\n  T get initialValue;\n  @override\n  T build() => initialValue;\n  void update(covariant T value) => state = value;\n}\n"
    aura = original(CORE + 'aura_providers.dart')
    aura = aura.replace("import 'package:flutter_core/flutter_core.dart';", "import 'package:flutter_core/flutter_core.dart';\nimport 'src/controllers/base_value_notifier.dart';")
    parts = []
    for name, kind, initial in [('AuraContextNotifier','String?','null'),('AuraActiveVisualizationNotifier','bool','false'),('AuraSnoozeNotifier','bool','false'),('AuraQueryNotifier','String',"''"),('AuraPulseEventNotifier','AuraEvent?','null')]:
        start, end, content = take_class(aura, name)
        content = content.replace('extends Notifier<'+kind+'>', 'extends BaseValueNotifier<'+kind+'>').replace(kind+' build() => '+initial+';', kind+' get initialValue => '+initial+';')
        if name == 'AuraPulseEventNotifier':
            content = content.replace('  void update(AuraEvent event) => state = event;', '  @override\n  void update(covariant AuraEvent event) => super.update(event);')
        else:
            content = re.sub(r'\n  void update\([^\n]+\n', '\n', content)
        path = 'src/controllers/' + snake(name) + '.dart'
        parts.append("part '" + path + "';\n")
        files[CORE + path] = "part of '../../aura_providers.dart';\n\n" + content.rstrip() + '\n'
        aura = aura[:start] + aura[end:]
    index = aura.index('\n', aura.index("import 'src/controllers/base_value_notifier.dart';")) + 1
    files[CORE + 'aura_providers.dart'] = aura[:index] + '\n' + ''.join(parts) + aura[index:]
    return {path: '\n'.join(line.rstrip() for line in content.splitlines()).rstrip() + '\n' for path,content in files.items()}

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--check',action='store_true');args=parser.parse_args()
    files=render()
    manifest={'sourceCommit':SOURCE,'files':list(files),'sharedClasses':6,'sharedEnums':2,'flutterClassFiles':11,'newParentClasses':2,'completedWorkflows':0}
    if args.check:
        for path, content in files.items(): assert (ROOT/path).read_text()==content, path
        assert json.loads(MANIFEST.read_text())==manifest
        print(json.dumps({key:manifest[key] for key in ['sharedClasses','sharedEnums','flutterClassFiles','newParentClasses','completedWorkflows']}))
    else:
        assert not MANIFEST.exists()
        for path, content in files.items():
            target=ROOT/path;target.parent.mkdir(parents=True,exist_ok=True);target.write_text(content)
        MANIFEST.write_text(json.dumps(manifest,indent=2)+'\n')
if __name__=='__main__':main()
