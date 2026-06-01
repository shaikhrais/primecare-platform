import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
HTML_PATH = os.path.join(PROJECT_ROOT, "tools", "governance", "reports", "interactive_governance_dashboard.html")

def main():
    print(f"Reading HTML file: {HTML_PATH}")
    if not os.path.exists(HTML_PATH):
        print("HTML file does not exist!")
        return

    with open(HTML_PATH, "r", encoding="utf-8") as f:
        content = f.read()

    # 1. Update onclick showScreenshot call to include screen_code
    old_screenshot_click = "onclick=\"showScreenshot('${screen.screenshot_path}', '${screen.screen_name}')\""
    new_screenshot_click = "onclick=\"showScreenshot('${screen.screenshot_path}', '${screen.screen_name}', '${screen.screen_code}')\""
    content = content.replace(old_screenshot_click, new_screenshot_click)

    # 2. Update onclick showVideo call to include screen_code
    old_video_click = "onclick=\"showVideo('${screen.video_recording_path}', '${screen.screen_name}')\""
    new_video_click = "onclick=\"showVideo('${screen.video_recording_path}', '${screen.screen_name}', '${screen.screen_code}')\""
    content = content.replace(old_video_click, new_video_click)

    # 3. Replace the entire showScreenshot function definition
    old_show_screenshot_func = """        function showScreenshot(url, screenName) {
            const modal = document.getElementById("previewModal");
            const modalTitle = document.getElementById("modalTitle");
            const modalBody = document.getElementById("modalBody");

            modalTitle.textContent = `Screenshot Proof: ${screenName}`;
            // Prepend slash or server host if relative
            const finalUrl = isLiveMode ? `/${url}` : url;
            modalBody.innerHTML = `<img src="${finalUrl}" alt="${screenName} screenshot" onerror="this.src='https://via.placeholder.com/600x400/0f172a/ffffff?text=Visual+Proof+Not+Found'">`;
            
            modal.classList.add("active");
        }"""

    new_show_screenshot_func = """        async function showScreenshot(url, screenName, screenCode) {
            const modal = document.getElementById("previewModal");
            const modalTitle = document.getElementById("modalTitle");
            const modalBody = document.getElementById("modalBody");

            modalTitle.textContent = `Screenshot Proof: ${screenName}`;
            modalBody.innerHTML = `<div class="flex-center" style="padding: 40px; color: var(--text-secondary);"><span class="pulse-dot"></span> Loading visual proof...</div>`;
            modal.classList.add("active");

            const img = new Image();
            const finalUrl = isLiveMode ? `/${url}` : url;
            img.src = finalUrl;

            img.onload = () => {
                modalBody.innerHTML = "";
                modalBody.appendChild(img);
            };

            img.onerror = () => {
                modalBody.innerHTML = `
                    <div style="text-align: center; padding: 40px; color: var(--neon-pink);">
                        <div style="font-size: 48px; margin-bottom: 16px;">⚠️</div>
                        <h3 style="font-family: 'Outfit', sans-serif; font-size: 20px; margin-bottom: 8px;">Visual Proof PNG Not Found</h3>
                        <p style="font-size: 13px; color: var(--text-secondary); max-width: 400px; margin: 0 auto 20px auto;">
                            No Cypress screenshot exists on disk at: <br><code style="background: rgba(255,255,255,0.05); padding: 4px; display: inline-block; margin-top: 6px; font-size: 11px; word-break: break-all;">\${url}</code>
                        </p>
                        <p style="font-size: 12px; color: var(--neon-green); font-weight: 600;">
                            ✓ Automatically logged 'Visual proof not found' in remarks!
                        </p>
                    </div>
                `;
                autoLogMissingRemark(screenCode, 'screenshot');
            };
        }"""
    content = content.replace(old_show_screenshot_func, new_show_screenshot_func)

    # 4. Replace the entire showVideo function definition
    old_show_video_func = """        function showVideo(url, screenName) {
            const modal = document.getElementById("previewModal");
            const modalTitle = document.getElementById("modalTitle");
            const modalBody = document.getElementById("modalBody");

            modalTitle.textContent = `E2E Cypress Video: ${screenName}`;
            const finalUrl = isLiveMode ? `/${url}` : url;
            modalBody.innerHTML = `
                <video controls autoplay>
                    <source src="${finalUrl}" type="video/mp4">
                    Your browser does not support the video tag.
                </video>
            `;
            
            modal.classList.add("active");
        }"""

    new_show_video_func = """        async function showVideo(url, screenName, screenCode) {
            const modal = document.getElementById("previewModal");
            const modalTitle = document.getElementById("modalTitle");
            const modalBody = document.getElementById("modalBody");

            modalTitle.textContent = `E2E Cypress Video: ${screenName}`;
            modalBody.innerHTML = `<div class="flex-center" style="padding: 40px; color: var(--text-secondary);"><span class="pulse-dot"></span> Verifying video stream...</div>`;
            modal.classList.add("active");

            const finalUrl = isLiveMode ? `/${url}` : url;

            try {
                const response = await fetch(finalUrl, { method: 'HEAD' });
                if (response.ok) {
                    modalBody.innerHTML = `
                        <video controls autoplay>
                            <source src="\${finalUrl}" type="video/mp4">
                            Your browser does not support the video tag.
                        </video>
                    `;
                } else {
                    throw new Error("File not found");
                }
            } catch (err) {
                modalBody.innerHTML = `
                    <div style="text-align: center; padding: 40px; color: var(--neon-pink);">
                        <div style="font-size: 48px; margin-bottom: 16px;">🎬</div>
                        <h3 style="font-family: 'Outfit', sans-serif; font-size: 20px; margin-bottom: 8px;">Visual Proof MP4 Not Found</h3>
                        <p style="font-size: 13px; color: var(--text-secondary); max-width: 400px; margin: 0 auto 20px auto;">
                            No Cypress E2E video exists on disk at: <br><code style="background: rgba(255,255,255,0.05); padding: 4px; display: inline-block; margin-top: 6px; font-size: 11px; word-break: break-all;">\${url}</code>
                        </p>
                        <p style="font-size: 12px; color: var(--neon-green); font-weight: 600;">
                            ✓ Automatically logged 'Visual proof not found' in remarks!
                        </p>
                    </div>
                `;
                autoLogMissingRemark(screenCode, 'video');
            }
        }"""
    content = content.replace(old_show_video_func, new_show_video_func)

    # 5. Insert autoLogMissingRemark function after closeModal()
    old_close_modal_func = """        function closeModal() {
            const modal = document.getElementById("previewModal");
            const modalBody = document.getElementById("modalBody");
            // Stop video playing by clearing HTML
            modalBody.innerHTML = "";
            modal.classList.remove("active");
        }"""

    new_close_modal_func = """        function closeModal() {
            const modal = document.getElementById("previewModal");
            const modalBody = document.getElementById("modalBody");
            // Stop video playing by clearing HTML
            modalBody.innerHTML = "";
            modal.classList.remove("active");
        }

        function autoLogMissingRemark(screenCode, type) {
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
    content = content.replace(old_close_modal_func, new_close_modal_func)

    with open(HTML_PATH, "w", encoding="utf-8") as f:
        f.write(content)
    print("✨ Successfully patched interactive_governance_dashboard.html with E2E file checks and auto-remarks!")

if __name__ == '__main__':
    main()
