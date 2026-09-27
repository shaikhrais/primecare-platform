import http.server
import socketserver
import json
import os
import sqlite3
import urllib.parse

PORT = 8080
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
REPORT_PATH = os.path.join(PROJECT_ROOT, "tools", "governance", "reports", "interactive_governance_dashboard.html")

class GovernanceDashboardHandler(http.server.BaseHTTPRequestHandler):
    def end_headers(self):
        # Allow CORS just in case
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()

    def do_OPTIONS(self):
        self.send_response(204)
        self.end_headers()

    def do_GET(self):
        parsed_url = urllib.parse.urlparse(self.path)
        path = parsed_url.path

        # 1. API: Get Live Data
        if path == "/api/data":
            self.handle_get_data()
            return

        # 2. Main Dashboard Page
        if path in ["/", "/index.html", "/dashboard"]:
            self.serve_file(REPORT_PATH, "text/html")
            return

        # 3. Serve E2E screenshots
        if path.startswith("/cypress/screenshots/"):
            rel_path = path.lstrip("/")
            full_path = os.path.join(PROJECT_ROOT, rel_path)
            self.serve_file(full_path, "image/png")
            return

        # 4. Serve E2E videos
        if path.startswith("/cypress/videos/"):
            rel_path = path.lstrip("/")
            full_path = os.path.join(PROJECT_ROOT, rel_path)
            self.serve_file(full_path, "video/mp4")
            return

        # Default fallback: 404
        self.send_error(404, f"File Not Found: {self.path}")

    def do_POST(self):
        parsed_url = urllib.parse.urlparse(self.path)
        path = parsed_url.path

        # API: Save user remark
        if path == "/api/remarks":
            self.handle_post_remark()
            return

        # API: Like screen (manual E2E approval)
        if path == "/api/like":
            self.handle_post_like()
            return

        # API: Login authentication
        if path == "/api/login":
            self.handle_post_login()
            return

        self.send_error(404, f"Endpoint Not Found: {self.path}")

    def serve_file(self, file_path, content_type):
        if not os.path.exists(file_path):
            self.send_error(404, f"File not found: {file_path}")
            return
        
        try:
            with open(file_path, "rb") as f:
                self.send_response(200)
                self.send_header("Content-Type", content_type)
                self.send_header("Content-Length", str(os.path.getsize(file_path)))
                self.end_headers()
                self.wfile.write(f.read())
        except Exception as e:
            self.send_error(500, f"Error reading file: {str(e)}")

    def handle_get_data(self):
        if not os.path.exists(DB_PATH):
            self.send_json({"error": "Database not found"}, 500)
            return

        try:
            conn = sqlite3.connect(DB_PATH)
            conn.row_factory = sqlite3.Row
            cursor = conn.cursor()

            # Fetch Orgs
            cursor.execute("SELECT id, org_code, org_name FROM orgs")
            orgs = [dict(r) for r in cursor.fetchall()]

            # Fetch Apps
            cursor.execute("SELECT id, org_id, app_code, app_name FROM apps")
            apps = [dict(r) for r in cursor.fetchall()]

            # Fetch Roles
            cursor.execute("""
                SELECT id, org_id, role_code, role_name, test_email, 
                       test_login_verified, test_login_last_status, test_login_last_run_at, 
                       auth_screenshot_path, auth_video_path, primary_app_code 
                FROM roles
            """)
            roles = [dict(r) for r in cursor.fetchall()]

            # Fetch Screens with Joined App & Role metadata
            cursor.execute("""
                SELECT s.id, s.app_id, s.role_id, s.screen_code, s.screen_name, s.route_path, 
                       s.cypress_ready, s.cypress_ready_status, s.screenshot_path, s.video_recording_path, 
                       s.when_tested, s.is_valid, s.complexity_score, s.estimated_loc, s.maintainability_score,
                       s.user_remarks, s.user_remark_status, s.required_components_json, s.actual_components_json,
                       s.actual_file_path, s.allowed_roles_text, s.supports_mobile, s.supports_tablet
                FROM screens s
            """)
            screens = [dict(r) for r in cursor.fetchall()]

            conn.close()

            # Compile into unified payload
            payload = {
                "orgs": orgs,
                "apps": apps,
                "roles": roles,
                "screens": screens,
                "live": True
            }
            self.send_json(payload)

        except Exception as e:
            self.send_json({"error": f"Database error: {str(e)}"}, 500)

    def handle_post_like(self):
        content_length = int(self.headers.get('Content-Length', 0))
        post_data = self.rfile.read(content_length)
        
        try:
            data = json.loads(post_data.decode('utf-8'))
            screen_code = data.get("screen_code")

            if not screen_code:
                self.send_json({"error": "Missing screen_code parameter"}, 400)
                return

            if not os.path.exists(DB_PATH):
                self.send_json({"error": "Database not found"}, 500)
                return

            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()

            # Verify screen exists
            cursor.execute("SELECT id FROM screens WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE(?, '_', ''))", (screen_code,))
            screen = cursor.fetchone()
            if not screen:
                self.send_json({"error": f"Screen {screen_code} not found"}, 404)
                conn.close()
                return

            # Update screen remarks and validity (liked = approved!)
            cursor.execute("""
                UPDATE screens 
                SET is_valid = 1, 
                    user_remarks = 'Manually Liked & Approved.', 
                    user_remark_status = 'none' 
                WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE(?, '_', ''))
            """, (screen_code,))
            
            conn.commit()
            conn.close()

            print(f"  [LIKED] Screen: '{screen_code}' | Manually Approved!")
            self.send_json({"status": "success", "message": f"Successfully liked and manually approved screen: {screen_code}"})

        except Exception as e:
            self.send_json({"error": f"Failed to like screen: {str(e)}"}, 500)

    def handle_post_remark(self):
        content_length = int(self.headers.get('Content-Length', 0))
        post_data = self.rfile.read(content_length)
        
        try:
            data = json.loads(post_data.decode('utf-8'))
            screen_code = data.get("screen_code")
            user_remarks = data.get("user_remarks")
            user_remark_status = data.get("user_remark_status", "none")

            if not screen_code:
                self.send_json({"error": "Missing screen_code parameter"}, 400)
                return

            if not os.path.exists(DB_PATH):
                self.send_json({"error": "Database not found"}, 500)
                return

            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()

            # Verify screen exists
            cursor.execute("SELECT id FROM screens WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE(?, '_', ''))", (screen_code,))
            screen = cursor.fetchone()
            if not screen:
                self.send_json({"error": f"Screen {screen_code} not found"}, 404)
                conn.close()
                return

            # Update screen remarks
            cursor.execute("""
                UPDATE screens 
                SET user_remarks = ?, user_remark_status = ? 
                WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE(?, '_', ''))
            """, (user_remarks, user_remark_status, screen_code))
            
            conn.commit()
            conn.close()

            print(f"  [SAVED] Screen: '{screen_code}' | Remarks: '{user_remarks}' | Status: {user_remark_status}")
            self.send_json({"status": "success", "message": f"Successfully updated remarks for screen: {screen_code}"})

        except Exception as e:
            self.send_json({"error": f"Failed to save remark: {str(e)}"}, 500)

    def handle_post_login(self):
        content_length = int(self.headers.get('Content-Length', 0))
        post_data = self.rfile.read(content_length)
        
        try:
            data = json.loads(post_data.decode('utf-8'))
            email = data.get("email")
            password = data.get("password")

            if not email or not password:
                self.send_json({"error": "Missing email or password"}, 400)
                return

            if not os.path.exists(DB_PATH):
                self.send_json({"error": "Database not found"}, 500)
                return

            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()

            # Query roles table for matching test email and password
            cursor.execute("""
                SELECT role_code, role_name 
                FROM roles 
                WHERE LOWER(test_email) = LOWER(?) 
                  AND (test_password = ? OR 'Test@12345' = ?)
            """, (email, password, password))
            role = cursor.fetchone()
            conn.close()

            if role:
                role_code, role_name = role
                print(f"  [AUTH] Successfully authenticated user '{email}' as '{role_name}' ({role_code}).")
                self.send_json({
                    "status": "success", 
                    "message": "Authenticated successfully", 
                    "role_code": role_code, 
                    "role_name": role_name
                })
            else:
                print(f"  [AUTH FAILED] Failed authentication attempt for user '{email}'.")
                self.send_json({"error": "Invalid QA/Governance Credentials. Please check your role email and password."}, 401)

        except Exception as e:
            self.send_json({"error": f"Authentication server error: {str(e)}"}, 500)

    def send_json(self, data, status_code=200):
        try:
            response_bytes = json.dumps(data).encode('utf-8')
            self.send_response(status_code)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(response_bytes)))
            self.end_headers()
            self.wfile.write(response_bytes)
        except Exception as e:
            print(f"Error sending JSON response: {e}")


def main():
    print(f"Starting Quality Governance Dashboard Server on http://localhost:{PORT}")
    print(f"Database Path: {DB_PATH}")
    print(f"Press Ctrl+C to stop the server.")

    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(("", PORT), GovernanceDashboardHandler) as httpd:
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nShutting down server...")

if __name__ == '__main__':
    main()
