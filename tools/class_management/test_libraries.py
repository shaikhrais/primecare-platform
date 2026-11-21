"""Package counts and class membership come from manifests, not class names."""

import json, tempfile, unittest
from pathlib import Path
from libraries import discover_libraries, library_binding, build_subpackages


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
            parent = next(item for item in items if item["name"] == "central_ui")
            child = next(item for item in items if item["name"] == "generated_client")
            self.assertEqual(child["parentLibraryId"], parent["id"])
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

    def test_deep_subpackages_keep_direct_and_descendant_counts_separate(self):
        library = {
            "id": "lib",
            "name": "ui",
            "path": "packages/ui",
            "pathPrefix": "packages/ui/",
            "status": "manifest_declared",
        }
        paths = [
            "packages/ui/lib/src/components/card.dart",
            "packages/ui/lib/src/components/inputs/field.dart",
            "packages/ui/test/card_test.dart",
        ]
        rows = [
            dict(
                path=path,
                primaryType="test" if "/test/" in path else "packages",
                **library_binding({"path": path}, [library]),
            )
            for path in paths
        ]
        nodes = build_subpackages(rows, [library])
        by_path = {node["relativePath"]: node for node in nodes}
        self.assertEqual(by_path["."]["totalDeclarations"], 3)
        self.assertEqual(by_path["lib/src/components"]["totalDeclarations"], 2)
        self.assertEqual(by_path["lib/src/components"]["directDeclarations"], 1)
        self.assertEqual(by_path["test"]["test"], 1)
        self.assertEqual(sum(node["directDeclarations"] for node in nodes), 3)
        self.assertIn(
            by_path["lib/src/components"]["id"], rows[1]["subpackageAncestors"]
        )
        other = dict(
            library, id="other", path="packages/other", pathPrefix="packages/other/"
        )
        self.assertNotEqual(
            library_binding({"path": paths[0]}, [library])["subpackageId"],
            library_binding(
                {"path": "packages/other/lib/src/components/card.dart"}, [other]
            )["subpackageId"],
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
