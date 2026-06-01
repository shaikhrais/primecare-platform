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

    # 1. Patch header to add 'Export Review Patch' button
    old_header_badge = """        <div id="statusBadge" class="server-status status-offline">
            <div class="pulse-dot"></div>
            <span id="statusText">Standalone Offline Mode</span>
        </div>"""

    new_header_badge = """        <div style="display:flex; gap:16px; align-items:center;">
            <button class="proof-btn" style="border-color: var(--neon-amber); color: var(--neon-amber); font-weight: 700; font-size:12px; padding: 8px 16px;" onclick="exportReviewPatch()">📥 Export Review Patch</button>
            <div id="statusBadge" class="server-status status-offline">
                <div class="pulse-dot"></div>
                <span id="statusText">Standalone Offline Mode</span>
            </div>
        </div>"""

    content = content.replace(old_header_badge, new_header_badge)

    # 2. Add 'exportReviewPatch' Javascript function after likeScreen definition
    old_like_func_end = """                        row.classList.remove("flash-success");
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

    new_export_func = """                        row.classList.remove("flash-success");
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
        }

        function exportReviewPatch() {
            const patch = [];
            DB.screens.forEach(screen => {
                const input = document.getElementById(`remark-${screen.screen_code}`);
                const select = document.getElementById(`status-${screen.screen_code}`);
                if (input && select) {
                    const text = input.value.trim();
                    // Include if user changed the remark text OR status
                    if (text !== (screen.user_remarks || "") || select.value !== (screen.user_remark_status || "none")) {
                        patch.push({
                            screen_code: screen.screen_code,
                            user_remarks: text,
                            user_remark_status: select.value
                        });
                    }
                }
            });

            if (patch.length === 0) {
                alert("ℹ️ No review changes detected. Type in any screen's remark input field or change a status before exporting!");
                return;
            }

            const dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(patch, null, 4));
            const downloadAnchor = document.createElement('a');
            downloadAnchor.setAttribute("href", dataStr);
            downloadAnchor.setAttribute("download", "primecare_review_patch.json");
            document.body.appendChild(downloadAnchor);
            downloadAnchor.click();
            downloadAnchor.remove();

            alert(`🎉 Success! Exported a review patch containing ${patch.length} screen remarks.\\n\\nSend the 'primecare_review_patch.json' file to the developers to merge into the SQLite governance registry!`);
        }"""

    content = content.replace(old_like_func_end, new_export_func)

    with open(HTML_PATH, "w", encoding="utf-8") as f:
        f.write(content)
    print("✨ Successfully patched interactive_governance_dashboard.html with 'Export Review Patch' crowdsourcing logic!")

if __name__ == '__main__':
    main()
