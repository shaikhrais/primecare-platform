"""Discover existing HR surfaces before implementing departments or workflows."""
import json
import os
import re
from pathlib import Path
from domain_metadata_inventory import GovernedMetadataInventory


class HrMetadataInventory(GovernedMetadataInventory):
    domain = 'human-resources'
    pattern = re.compile(r'(^|[^a-z])hr([^a-z]|$)|human.?resources?|recruit|hiring|onboard|training|credential|knowledge|risk', re.I)

    def matches(self, value):
        return bool(self.pattern.search(str(value)))


if __name__ == '__main__':
    from production_reader import connect
    with connect() as db:
        report = HrMetadataInventory().collect(db, os.environ['GITHUB_SHA'])
    target = Path('test-results/hr-governance')
    target.mkdir(parents=True, exist_ok=True)
    (target / 'inventory.json').write_text(json.dumps(report, indent=2) + '\n')
    print('HR_GOVERNANCE_INVENTORY ' + json.dumps(report['summary']))
