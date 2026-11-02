"""Keep one explicitly selected web runtime per production Pages project."""
import argparse
import json
import os
from pathlib import Path

def validate(policy, projects):
    if not isinstance(policy, dict) or set(policy) != {'version', 'projects'} or type(policy['version']) is not int or policy['version'] != 1:
        raise ValueError('Invalid production runtime policy')
    selected = policy['projects']
    if not isinstance(selected, dict) or set(selected) != set(projects) or any(v not in ('typescript', 'flutter') for v in selected.values()):
        raise ValueError('Every registered production project requires exactly one runtime')
    return selected

def may_publish(project, runtime, selected):
    if runtime not in ('typescript', 'flutter') or project not in selected:
        raise ValueError('Unknown production project or runtime')
    return selected[project] == runtime

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('project', help='Registered project, or all for a coordinated release')
    parser.add_argument('runtime', choices=['typescript', 'flutter'])
    parser.add_argument('--require', action='store_true')
    parser.add_argument('--github-output', action='store_true')
    args = parser.parse_args()
    selected = validate(json.loads(Path('websites/production-runtime.json').read_text()), json.loads(Path('websites/typescript/projects.json').read_text()))
    projects = list(selected) if args.project == 'all' else [args.project]
    publish = all(may_publish(project, args.runtime, selected) for project in projects)
    if args.github_output:
        with open(os.environ['GITHUB_OUTPUT'], 'a') as output:
            output.write('publish=' + str(publish).lower() + '\n')
    print(json.dumps({'productionPublish': publish, 'requestedRuntime': args.runtime, 'projects': {p:selected[p] for p in projects}}, sort_keys=True))
    if args.require and not publish:
        raise SystemExit('Production runtime differs from selected policy; no publication authorized by this source')

if __name__ == '__main__': main()
