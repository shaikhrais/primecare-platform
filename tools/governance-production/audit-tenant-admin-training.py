"""Report only Tenant Admin training registration metadata from the pinned authority."""
import json
import os
import pathlib

from production_reader import connect


SHARED_COURSE = 'admin-operations'
ROLE = 'tenant_admin'
SCREEN_CODES = ('PLATFORM_ADMINISTRATION', 'TENANT_ADMIN_COMMAND_CENTER')
HOST_ROUTES = ('/platform/administration', '/tenant-dashboard')
REQUIRED_CATALOG = {'roles', 'admin_training_courses', 'admin_training_learning_grants'}


def count(db, sql, args):
    return db.execute(sql, args).fetchone()[0]


def audit(db):
    absent = sorted(REQUIRED_CATALOG.difference(db.tables))
    result = {
        'authority': 'pinned-production-postgresql',
        'manifestSha256': db.pin['manifestSha256'],
        'commit': os.environ.get('GITHUB_SHA'),
        'run': os.environ.get('GITHUB_RUN_ID'),
        'writesAttempted': False,
        'role': ROLE,
        'missingPinnedCatalogRelations': absent,
        'activeTenantAdminRoleMatches': None,
        'generalAdministratorCourse': None,
        'otherLinkedCourses': None,
    }

    if not absent:
        role = db.execute(
            'SELECT id FROM roles WHERE role_code=? AND active=1', (ROLE,)
        ).fetchall()
        if len(role) == 1:
            result['generalAdministratorCourse'] = {'linkedRows': 0, 'moduleCounts': []}
            result['otherLinkedCourses'] = {'linkedRows': 0, 'roleOnlyLinkedRows': 0, 'moduleCounts': []}
            courses = db.execute(
                'SELECT c.course_id,c.modules_json '
                'FROM admin_training_courses c JOIN admin_training_learning_grants g '
                'ON c.course_id=g.course_id WHERE g.role_id=? AND g.can_read=1 '
                'ORDER BY c.course_id', (role[0][0],),
            ).fetchall()
            for key, modules_json in courses:
                modules = json.loads(modules_json)
                if not isinstance(modules, list):
                    raise ValueError('Malformed governed training modules')
                grants = count(db, 'SELECT COUNT(DISTINCT role_id) FROM '
                                  'admin_training_learning_grants WHERE course_id=? AND can_read=1',
                               (key,))
                if key == SHARED_COURSE:
                    group = result['generalAdministratorCourse']
                else:
                    group = result['otherLinkedCourses']
                    group['roleOnlyLinkedRows'] += int(grants == 1)
                group['linkedRows'] += 1
                group['moduleCounts'].append(len(modules))
            for field in ('generalAdministratorCourse', 'otherLinkedCourses'):
                result[field]['moduleCounts'].sort()
        result['activeTenantAdminRoleMatches'] = len(role)

    # A registered screen/section is separate from a role-specific curriculum.
    if {'screens', 'screen_sections', 'screen_section_elements'}.issubset(db.tables):
        result['trainingSections'] = {}
        for code in SCREEN_CODES:
            sections, controls = db.execute(
                'SELECT COUNT(DISTINCT ss.id), COUNT(e.id) FROM screens s '
                'JOIN screen_sections ss ON s.id=ss.screen_id '
                'LEFT JOIN screen_section_elements e ON e.section_id=ss.id '
                'WHERE UPPER(s.screen_code)=? AND ss.section_code=?',
                (code, 'admin_training'),
            ).fetchone()
            result['trainingSections'][code] = {'sections': sections, 'controls': controls}

    # Resolve only the two known host routes/codes. Section-code synonyms are
    # discovery evidence, not a curriculum approval, access grant or alias rule.
    host_relations = {'screens', 'screen_sections', 'screen_section_elements'}
    result['missingTrainingHostRelations'] = sorted(host_relations.difference(db.tables))
    result['trainingHostResolution'] = None
    if not result['missingTrainingHostRelations']:
        selectors = [('route:' + route, 's.route_path=?', (route,))
                     for route in HOST_ROUTES]
        selectors += [('code:' + code, 'UPPER(s.screen_code)=?', (code,))
                      for code in SCREEN_CODES]
        selectors.append(('uniqueMatchedHosts',
                          '(s.route_path IN (?,?) OR UPPER(s.screen_code) IN (?,?))',
                          HOST_ROUTES + SCREEN_CODES))
        result['trainingHostResolution'] = {}
        for label, predicate, args in selectors:
            hosts, exact_sections, candidate_sections, candidate_controls = db.execute(
                'SELECT COUNT(DISTINCT s.id), '
                'COUNT(DISTINCT CASE WHEN ss.section_code=? THEN ss.id END), '
                'COUNT(DISTINCT ss.id), COUNT(DISTINCT e.id) FROM screens s '
                'LEFT JOIN screen_sections ss ON ss.screen_id=s.id AND '
                '(LOWER(ss.section_code) LIKE ? OR LOWER(ss.section_code) LIKE ? '
                'OR LOWER(ss.section_code) LIKE ?) '
                'LEFT JOIN screen_section_elements e ON e.section_id=ss.id '
                'WHERE s.active=1 AND ' + predicate,
                ('admin_training', '%training%', '%lesson%', '%course%') + args,
            ).fetchone()
            result['trainingHostResolution'][label] = {
                'activeHostMatches': hosts,
                'exactAdminTrainingSections': exact_sections,
                'trainingLessonCourseSectionCodeMatches': candidate_sections,
                'controlsInMatchingSections': candidate_controls,
            }
        result['trainingHostResolutionScope'] = {
            'activeHostsOnly': True,
            'sectionCodesOnly': True,
            'candidateDiscoveryOnly': True,
            'selectorGroupsOverlap': True,
        }

    if {'language_resources', 'language_resource_values', 'languages'}.issubset(db.tables):
        languages = db.execute(
            'SELECT l.language_code,COUNT(*),SUM(CASE WHEN v.reviewed=1 AND v.approved=1 THEN 1 ELSE 0 END) '
            'FROM language_resources r JOIN language_resource_values v ON r.resource_id=v.resource_id '
            'JOIN languages l ON v.language_id=l.language_id '
            'WHERE r.context=? AND r.active=1 GROUP BY l.language_code ORDER BY l.language_code',
            ('admin_training',),
        ).fetchall()
        result['sharedAdminTrainingLocalization'] = {
            lang: {'entries': entries, 'reviewedAndApproved': approved}
            for lang, entries, approved in languages if lang in ('en', 'fr', 'es')
        }

    result['courseRegistrationOnly'] = True
    result['doesNotProve'] = [
        'Tenant Admin curriculum content and scope approved',
        'Training recording or user-interface acceptance',
        'Training publishing or role authorization changes',
    ]
    return result


if __name__ == '__main__':
    with connect() as database:
        print(json.dumps(audit(database), indent=2, sort_keys=True))
