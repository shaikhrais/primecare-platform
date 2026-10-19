import os
import sqlite3
import json
import re
import sys

# Ensure scripts directory is in path
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
from report_handler import ReportHandler

def camel_to_snake(name):
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower()

def snake_to_pascal(name):
    return ''.join(word.capitalize() for word in name.split('_'))

def generate_custom_screen_widget(sid, screen_code, screen_name, app_name, role_name, app_code, role_code, route_path, purpose, user_story, criteria, sections, elements, apis):
    if not sections or not elements or not apis:
        raise ValueError(f'{screen_code}: governed sections, elements, and APIs are required')
    if any(a.get('method', '').upper() != 'GET' for a in apis):
        raise ValueError(f'{screen_code}: template supports read-only GET contracts only')
    class_name = snake_to_pascal(screen_code) if '_' in screen_code else screen_name
    if not class_name.endswith('Screen'):
        class_name += 'Screen'

    theme = {'primary': 'theme.colors.primary', 'bg': 'theme.colors.background',
             'card': 'theme.colors.surface', 'accent': 'theme.colors.secondary',
             'text': 'theme.colors.onSurface'}
    kebab_code = screen_code.lower().replace('_', '-')
    provider_name = f"{camel_to_snake(screen_code)}DataProvider"

    # Build unique section widgets based on database section records
    section_code_blocks = []
    for sec in (sections if sections else [{'section_name': 'Main Workspace', 'section_type': 'general', 'purpose': 'Core operational section.'}]):
        sec_name = sec['section_name']
        sec_type = sec.get('section_type', 'general')
        sec_purpose = sec.get('purpose', 'Governed workspace section.')
        
        sec_elements = [el for el in elements if el.get('section_id') == sec.get('section_id')]
        if not sec_elements:
            sec_elements = elements[:4] if elements else [{'label': f"{sec_name} Action", 'element_type': 'button', 'test_id': f"{kebab_code}-action"}]

        sec_widget = f"""
    Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusDefault),
        border: Border.all(color: theme.colors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.dashboard_customize_outlined, color: {theme['primary']}, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '{sec_name}',
                    style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold, fontSize: theme.scaleFont(15), color: theme.colors.onSurface),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: {theme['primary']}.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(theme.radiusDefault),
                ),
                child: Text(
                  '{sec_type.upper()}',
                  style: theme.typography.bodyMedium.copyWith(color: {theme['primary']}, fontSize: theme.scaleFont(10), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '{sec_purpose}',
            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant, fontSize: theme.scaleFont(12)),
          ),
          const SizedBox(height: 16),
          
          ...{json.dumps([el['label'] for el in sec_elements])}.map((lbl) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    lbl,
                    style: theme.typography.bodyMedium.copyWith(fontSize: theme.scaleFont(13), color: theme.colors.onSurface, fontWeight: FontWeight.w500),
                  ),
                ),
                Semantics(
                  label: lbl.toLowerCase().replaceAll(' ', '_'),
                  child: ElevatedButton(
                    key: Key('btn_${{lbl.toLowerCase().replaceAll(' ', '_')}}'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: {theme['primary']},
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(theme.radiusDefault)),
                    ),
                    onPressed: null, // No governed action handler is implemented.
                    child: Text('Execute Action', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onPrimary, fontSize: theme.scaleFont(11), fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    )"""
        section_code_blocks.append(sec_widget)

    sections_rendered_code = ',\n'.join(section_code_blocks)

    api_endpoints_list = [a['endpoint_path'] for a in apis] if apis else ['/api/v1/data']
    api_methods_list = [a['method'] for a in apis] if apis else ['GET']
    primary_api_path = api_endpoints_list[0]
    
    # Format all APIs into provider code comments & mappings
    apis_code_lines = '\n'.join([f"    // API Endpoint: {a['method']} {a['endpoint_path']}" for a in (apis if apis else [{'method': 'GET', 'endpoint_path': '/api/v1/data'}])])
    apis_audit_display = r'\n'.join([f"• Mapped API: {a['method']} {a['endpoint_path']}" for a in (apis if apis else [{'method': 'GET', 'endpoint_path': '/api/v1/data'}])])

    dart_code = f"""// Generated directly from SQLite Database (.agents/governance/governance.db)
// Screen Code: {screen_code} | Screen Name: {screen_name}
// Target Role: {role_name} ({role_code}) | Application: {app_name} ({app_code})
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/theme/theme_contrast.dart';

final {provider_name} = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {{
  final api = ref.read(apiClientProvider);
  try {{
{apis_code_lines}
    final response = await api.get('{primary_api_path}');
    if (response.data is! Map) throw const FormatException('Expected an object response');
    return Map<String, dynamic>.from(response.data as Map);
  }} catch (_) {{
    rethrow; // Preserve transport failures; never synthesize successful data.
  }}
}});

/// {class_name} - Governed screen implementation for {app_name} ({role_name}).
/// Business Purpose: {purpose}
class {class_name} extends GovernedConsumerWidget {{
  const {class_name}({{super.key}});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {{
    final theme = context.theme;
    final dataState = ref.watch({provider_name});

    return Scaffold(
      backgroundColor: {theme['bg']},
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 1,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: {theme['primary']}.withOpacity(0.1),
                borderRadius: BorderRadius.circular(theme.radiusDefault),
                border: Border.all(color: {theme['primary']}.withOpacity(0.3)),
              ),
              child: Text(
                '{app_code.upper()}',
                style: theme.typography.bodyMedium.copyWith(
                  color: {theme['primary']},
                  fontSize: theme.scaleFont(10),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '{screen_name}',
              style: theme.typography.bodyMedium.copyWith(
                color: theme.colors.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: theme.scaleFont(17),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. SPECIFIC BUSINESS PURPOSE & USER STORY HEADER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(theme.radiusDefault),
                border: Border.all(color: theme.colors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Target Role: {role_name}',
                        style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: {theme['text']}, fontSize: theme.scaleFont(14)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: theme.colors.success.withValues(alpha: .1), borderRadius: BorderRadius.circular(theme.radiusDefault)),
                        child: Text('NOT VERIFIED', style: theme.typography.bodyMedium.copyWith(color: readableThemeForeground(Color.alphaBlend(theme.colors.success.withValues(alpha: .1), theme.colors.surface), theme.colors.success), fontSize: theme.scaleFont(10), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('{purpose}', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant, fontSize: theme.scaleFont(13), height: 1.5)),
                  const SizedBox(height: 8),
                  Text('User Story: {user_story}', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant, fontSize: theme.scaleFont(12), fontStyle: FontStyle.italic)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. SPECIFIC SECTIONS RENDERED FROM DATABASE RECORDS
            {sections_rendered_code},
            const SizedBox(height: 24),

            // 3. GOVERNANCE AUDIT LOG & ALL MAPPED API ENDPOINTS
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.colors.surfaceContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('GOVERNANCE SPECIFICATIONS & ALL API ENDPOINTS', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold, fontSize: theme.scaleFont(13))),
                  const SizedBox(height: 8),
                  ...{json.dumps([f"• Mapped API: {a['method']} {a['endpoint_path']}" for a in (apis if apis else [{'method': 'GET', 'endpoint_path': '/api/v1/data'}])])}.map((apiStr) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(apiStr, style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant, fontSize: theme.scaleFont(11), fontFamily: 'monospace')),
                  )),
                  const SizedBox(height: 4),
                  Text('• Cypress Selector: data-cy="screen-{kebab_code}"', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface, fontSize: theme.scaleFont(12), fontFamily: 'monospace')),
                  const SizedBox(height: 4),
                  Text('• Accessibility: NOT VERIFIED', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant, fontSize: theme.scaleFont(12))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }}
}}
"""
    return dart_code

def implement_creative_screens_from_db():
    project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    db_path = os.path.join(project_root, '.agents', 'governance', 'governance.db')
    out_dir = os.path.join(project_root, 'packages', 'primecare_ui', 'lib', 'src', 'features', 'generated_screens')
    os.makedirs(out_dir, exist_ok=True)

    print(f"[DB Generator] Reading exact requirements from {db_path}...")
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    cursor.execute("""
        SELECT 
            s.id,
            s.screen_code,
            s.screen_name,
            s.route_path,
            s.actual_file_path,
            a.app_code,
            a.app_name,
            r.role_code,
            r.role_name,
            req.business_purpose,
            req.user_story,
            req.acceptance_criteria
        FROM screens s
        LEFT JOIN apps a ON s.app_id = a.id
        LEFT JOIN roles r ON s.role_id = r.id
        LEFT JOIN screen_requirements req ON s.id = req.screen_id
        WHERE s.active = 1
        ORDER BY s.screen_code
    """)
    screens = [dict(r) for r in cursor.fetchall()]
    print(f"[DB Generator] Generating unverified presentation templates for {len(screens)} screens...")

    implemented_count = 0
    for s in screens:
        sid = s['id']
        screen_code = s['screen_code']
        screen_name = s['screen_name'] or f"Screen{sid}"
        file_name = f"{camel_to_snake(screen_code)}.dart"
        target_path = os.path.join(out_dir, file_name)

        # Hand-written implementations must never be overwritten by templates.
        if os.path.exists(target_path):
            with open(target_path, encoding='utf-8') as existing:
                if not existing.read().startswith('// Generated directly from SQLite Database'):
                    continue

        # Fetch sections
        cursor.execute("SELECT id as section_id, section_name, section_type, purpose FROM screen_sections WHERE screen_id = ? ORDER BY section_order", (sid,))
        sections = [dict(r) for r in cursor.fetchall()]

        # Fetch elements
        cursor.execute("SELECT label, element_type, test_id, section_id FROM screen_section_elements WHERE screen_id = ?", (sid,))
        elements = [dict(r) for r in cursor.fetchall()]

        # Fetch ALL APIs mapped to this screen
        cursor.execute("SELECT a.api_name, a.method, a.endpoint_path FROM screen_api_map m JOIN api_registry a ON m.api_id = a.id WHERE m.screen_id = ?", (sid,))
        apis = [dict(r) for r in cursor.fetchall()]

        purpose = s['business_purpose'] or f"Governed workspace screen for {screen_name}."
        user_story = s['user_story'] or f"As a {s['role_name']}, I want to access {screen_name} to perform domain workflows."
        criteria = s['acceptance_criteria'] or "Loads successfully and restricted by role-based access control."
        app_name = s['app_name'] or 'PrimeCare Platform'
        role_name = s['role_name'] or 'Standard Role'
        app_code = s['app_code'] or 'general'
        role_code = s['role_code'] or 'all'
        route_path = s['route_path'] or '/'

        if not sections or not elements or not apis or any(a['method'].upper() != 'GET' for a in apis):
            print(f'[DB Generator] Skipped {screen_code}: incomplete or unsupported contract')
            continue

        dart_code = generate_custom_screen_widget(
            sid=sid,
            screen_code=screen_code,
            screen_name=screen_name,
            app_name=app_name,
            role_name=role_name,
            app_code=app_code,
            role_code=role_code,
            route_path=route_path,
            purpose=purpose,
            user_story=user_story,
            criteria=criteria,
            sections=sections,
            elements=elements,
            apis=apis
        )

        with open(target_path, 'w', encoding='utf-8') as f:
            f.write(dart_code)

        cursor.execute("""
            UPDATE screens
            SET actual_file_path = ?,
                implementation_tag = 'partial',
                content_tag = 'partial',
                api_tag = 'api_missing',
                test_tag = 'not_tested',
                review_tag = 'pending',
                completeness_score = 0,
                production_ready = 0,
                runtime_verified = 0,
                cypress_verified = 0
            WHERE id = ?
        """, (f"packages/primecare_ui/lib/src/features/generated_screens/{file_name}", sid))

        implemented_count += 1

    conn.commit()
    conn.close()

    print(f"[DB Generator] Generated unverified templates for {implemented_count} screens!")

    handler = ReportHandler(db_path=db_path)
    handler.generate_report()

if __name__ == '__main__':
    implement_creative_screens_from_db()
