"""Safety checks for the downloadable source-review dashboard."""

import json
import re
import subprocess
import tempfile
import unittest
from pathlib import Path
from render_dashboard import render
from test_catalog import catalog


class DashboardTest(unittest.TestCase):
    def test_untrusted_descriptions_cannot_close_embedded_json_script(self):
        value = catalog()
        value["classes"][0]["sourceDescription"] = (
            '</script><script>alert("bad")</script>&'
        )
        html = render(value)
        embedded = re.search(
            r'<script id="catalog" type="application/json">(.*?)</script>', html, re.S
        ).group(1)
        self.assertNotIn("<", embedded)
        self.assertEqual(json.loads(embedded), value)
        self.assertIn("Database status UNKNOWN", html)
        self.assertIn("reviewed:false", html)
        self.assertNotIn("innerHTML", html)

    def test_source_tokens_are_data_not_template_substitutions(self):
        value = catalog()
        value["classes"][0]["sourceDescription"] = (
            "__PRIMARY_TYPES__ __THEME__ __DARK_THEME__"
        )
        html = render(value)
        embedded = re.search(
            r'<script id="catalog" type="application/json">(.*?)</script>', html, re.S
        ).group(1)
        self.assertEqual(json.loads(embedded), value)
        self.assertIn("Types & classifications", html)
        self.assertIn("What drives the total?", html)
        self.assertIn('id="primaryType"', html)

    def test_dashboard_javascript_parses(self):
        html = render(catalog())
        script = re.findall(r"<script>(.*?)</script>", html, re.S)[0]
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / "dashboard.js"
            path.write_text(script)
            subprocess.run(
                ["node", "--check", str(path)], check=True, capture_output=True
            )


if __name__ == "__main__":
    unittest.main()
