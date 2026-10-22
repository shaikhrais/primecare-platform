"""Browser fixtures for focus handoff; no service or account access."""
import unittest
from playwright.sync_api import sync_playwright, expect
from tools.deployment.flutter_browser import fill_flutter_field


class FocusHandoffTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.playwright = sync_playwright().start()
        cls.browser = cls.playwright.chromium.launch()

    @classmethod
    def tearDownClass(cls):
        cls.browser.close()
        cls.playwright.stop()

    def test_waits_for_scrolling_and_delayed_focus_activation(self):
        page = self.browser.new_page(viewport={'width': 320, 'height': 640})
        try:
            page.set_content('''<style>input{margin-top:1200px;transition:transform .16s}</style>
              <input aria-label="fixture" type="password" onfocus="
                this.style.transform='translateY(-20px)';
                if(!window.activated){window.activated=true;setTimeout(()=>this.value='',90)}">
            ''')
            # Password inputs have no implicit textbox role in ordinary HTML.
            field = page.get_by_label('fixture')
            fill_flutter_field(page, field, 'fixture-proof')
            page.wait_for_timeout(150)
            expect(field).to_have_value('fixture-proof')
        finally:
            page.close()

    def test_rejects_lost_input_without_retrying_entry(self):
        page = self.browser.new_page()
        try:
            page.set_content('''<input aria-label="fixture" oninput="
              if(this.value){window.entries=(window.entries||0)+1;this.value=''}">''')
            with self.assertRaises(AssertionError):
                fill_flutter_field(page, page.get_by_label('fixture'), 'fixture-proof')
            self.assertEqual(page.evaluate('window.entries'), len('fixture-proof'))
        finally:
            page.close()


if __name__ == '__main__':
    unittest.main()
