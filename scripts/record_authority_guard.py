"""Validate existing owner-read authority before registration writes any artifacts."""
def validate_record_authority(db, definitions, service, permission):
    prefix = '/v1/' + service
    for record in definitions:
        modes = ['singleton'] if record.get('singleton') else ['list', 'detail'] + (['summary'] if record.get('summaryField') else [])
        for mode in modes:
            route = prefix + record['path'] + ('/{recordId}' if mode == 'detail' else '/summary' if mode == 'summary' else '')
            rows = db.execute(
                "SELECT service_name,auth_required,permission_key FROM api_endpoints WHERE route_path=? AND http_method='GET'",
                (route,),
            ).fetchall()
            if rows and rows != [(service, 1, permission)]:
                raise RuntimeError('Owner-read endpoint authority drift: GET ' + route)
