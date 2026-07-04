import os
import re
import sqlite3
import argparse
import shutil
from pathlib import Path

# Paths
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
OUTPUT_DIR = os.path.join(PROJECT_ROOT, "tools", "governance", "layouts")

# Mustache Token Parser & Evaluator supporting nested sections and inverse sections
def render_mustache(template, context):
    pattern = re.compile(r"\{\{([#\/\^]?)([\w\.-]+)\}\}")
    pos = 0
    stack = [([], None, None)]  # list of (child_tokens, section_name, prefix)
    
    for match in pattern.finditer(template):
        start, end = match.span()
        if start > pos:
            stack[-1][0].append(('text', template[pos:start]))
        
        prefix = match.group(1)
        name = match.group(2)
        
        if prefix in ('#', '^'):
            stack.append(([], name, prefix))
        elif prefix == '/':
            if len(stack) > 1:
                child_tokens, sec_name, sec_pref = stack.pop()
                if sec_name == name:
                    stack[-1][0].append(('section', name, sec_pref, child_tokens))
                else:
                    # Mismatch recovery
                    stack[-1][0].append(('text', f"{{#{sec_name}}}"))
                    stack[-1][0].extend(child_tokens)
                    stack[-1][0].append(('text', f"{{/{name}}}"))
            else:
                stack[-1][0].append(('text', match.group(0)))
        else:
            stack[-1][0].append(('var', name))
        pos = end
        
    if pos < len(template):
        stack[-1][0].append(('text', template[pos:]))
        
    while len(stack) > 1:
        child_tokens, sec_name, sec_pref = stack.pop()
        stack[-1][0].append(('text', f"{{#{sec_name}}}"))
        stack[-1][0].extend(child_tokens)
        
    root_tokens = stack[0][0]
    
    def get_value(ctx, path):
        if not path:
            return ""
        parts = path.split('.')
        curr = ctx
        for p in parts:
            if isinstance(curr, dict) and p in curr:
                curr = curr[p]
            else:
                return None
        return curr
        
    def evaluate(tokens_list, ctx):
        res = []
        for t_type, *args in tokens_list:
            if t_type == 'text':
                res.append(args[0])
            elif t_type == 'var':
                val = get_value(ctx, args[0])
                res.append(str(val) if val is not None else "")
            elif t_type == 'section':
                name, prefix, inner = args
                val = get_value(ctx, name)
                if prefix == '^':
                    # Inverse section: evaluate only if val is falsy
                    is_falsy = not val
                    if is_falsy:
                        res.append(evaluate(inner, ctx))
                else:
                    # Regular section
                    if not val:
                        continue
                    if isinstance(val, list):
                        for item in val:
                            item_ctx = {**ctx}
                            if isinstance(item, dict):
                                item_ctx.update(item)
                            res.append(evaluate(inner, item_ctx))
                    elif isinstance(val, dict):
                        res.append(evaluate(inner, {**ctx, **val}))
                    else:
                        res.append(evaluate(inner, ctx))
        return "".join(res)
        
    return evaluate(root_tokens, context)

theme_defaults = {
    'color_primary': '#0f172a',
    'color_secondary': '#475569',
    'color_background': '#eef3f8',
    'color_surface': '#ffffff',
    'color_text': '#0f172a',
    'color_muted': '#64748b',
    'spacing_sm': '10px',
    'spacing_md': '16px',
    'spacing_lg': '28px',
    'radius_md': '14px',
    'font_family': '"Segoe UI", system-ui, -apple-system, BlinkMacSystemFont, Roboto, sans-serif'
}

def get_theme_data(cur, screen_id):
    # Try screen-specific theme mapping
    cur.execute("SELECT theme_id FROM screen_theme_map WHERE screen_id = ?", (screen_id,))
    row = cur.fetchone()
    if row:
        theme_id = row['theme_id']
    else:
        # Default active theme
        cur.execute("SELECT id FROM themes WHERE default_theme = 1 LIMIT 1")
        row = cur.fetchone()
        theme_id = row['id'] if row else 1

    cur.execute("SELECT token_name, token_value FROM design_tokens WHERE theme_id = ?", (theme_id,))
    tokens = {r['token_name']: r['token_value'] for r in cur.fetchall()}

    return {
        'color_primary': tokens.get('primary', theme_defaults['color_primary']),
        'color_secondary': tokens.get('secondary', theme_defaults['color_secondary']),
        'color_background': tokens.get('background', theme_defaults['color_background']),
        'color_surface': tokens.get('surface', theme_defaults['color_surface']),
        'color_text': tokens.get('text', tokens.get('foreground', theme_defaults['color_text'])),
        'color_muted': tokens.get('muted', theme_defaults['color_muted']),
        'spacing_sm': tokens.get('spacing-sm', theme_defaults['spacing_sm']),
        'spacing_md': tokens.get('spacing-md', theme_defaults['spacing_md']),
        'spacing_lg': tokens.get('spacing-lg', theme_defaults['spacing_lg']),
        'radius_md': tokens.get('radius-md', theme_defaults['radius_md']),
        'font_family': tokens.get('font-sans', tokens.get('font-family', theme_defaults['font_family']))
    }

def get_translation(cur, key_code, lang_code, fallback):
    cur.execute("""
        SELECT val.translated_text
        FROM translation_keys k
        JOIN translation_values val ON k.id = val.key_id
        WHERE k.key_code = ? AND val.locale_code = ?
    """, (key_code, lang_code))
    row = cur.fetchone()
    return row['translated_text'] if row else fallback

def main():
    parser = argparse.ArgumentParser(description="Generate layout contracts from SQLite governance DB.")
    parser.add_argument("--screen", help="Specific screen code to generate.")
    parser.add_argument("--lang", default="en", help="Language code (e.g. en, es, fr).")
    args = parser.parse_args()

    # Ensure output directory exists
    Path(OUTPUT_DIR).mkdir(parents=True, exist_ok=True)

    # Load templates from unzipped pack
    unzipped_dir = os.path.join(PROJECT_ROOT, ".agents", "governance", "unzipped")
    app_shell_path = os.path.join(unzipped_dir, "primecare_app_shell.html")
    sidebar_path = os.path.join(unzipped_dir, "primecare_sidebar.html")
    topbar_path = os.path.join(unzipped_dir, "primecare_topbar.html")
    content_container_path = os.path.join(unzipped_dir, "primecare_content_container.html")

    if not all(os.path.exists(p) for p in [app_shell_path, sidebar_path, topbar_path, content_container_path]):
        print(f"Error: One or more template files are missing in unzipped pack directory '{unzipped_dir}'")
        return

    with open(app_shell_path, "r", encoding="utf-8") as f:
        app_shell_content = f.read()
    with open(sidebar_path, "r", encoding="utf-8") as f:
        sidebar_content = f.read()
    with open(topbar_path, "r", encoding="utf-8") as f:
        topbar_content = f.read()
    with open(content_container_path, "r", encoding="utf-8") as f:
        content_container_content = f.read()

    # Combine partials in app shell template
    combined_template = app_shell_content
    combined_template = combined_template.replace("{{> primecare_sidebar }}", sidebar_content)
    combined_template = combined_template.replace("{{> primecare_topbar }}", topbar_content)
    combined_template = combined_template.replace("{{> primecare_content_container }}", content_container_content)

    # Inject the style overrides block in <head>
    theme_style_block = """
  <style>
    :root {
      --pc-color-primary: {{theme.color_primary}};
      --pc-color-secondary: {{theme.color_secondary}};
      --pc-color-background: {{theme.color_background}};
      --pc-color-surface: {{theme.color_surface}};
      --pc-color-text: {{theme.color_text}};
      --pc-color-muted: {{theme.color_muted}};
      --pc-spacing-sm: {{theme.spacing_sm}};
      --pc-spacing-md: {{theme.spacing_md}};
      --pc-spacing-lg: {{theme.spacing_lg}};
      --pc-radius-md: {{theme.radius_md}};
      --pc-font-family: {{theme.font_family}};
    }
  </style>
"""
    combined_template = combined_template.replace("</head>", theme_style_block + "\n</head>")

    # Copy theme assets
    css_src = os.path.join(unzipped_dir, "primecare_theme.css")
    json_src = os.path.join(unzipped_dir, "primecare_default_theme.json")
    if os.path.exists(css_src):
        shutil.copy2(css_src, os.path.join(OUTPUT_DIR, "primecare_theme.css"))
    if os.path.exists(json_src):
        shutil.copy2(json_src, os.path.join(OUTPUT_DIR, "primecare_default_theme.json"))

    # Connect to SQLite
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # Fetch language direction
    cur.execute("SELECT direction FROM languages WHERE language_code = ? LIMIT 1", (args.lang,))
    lang_row = cur.fetchone()
    lang_direction = lang_row['direction'] if lang_row else 'ltr'

    # Filter screens
    query = """
        SELECT s.id as screen_id, s.screen_code, s.screen_name, s.app_id, s.role_id,
               a.app_name, a.app_code, r.role_name, r.role_code
        FROM screens s
        JOIN apps a ON s.app_id = a.id
        JOIN roles r ON s.role_id = r.id
    """
    params = []
    if args.screen:
        query += " WHERE s.screen_code = ?"
        params.append(args.screen)
    
    cur.execute(query, params)
    screens = cur.fetchall()

    if not screens:
        print("No screens found matching the specified parameters.")
        conn.close()
        return

    print(f"Generating layouts for {len(screens)} screens in '{args.lang}' locale using unzipped app shell templates...")

    for scr in screens:
        screen_id = scr['screen_id']
        screen_code = scr['screen_code']
        screen_name = scr['screen_name']
        screen_purpose = 'Visual interface layout contract.'
        app_id = scr['app_id']
        app_name = scr['app_name']
        app_code = scr['app_code']
        role_id = scr['role_id']
        role_name = scr['role_name']
        role_code = scr['role_code']

        # Theme
        theme_data = get_theme_data(cur, screen_id)

        # Screen Title Translation
        screen_title = get_translation(cur, f"scr_title_{screen_code}", args.lang, screen_name)

        # Sidebar Items grouped by sidebar_group
        cur.execute("""
            SELECT s.route_path, scr.screen_code, s.sidebar_icon, s.sidebar_label, s.sidebar_group
            FROM sidebar_items s
            JOIN screens scr ON s.screen_id = scr.id
            WHERE s.app_id = ? AND (s.role_id = ? OR s.role_id IS NULL) AND s.visible = 1
            ORDER BY s.display_order
        """, (app_id, role_id))
        
        sidebar_items_raw = cur.fetchall()
        groups_map = {}
        for row in sidebar_items_raw:
            g_name = row['sidebar_group'] or 'Overview'
            translated_label = get_translation(cur, f"sidebar_label_{row['screen_code']}", args.lang, row['sidebar_label'])
            item_data = {
                'route_path': row['route_path'],
                'screen_code': row['screen_code'],
                'item_code': row['screen_code'],
                'item_icon': row['sidebar_icon'] or '📁',
                'item_label': translated_label,
                'active_class': 'is-active' if row['screen_code'] == screen_code else ''
            }
            if g_name not in groups_map:
                groups_map[g_name] = []
            groups_map[g_name].append(item_data)
            
        sidebar_groups = []
        for g_name, items in groups_map.items():
            sidebar_groups.append({
                'group_label': g_name,
                'items': items
            })

        # Topbar Items
        cur.execute("""
            SELECT item_code, action_type, item_label, item_type, icon
            FROM topbar_items
            WHERE app_id = ? AND (role_id = ? OR role_id IS NULL) AND visible = 1
            ORDER BY display_order
        """, (app_id, role_id))
        topbar_items = []
        for row in cur.fetchall():
            translated_label = get_translation(cur, f"topbar_label_{row['item_code']}", args.lang, row['item_label'])
            is_search = row['item_type'] == 'search' or row['item_code'] == 'search'
            topbar_items.append({
                'item_code': row['item_code'],
                'action_type': row['action_type'],
                'feature_code': row['item_code'],
                'item_icon': row['icon'] or '⚙️',
                'item_label': translated_label,
                'is_search': is_search,
                'placeholder_text': f"Search in {app_name}..." if is_search else ''
            })

        # Screen Sections
        cur.execute("""
            SELECT id as section_id, section_code, section_name, section_type, purpose
            FROM screen_sections
            WHERE screen_id = ?
            ORDER BY section_order
        """, (screen_id,))
        screen_sections = []
        for sec in cur.fetchall():
            sec_id = sec['section_id']
            section_code = sec['section_code']
            section_name = sec['section_name']
            
            # Section Elements
            cur.execute("""
                SELECT element_key, element_type, label, test_id
                FROM screen_section_elements
                WHERE section_id = ?
                ORDER BY element_order
            """, (sec_id,))
            section_elements = []
            for el in cur.fetchall():
                translated_el_label = get_translation(cur, f"element_label_{el['element_key']}", args.lang, el['label'])
                section_elements.append({
                    'element_test_id': el['test_id'] or f"el-{el['element_key']}",
                    'element_type': el['element_type'] or 'div',
                    'element_label': translated_el_label
                })

            translated_sec_name = get_translation(cur, f"section_name_{section_code}", args.lang, section_name)
            screen_sections.append({
                'section_code': section_code,
                'section_type': sec['section_type'] or 'card',
                'section_name': translated_sec_name,
                'section_purpose': sec['purpose'] or '',
                'section_elements': section_elements
            })

        # Breadcrumbs, Initials, Theme details
        breadcrumb_path = f"{app_name} / {role_name}"
        user_initials = "".join([w[0].upper() for w in role_name.split() if w])[:2]
        theme_code = "primecare_light_default"

        # Context Object
        context = {
            'language_code': args.lang,
            'language_direction': lang_direction,
            'screen_title': screen_title,
            'screen_purpose': screen_purpose,
            'app_name': app_name,
            'app_code': app_code,
            'app_short_code': app_code.upper(),
            'role_code': role_code,
            'screen_code': screen_code,
            'role_name': role_name,
            'theme_code': theme_code,
            'theme': theme_data,
            'sidebar_groups': sidebar_groups,
            'topbar_items': topbar_items,
            'screen_sections': screen_sections,
            'breadcrumb_path': breadcrumb_path,
            'user_initials': user_initials,
            'content_state': 'Active',
            'is_loading': False
        }

        # Render combined layout
        html_out = render_mustache(combined_template, context)

        # Save to layout file
        out_filename = f"{app_code}_{role_code}_{screen_code}.html"
        out_filepath = os.path.join(OUTPUT_DIR, out_filename)
        with open(out_filepath, "w", encoding="utf-8") as f:
            f.write(html_out)

    print(f"Success: High-fidelity layouts generated in '{OUTPUT_DIR}'")
    conn.close()

if __name__ == "__main__":
    main()
