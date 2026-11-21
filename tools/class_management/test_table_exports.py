"""Verify complete row exports and safe spreadsheet text."""

import csv
import tempfile
import unittest
from pathlib import Path
from export_tables import export, safe
from test_catalog import catalog


class TableExportTest(unittest.TestCase):
    def test_all_declarations_and_app_attributes_are_exported(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            value = catalog()
            export(value, root)
            with (root / "all-class-attributes.csv").open(encoding="utf-8-sig") as file:
                rows = list(csv.DictReader(file))
            self.assertEqual(len(rows), len(value["classes"]))
            self.assertEqual(rows[0]["appClass"], "shared_package")
            self.assertEqual(rows[0]["isAppClass"], "False")
            with (root / "architectural-roles.csv").open(encoding="utf-8-sig") as file:
                self.assertEqual(
                    sum(int(row["count"]) for row in csv.DictReader(file)), len(rows)
                )

    def test_csv_text_cannot_become_a_spreadsheet_formula(self):
        for text in ["=1+2", "+2", "-3", "@SUM(A1)", "\t=1", "\r=2"]:
            self.assertTrue(safe(text).startswith("'"))
        self.assertEqual(safe("ClassName"), "ClassName")


if __name__ == "__main__":
    unittest.main()
