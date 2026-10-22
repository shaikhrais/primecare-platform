"""Assess registered metadata only. Completeness never proves runtime behavior."""
import json


def object_schema(value):
    if isinstance(value, str):
        try:
            value = json.loads(value)
        except (ValueError, TypeError):
            return False
    return isinstance(value, dict) and value.get('type') == 'object' and bool(value.get('properties'))


def assess_contracts(apis, links, permissions, screen_grants, active_roles):
    """Report exact missing bindings; never infer or create a permission grant."""
    active_roles = set(active_roles)
    result = []
    for api in apis:
        attached = sorted({row['screenId'] for row in links if row['apiId'] == api['id']})
        # A registry declaration of implementation is not acceptance evidence.
        gaps = []
        if api.get('authRequired') != 1:
            gaps.append('authenticated_contract_missing')
        if not api.get('permission'):
            gaps.append('permission_key_missing')
        if not object_schema(api.get('requestSchema')):
            gaps.append('request_object_schema_missing_or_incomplete')
        if not object_schema(api.get('responseSchema')):
            gaps.append('response_object_schema_missing_or_incomplete')
        if not attached:
            gaps.append('screen_link_missing')
        grants = []
        for permission in permissions:
            if (permission['apiId'] != api['id'] or permission.get('canAccess') != 1 or
                    permission['roleId'] not in active_roles):
                continue
            # Both declarations must agree. A bare role-screen grant cannot
            # substitute for an endpoint grant, and an API grant alone is insufficient.
            if not api.get('permission') or permission.get('permission') != api['permission']:
                continue
            visible = sorted({grant['screenId'] for grant in screen_grants
                if grant['roleId'] == permission['roleId'] and grant['screenId'] in attached
                and grant.get('canView') == 1})
            if visible:
                grants.append({'roleId': permission['roleId'], 'screenIds': visible})
        if not grants:
            gaps.append('matching_active_role_api_and_screen_grants_missing')
        result.append({'apiId': api['id'], 'method': api['method'], 'path': api['path'],
            'linkedScreenIds': attached, 'matchingRegisteredGrants': grants,
            'metadataGaps': gaps, 'metadataComplete': not gaps,
            'runtimePolicyVerified': False, 'liveAcceptanceVerified': False})
    return result
