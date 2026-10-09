"""Extract existing pure states without moving presentation or validation logic."""
import re
from pathlib import Path
FIELDS = {'isLoading': 'bool', 'error': 'String?', 'title': 'String', 'logs': 'List<String>'}

def extract(source, name):
    match = re.search(r'class ' + re.escape(name) + r'(?: extends BaseLoggedScreenState)? \{', source)
    assert match, name + ': state declaration missing'
    start = match.start()
    end = source.index('\n}\n', start) + 3
    return start, end, source[start:end]

def model_source(block, name, base_import='base_logged_screen_state.dart'):
    header = "import '" + base_import + "';\n\n"
    if 'class ' + name + ' extends BaseLoggedScreenState {' in block:
        return header + block
    result = block.replace('class ' + name + ' {', 'class ' + name + ' extends BaseLoggedScreenState {', 1)
    for field, typ in FIELDS.items():
        result, count = re.subn(r'  final ' + re.escape(typ) + r' ' + field + r';\n', '', result, count=1)
        assert count == 1, name + ': common field missing'
        result = result.replace('this.' + field, 'super.' + field, 1)
    return header + result

def screen_source(source, name, shared):
    start, end, _ = extract(source, name)
    library = shared.split('/lib/', 1)[1].removesuffix('.dart')
    imports = "import 'package:primecare_models/" + library + ".dart';\n" + "export 'package:primecare_models/" + library + ".dart' show " + name + ";\n"
    return imports + source[:start] + source[end:]

def write_screen_model(project_root, screen_path, content, name):
    """Keep generated names scoped by source path, avoiding cross-app collisions."""
    root = Path(project_root)
    screen = Path(screen_path)
    relative = screen.relative_to(root)
    shared = Path('packages/primecare_models/lib/src/generated_screen_states') / relative
    _, _, block = extract(content, name)
    model = root / shared
    model.parent.mkdir(parents=True, exist_ok=True)
    model.write_text(model_source(block, name, 'package:primecare_models/src/models/base_logged_screen_state.dart'))
    screen.parent.mkdir(parents=True, exist_ok=True)
    screen.write_text(screen_source(content, name, shared.as_posix()))
    return model
