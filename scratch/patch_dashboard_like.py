import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
HTML_PATH = os.path.join(PROJECT_ROOT, "tools", "governance", "reports", "interactive_governance_dashboard.html")
SERVER_PATH = os.path.join(PROJECT_ROOT, "tools", "governance", "dashboard_server.py")

def patch_server():
    print(f"Patching Server: {SERVER_PATH}")
    if not os.path.exists(SERVER_PATH):
        print("Server file does not exist!")
        return False

    with open(SERVER_PATH, "r", encoding="utf-8") as f:
        content = f.read()

    # Add routing condition
    old_post_routing = """        # API: Save user remark
        if path == "/api/remarks":
            self.handle_post_remark()
            return"""

    new_post_routing = """        # API: Save user remark
        if path == "/api/remarks":
            self.handle_post_remark()
            return

        # API: Like screen (manual E2E approval)
        if path == "/api/like":
            self.handle_post_like()
            return"""
    
    content = content.replace(old_post_routing, new_post_routing)

    # Add handler method
    old_handle_post_remark = """    def handle_post_remark(self):"""
    new_handle_post_like_func = """    def handle_post_like(self):
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
            cursor.execute(\"\"\"
                UPDATE screens 
                SET is_valid = 1, 
                    user_remarks = 'Manually Liked & Approved.', 
                    user_remark_status = 'none' 
                WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE(?, '_', ''))
            \"\"\", (screen_code,))
            
            conn.commit()
            conn.close()

            print(f"  [LIKED] Screen: '{screen_code}' | Manually Approved!")
            self.send_json({"status": "success", "message": f"Successfully liked and manually approved screen: {screen_code}"})

        except Exception as e:
            self.send_json({"error": f"Failed to like screen: {str(e)}"}, 500)

    def handle_post_remark(self):"""
    
    content = content.replace(old_handle_post_remark, new_handle_post_like_func)

    with open(SERVER_PATH, "w", encoding="utf-8") as f:
        f.write(content)
    print("  ✓ Server successfully patched with /api/like POST API.")
    return True

def patch_html():
    print(f"Patching HTML: {HTML_PATH}")
    if not os.path.exists(HTML_PATH):
        print("HTML file does not exist!")
        return False

    with open(HTML_PATH, "r", encoding="utf-8") as f:
        content = f.read()

    # 1. Update row buttons
    old_row_actions = """                    <td>
                        <button class="save-btn" id="save-${screen.screen_code}" onclick="saveRemark('${screen.screen_code}')">Save inline</button>
                    </td>"""

    new_row_actions = """                    <td>
                        <div style="display:flex; flex-direction:column; gap:8px;">
                            <button class="save-btn" id="save-${screen.screen_code}" onclick="saveRemark('${screen.screen_code}')">Save</button>
                            <button class="proof-btn" style="border-color: var(--neon-pink); color: var(--neon-pink); justify-content: center; font-size:11px;" id="like-${screen.screen_code}" onclick="likeScreen('${screen.screen_code}')">❤️ Like</button>
                        </div>
                    </td>"""

    content = content.replace(old_row_actions, new_row_actions)

    # 2. Add JavaScript likeScreen handler
    old_auto_log_func = """        function autoLogMissingRemark(screenCode, type) {
            const remarkInput = document.getElementById(`remark-${screenCode}`);
            const statusSelect = document.getElementById(`status-${screenCode}`);

            if (remarkInput && statusSelect) {
                remarkInput.value = `Visual proof (${type}) not found on disk.`;
                statusSelect.value = "pending";
                updateSelectStyle(statusSelect);
                
                // Save to database automatically!
                saveRemark(screenCode);
            }
        }"""

    new_like_func = """        function autoLogMissingRemark(screenCode, type) {
            const remarkInput = document.getElementById(`remark-${screenCode}`);
            const statusSelect = document.getElementById(`status-${screenCode}`);

            if (remarkInput && statusSelect) {
                remarkInput.value = `Visual proof (${type}) not found on disk.`;
                statusSelect.value = "pending";
                updateSelectStyle(statusSelect);
                
                // Save to database automatically!
                saveRemark(screenCode);
            }
        }

        async function likeScreen(screenCode) {
            if (!isLiveMode) {
                alert("❌ Standalone Offline Mode: Manual liking is disabled. Start the dashboard server on http://localhost:8080 first!");
                return;
            }

            const likeBtn = document.getElementById(`like-${screenCode}`);
            const row = document.getElementById(`row-${screenCode}`);

            likeBtn.disabled = true;
            likeBtn.textContent = "Liking...";

            try {
                const response = await fetch('/api/like', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ screen_code: screenCode })
                });

                const result = await response.json();

                if (response.ok && result.status === 'success') {
                    // Update database local copy
                    const screenIdx = DB.screens.findIndex(s => s.screen_code === screenCode);
                    if (screenIdx !== -1) {
                        DB.screens[screenIdx].is_valid = 1;
                        DB.screens[screenIdx].user_remarks = 'Manually Liked & Approved.';
                        DB.screens[screenIdx].user_remark_status = 'none';
                    }

                    // Update UI fields
                    const remarkInput = document.getElementById(`remark-${screenCode}`);
                    const statusSelect = document.getElementById(`status-${screenCode}`);
                    if (remarkInput) remarkInput.value = 'Manually Liked & Approved.';
                    if (statusSelect) {
                        statusSelect.value = "none";
                        updateSelectStyle(statusSelect);
                    }

                    // Flashes success indicators
                    likeBtn.textContent = "Liked ❤️";
                    likeBtn.style.background = "var(--neon-pink)";
                    likeBtn.style.color = "white";
                    row.classList.add("flash-success");

                    // Trigger metric refresh
                    updateMetrics(DB.screens);

                    // Re-render row or refresh table to show updated Passed badge
                    setTimeout(() => {
                        likeBtn.disabled = false;
                        likeBtn.textContent = "❤️ Like";
                        likeBtn.style.background = "rgba(255,255,255,0.05)";
                        likeBtn.style.color = "var(--neon-pink)";
                        row.classList.remove("flash-success");
                        renderTable();
                    }, 1200);

                } else {
                    alert(`❌ Failed to like screen: ${result.error || 'Unknown error'}`);
                    likeBtn.disabled = false;
                    likeBtn.textContent = "❤️ Like";
                }
            } catch (err) {
                alert(`❌ Server Connection Error: ${err.message}`);
                likeBtn.disabled = false;
                likeBtn.textContent = "❤️ Like";
            }
        }"""

    content = content.replace(old_auto_log_func, new_like_func)

    with open(HTML_PATH, "w", encoding="utf-8") as f:
        f.write(content)
    print("  ✓ HTML dashboard successfully patched with '❤️ Like' buttons and JS click logic.")
    return True

def main():
    print("🚀 Patching Like Feature onto Dashboard System...")
    patched_s = patch_server()
    patched_h = patch_html()
    if patched_s and patched_h:
        print("🏁 Like Feature Patched Successfully!")

if __name__ == '__main__':
    main()
