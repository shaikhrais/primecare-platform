import time
from selenium import webdriver
from selenium.webdriver.common.by import By

options = webdriver.ChromeOptions()
options.add_argument("--headless")
driver = webdriver.Chrome(options=options)

try:
    url = "https://primecare-auth.pages.dev/login?redirect_uri=https%3A%2F%2F6b56ab5a.primecare-clinic.pages.dev%2Foffices%2Fclinical%2Froles%2Fpsw%2Fdashboard&force_login=true"
    print(f"Navigating to {url}...")
    driver.get(url)
    time.sleep(5)
    
    print("Page Title:", driver.title)
    print("Page URL:", driver.current_url)
    
    # Try enabling semantics
    try:
        # Check shadow root recursively
        js = """
        var findPlaceholder = function(root) {
            if (!root) return null;
            var el = root.querySelector('flt-semantics-placeholder');
            if (el) return el;
            var all = root.querySelectorAll('*');
            for (var i = 0; i < all.length; i++) {
                var child = all[i];
                if (child.shadowRoot) {
                    var found = findPlaceholder(child.shadowRoot);
                    if (found) return found;
                }
            }
            return null;
        };
        var ph = findPlaceholder(document);
        if (ph) {
            ph.click();
            return true;
        }
        return false;
        """
        clicked = driver.execute_script(js)
        print("Shadow DOM click result:", clicked)
        time.sleep(2)
    except Exception as e:
        print("Error checking shadow DOM:", e)
        
    # Print semantic elements
    js_get_semantics = """
    var dumpSemantics = function(root) {
        if (!root) return [];
        var res = [];
        var all = root.querySelectorAll('*');
        for (var i = 0; i < all.length; i++) {
            var el = all[i];
            var label = el.getAttribute('aria-label');
            var text = el.textContent || '';
            if (label || text) {
                res.push({
                    tag: el.tagName,
                    label: label,
                    text: text.substring(0, 50)
                });
            }
            if (el.shadowRoot) {
                res = res.concat(dumpSemantics(el.shadowRoot));
            }
        }
        return res;
    };
    return dumpSemantics(document);
    """
    elements = driver.execute_script(js_get_semantics)
    print(f"Found {len(elements)} elements with labels or text:")
    for el in elements[:100]:
        try:
            print(f"  Tag: {el['tag']} | Label: {el['label']} | Text: {el['text'].strip()}")
        except Exception:
            pass
        
except Exception as e:
    print("Error:", e)
finally:
    driver.quit()
