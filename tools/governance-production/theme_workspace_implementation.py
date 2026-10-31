"""Record source implementation after isolated CI acceptance; never record runtime/human approval."""
import json
import sys
from theme_adoption_registration import ThemeStore, FILE, register, verify_independently
from production_reader import GovernanceReadError


def record(db):
    receipt = register(db)
    for control in json.loads(FILE.read_text())['controls']:
        if control['key'] != 'footer':
            db.record_control_implementation(receipt['screenId'], receipt['controls'][control['testId']], control['testId'])
    result = register(db)  # Checks every unchanged metadata field and preserves the new tags.
    expected = {c['testId']: 'registered-unimplemented' if c['key'] == 'footer' else 'implemented-unverified' for c in json.loads(FILE.read_text())['controls']}
    if result['implementationStatuses'] != expected:
        raise GovernanceReadError('Theme implementation status readback differs')
    return result


def main():
    if sys.argv[1:] not in [['--dry-run'], ['--apply']]:
        raise SystemExit('Explicit --dry-run or --apply required')
    with ThemeStore() as db:
        result = record(db)
        if record(db) != result:
            raise GovernanceReadError('Implementation recording is not idempotent')
        if sys.argv[1] == '--dry-run': db.db.rollback()
    result['committed'] = sys.argv[1] == '--apply'
    if result['committed']:
        verify_independently(result)
        result['independentReadback'] = True
    result.update(productionRuntimeVerified=False, humanReviewApproved=False, footerImplemented=False)
    print('THEME_WORKSPACE_IMPLEMENTATION ' + json.dumps(result, sort_keys=True))


if __name__ == '__main__': main()
