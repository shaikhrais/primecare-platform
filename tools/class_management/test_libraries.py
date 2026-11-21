"""Package counts and class membership come from manifests, not class names."""

import json, tempfile, unittest
from pathlib import Path
from libraries import discover_libraries, library_binding


class LibraryTest(unittest.TestCase):
    def test_manifests_empty_libraries_and_source_groups_are_distinct(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            for path in [
                "packages/ui",
                "packages/empty",
                "packages/loose",
                "packages/ui/generated/client",
            ]:
                (root / path).mkdir(parents=True)
            (root / "packages/ui/pubspec.yaml").write_text("name: central_ui\n")
            (root / "packages/empty/package.json").write_text(
                json.dumps({"name": "empty_lib"})
            )
            (root / "packages/ui/generated/client/package.json").write_text(
                json.dumps({"name": "generated_client"})
            )
            items = discover_libraries(root)
            self.assertEqual(len(items), 4)
            self.assertEqual(sum(x["status"] == "manifest_declared" for x in items), 3)
            self.assertEqual(
                library_binding({"path": "packages/ui/generated/client/a.ts"}, items)[
                    "libraryName"
                ],
                "generated_client",
            )
            self.assertEqual(
                library_binding({"path": "packages/loose/a.dart"}, items)[
                    "libraryStatus"
                ],
                "source_group_only",
            )
            self.assertIsNone(
                library_binding({"path": "apps/client/a.dart"}, items)["libraryId"]
            )

    def test_invalid_manifest_does_not_become_a_fake_library(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            p = root / "packages/broken"
            p.mkdir(parents=True)
            (p / "package.json").write_text("{}")
            with self.assertRaises(ValueError):
                discover_libraries(root)


if __name__ == "__main__":
    unittest.main()
