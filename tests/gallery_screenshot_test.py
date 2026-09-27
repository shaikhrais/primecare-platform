import os
import sys
import unittest

# Ensure scripts directory is in path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'scripts')))

from screenshot_handler import ScreenshotHandler
from report_handler import ReportHandler

class GalleryScreenshotTest(unittest.TestCase):
    """
    Automated test runner that:
    1. Loads screens from single source of truth SQLite DB (.agents/governance/governance.db).
    2. Uses ScreenshotHandler to navigate routes, capture actual screenshots, and store image files.
    3. Persists screenshot paths and verification tags into governance.db.
    4. Uses ReportHandler to regenerate regression_report.html and docs/gallery/index.html.
    """

    @classmethod
    def setUpClass(cls):
        cls.screenshot_handler = ScreenshotHandler()
        cls.report_handler = ReportHandler()

    @classmethod
    def tearDownClass(cls):
        cls.screenshot_handler.quit_driver()

    def test_01_verify_database_connectivity(self):
        screens = self.screenshot_handler.get_screens_to_capture(limit=10)
        self.assertGreater(len(screens), 0, "Failed to load active screens from governance.db")

    def test_02_capture_sample_screenshots_and_update_db(self):
        # Capture screenshots for a representative batch of screens
        screens = self.screenshot_handler.get_screens_to_capture(limit=5)
        captured_count = 0

        for screen in screens:
            success, result = self.screenshot_handler.capture_screen(screen)
            if success:
                captured_count += 1
                # Verify that DB was updated with relative screenshot path
                screens_check = self.screenshot_handler.get_screens_to_capture()
                match = next((s for s in screens_check if s['id'] == screen['id']), None)
                self.assertIsNotNone(match)
                self.assertEqual(match['screenshot_path'], result)

        self.assertGreater(captured_count, 0, "No screenshots were captured successfully")

    def test_03_generate_gallery_reports(self):
        r1, r2 = self.report_handler.generate_report()
        self.assertTrue(os.path.exists(r1), f"Report file missing: {r1}")
        self.assertTrue(os.path.exists(r2), f"Report file missing: {r2}")

if __name__ == '__main__':
    unittest.main()
