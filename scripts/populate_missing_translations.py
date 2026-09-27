import sqlite3
import re

def camel_to_title(text):
    if not text:
        return ""
    # Remove "Screen" suffix if present
    if text.endswith("Screen"):
        text = text[:-6]
    # Insert space before capital letters
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1 \2', text)
    title = re.sub('([a-z0-9])([A-Z])', r'\1 \2', s1)
    # Clean up abbreviations
    title = title.replace("Rmt", "RMT").replace("Cns", "CNS").replace("Hsw", "HSW")
    title = title.replace("Lpn", "LPN").replace("Np", "NP").replace("Psw", "PSW")
    title = title.replace("Rn", "RN")
    return title.strip()

def main():
    conn = sqlite3.connect('.agents/governance/governance.db')
    cur = conn.cursor()

    # Get all active languages
    cur.execute("SELECT language_code FROM languages")
    languages = [row[0] for row in cur.fetchall()]

    print("Populating missing sidebar translations...")
    cur.execute("""
        SELECT DISTINCT scr.screen_code, s.sidebar_label 
        FROM sidebar_items s
        JOIN screens scr ON s.screen_id = scr.id
    """)
    sidebar_items = cur.fetchall()

    for screen_code, sidebar_label in sidebar_items:
        key_code = f"sidebar_label_{screen_code}"
        
        # Check if key already exists
        cur.execute("SELECT id FROM translation_keys WHERE key_code = ?", (key_code,))
        row = cur.fetchone()
        if not row:
            # Form title
            title = camel_to_title(sidebar_label)
            
            # Insert key
            cur.execute("""
                INSERT INTO translation_keys (key_code, namespace, default_text, description) 
                VALUES (?, 'sidebar', ?, 'Automated sidebar label translation')
            """, (key_code, title))
            key_id = cur.lastrowid
            
            # Insert translation values
            for lang in languages:
                val = title if lang == 'en' else f"[{lang.upper()}] {title}"
                cur.execute("""
                    INSERT INTO translation_values (key_id, locale_code, translated_text)
                    VALUES (?, ?, ?)
                """, (key_id, lang, val))

    print("Populating missing topbar translations...")
    cur.execute("SELECT DISTINCT item_code, item_label FROM topbar_items")
    topbar_items = cur.fetchall()

    for item_code, item_label in topbar_items:
        key_code = f"topbar_label_{item_code}"
        
        # Check if key already exists
        cur.execute("SELECT id FROM translation_keys WHERE key_code = ?", (key_code,))
        row = cur.fetchone()
        if not row:
            # Form title
            title = camel_to_title(item_label)
            
            # Insert key
            cur.execute("""
                INSERT INTO translation_keys (key_code, namespace, default_text, description) 
                VALUES (?, 'topbar', ?, 'Automated topbar label translation')
            """, (key_code, title))
            key_id = cur.lastrowid
            
            # Insert translation values
            for lang in languages:
                val = title if lang == 'en' else f"[{lang.upper()}] {title}"
                cur.execute("""
                    INSERT INTO translation_values (key_id, locale_code, translated_text)
                    VALUES (?, ?, ?)
                """, (key_id, lang, val))

    conn.commit()
    conn.close()
    print("All missing translations populated successfully!")

if __name__ == "__main__":
    main()
