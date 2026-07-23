import os
import sqlite3
import time
from datetime import datetime
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

class ScreenshotHandler:
    """
    Dedicated handler for capturing, saving, and persisting screen screenshots
    to the single source of truth SQLite database (.agents/governance/governance.db).
    """

    def __init__(self, db_path=None, output_dir=None):
        project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
        self.db_path = db_path or os.path.join(project_root, '.agents', 'governance', 'governance.db')
        self.output_dir = output_dir or os.path.join(project_root, 'docs', 'gallery', 'screenshots')
        os.makedirs(self.output_dir, exist_ok=True)
        self.driver = None

    def get_connection(self):
        return sqlite3.connect(self.db_path)

    def init_driver(self, headless=True):
        if self.driver is None:
            options = Options()
            if headless:
                options.add_argument('--headless=new')
            options.add_argument('--no-sandbox')
            options.add_argument('--disable-dev-shm-usage')
            options.add_argument('--window-size=1920,1080')
            options.add_argument('--enable-flutter-web-driver')
            self.driver = webdriver.Chrome(options=options)
        return self.driver

    def quit_driver(self):
        if self.driver:
            try:
                self.driver.quit()
            except Exception as e:
                print(f"[ScreenshotHandler] Error closing driver: {e}")
            finally:
                self.driver = None

    def get_screens_to_capture(self, limit=None):
        conn = self.get_connection()
        cursor = conn.cursor()
        query = """
            SELECT 
                s.id,
                s.screen_code,
                s.screen_name,
                s.route_path,
                a.app_code,
                a.app_name,
                r.role_code,
                r.role_name,
                r.primary_app_url,
                s.screenshot_path
            FROM screens s
            LEFT JOIN apps a ON s.app_id = a.id
            LEFT JOIN roles r ON s.role_id = r.id
            WHERE s.active = 1
            ORDER BY a.app_code, r.role_code, s.screen_code
        """
        if limit:
            query += f" LIMIT {limit}"
        cursor.execute(query)
        rows = cursor.fetchall()
        conn.close()

        screens = []
        for r in rows:
            screens.append({
                'id': r[0],
                'screen_code': r[1],
                'screen_name': r[2],
                'route_path': r[3] or '/',
                'app_code': r[4] or 'general',
                'app_name': r[5] or 'General Application',
                'role_code': r[6] or 'all',
                'role_name': r[7] or 'All Roles',
                'primary_app_url': r[8] or 'https://primecare-clinic.pages.dev',
                'screenshot_path': r[9]
            })
        return screens

    def get_target_filepath(self, app_code, role_code, screen_code):
        folder = os.path.join(self.output_dir, app_code, role_code)
        os.makedirs(folder, exist_ok=True)
        filename = f"{screen_code}.png"
        full_path = os.path.join(folder, filename)
        
        # Calculate relative path from project root for storing in DB
        rel_path = os.path.relpath(full_path, start=os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))).replace('\\', '/')
        return full_path, rel_path

    def capture_screen(self, screen_info, base_url=None):
        driver = self.init_driver()
        app_url = base_url or screen_info['primary_app_url'] or 'https://primecare-clinic.pages.dev'
        route = screen_info['route_path']
        if not route.startswith('/'):
            route = '/' + route
        
        full_url = f"{app_url.rstrip('/')}{route}"
        full_path, rel_path = self.get_target_filepath(
            screen_info['app_code'],
            screen_info['role_code'],
            screen_info['screen_code']
        )

        try:
            print(f"[ScreenshotHandler] Navigating to {full_url}...")
            driver.get(full_url)
            time.sleep(1.5)  # Wait for rendering
            driver.save_screenshot(full_path)
            print(f"[ScreenshotHandler] Saved screenshot to {rel_path}")

            # Sync to SQLite DB
            self.save_screenshot_to_db(screen_info['id'], rel_path, f"Captured screenshot for {screen_info['screen_name']}")
            return True, rel_path
        except Exception as e:
            print(f"[ScreenshotHandler] Failed to capture {screen_info['screen_code']}: {e}")
            return False, str(e)

    def save_screenshot_to_db(self, screen_id, relative_path, description="Screen capture"):
        conn = self.get_connection()
        cursor = conn.cursor()
        
        # 1. Update screens table
        cursor.execute("""
            UPDATE screens 
            SET screenshot_path = ?,
                runtime_verified = 1
            WHERE id = ?
        """, (relative_path, screen_id))

        # 2. Insert into screenshot_registry
        cursor.execute("""
            INSERT INTO screenshot_registry (screen_id, screenshot_path, description, created_at)
            VALUES (?, ?, ?, ?)
        """, (screen_id, relative_path, description, datetime.now().isoformat()))

        conn.commit()
        conn.close()

if __name__ == '__main__':
    handler = ScreenshotHandler()
    screens = handler.get_screens_to_capture(limit=3)
    print(f"Loaded {len(screens)} screens from governance.db.")
    for s in screens:
        print(f" - {s['app_code']} | {s['role_code']} | {s['screen_name']} ({s['route_path']})")
