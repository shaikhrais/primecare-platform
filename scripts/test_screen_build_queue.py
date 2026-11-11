"""Isolated parser fixtures only; no production credentials or database."""
import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location("queue_check", Path(__file__).with_name("check_screen_build_queue.py"))
check = importlib.util.module_from_spec(spec)
spec.loader.exec_module(check)

class BuildQueueTests(unittest.TestCase):
    def test_literal_set(self):
        self.assertEqual(check.set_paths("const x = <String>{ '/a', // comment\n '/b', };", "x"), ["/a", "/b"])

    def test_double_slashes_are_preserved_inside_route_literals(self):
        text = "const x = <String>{ '/generated//clinic/dashboard', // comment\n '/b//c', };"
        self.assertEqual(check.set_paths(text, 'x'), ['/generated//clinic/dashboard', '/b//c'])

    def test_interpolation_escapes_and_invalid_separators_fail(self):
        for body in ("'/a$variable',", r"'/a\\b',", "'/a' '/b'", ", '/a'", "'/a',,", "'/a', ...other"):
            with self.subTest(body=body), self.assertRaises(ValueError):
                check.set_paths('const x = <String>{' + body + '};', 'x')

    def test_unresolved_expression_and_duplicates_fail(self):
        for text in ("const x = <String>{ '/a', dynamicPath };",
                     "const x = <String>{ '/a', '/a' };", "no declaration"):
            with self.assertRaises(ValueError):
                check.set_paths(text, "x")

    def queue(self):
        return {"count_unit": "unique_registered_route_paths_not_verified_screens",
                "entries": [{"number": 1, "path": "/fixture", "sources": ["fixture.dart"],
                             "status": "awaiting_production_contract"}]}

    def test_valid_fixture_is_not_screen_completion(self):
        self.assertEqual(check.validate(self.queue(), {"/fixture": {"fixture.dart"}}), 1)

    def test_missing_stale_wrong_source_and_duplicate_fail(self):
        for expected in ({}, {"/new": {"fixture.dart"}}, {"/fixture": {"other.dart"}}):
            with self.assertRaises(ValueError):
                check.validate(self.queue(), expected)
        queue = self.queue()
        queue["entries"].append(dict(queue["entries"][0], number=2))
        with self.assertRaises(ValueError):
            check.validate(queue, {"/fixture": {"fixture.dart"}})

    def test_renumber_and_false_screen_count_fail(self):
        queue = self.queue()
        queue["entries"][0]["number"] = 2
        with self.assertRaises(ValueError):
            check.validate(queue, {"/fixture": {"fixture.dart"}})
        queue = self.queue()
        queue["count_unit"] = "verified_screens"
        with self.assertRaises(ValueError):
            check.validate(queue, {"/fixture": {"fixture.dart"}})

    def test_retired_entry_preserves_number_without_being_active(self):
        queue = self.queue()
        queue["entries"][0]["status"] = "retired"
        self.assertEqual(check.validate(queue, {}), 0)

if __name__ == "__main__":
    unittest.main()

