"""Keep architecture, ownership, declaration kind and application scope separate."""

import unittest
from organization import classify


class OrganizationTest(unittest.TestCase):
    def row(
        self,
        name="DashboardScreen",
        path="apps/primecare_client/lib/screens/dashboard_screen.dart",
        **extra,
    ):
        return {
            "name": name,
            "path": path,
            "baseName": "StatelessWidget",
            "managerId": "apps",
            "kind": "class",
            "scope": "source",
            **extra,
        }

    def test_screen_is_candidate_without_runtime_or_permission_claim(self):
        value = classify(self.row())
        self.assertEqual(value["architecturalRole"], "screen")
        self.assertEqual(value["appName"], "primecare_client")
        self.assertTrue(value["isAppClass"])
        self.assertEqual(value["runtimeReadiness"], "not_assessed")
        self.assertEqual(value["classificationStatus"], "inferred_needs_review")

    def test_screen_controller_model_routes_and_sections_are_not_screens(self):
        for name, role, extra in [
            ("DashboardScreenController", "controller", {}),
            ("DashboardScreenModel", "model", {}),
            (
                "DashboardScreenRoutes",
                "api_route",
                {"path": "services/client_api/lib/a.dart", "managerId": "services"},
            ),
            ("DashboardSection", "section", {}),
            (
                "_DashboardScreenState",
                "widget_state",
                {"baseName": "State<DashboardScreen>"},
            ),
        ]:
            self.assertEqual(
                classify(self.row(name=name, **extra))["architecturalRole"], role
            )

    def test_ui_ownership_is_not_a_screen_or_app_claim(self):
        value = classify(
            self.row(
                name="PrimeCard",
                path="packages/primecare_ui/lib/src/components/card.dart",
                managerId="ui",
            )
        )
        self.assertEqual(value["architecturalRole"], "ui_component")
        self.assertEqual(value["appClass"], "shared_package")
        self.assertFalse(value["isAppClass"])
        self.assertIsNone(value["appName"])

    def test_tests_vendor_and_unknown_are_explicit(self):
        value = classify(
            self.row(name="FakeScreen", path="apps/client/test/fake.dart", scope="test")
        )
        self.assertEqual(value["usageScope"], "test")
        self.assertEqual(value["architecturalRole"], "test_support")
        self.assertEqual(
            classify(self.row(managerId="external"))["appClass"], "external"
        )
        self.assertEqual(
            classify(self.row(name="Mystery", baseName="Object"))["architecturalRole"],
            "other",
        )

    def test_primary_type_groups_preserve_detailed_role(self):
        for name, expected in [
            ("DashboardScreen", "ui"),
            ("DashboardApi", "api"),
            ("BookingModel", "packages"),
            ("AppModule", "packages"),
            ("Settings", "packages"),
        ]:
            result = classify(
                self.row(
                    name=name,
                    baseName="StatelessWidget" if expected == "ui" else "Object",
                )
            )
            self.assertEqual(result["primaryType"], expected)
            self.assertTrue(result["architecturalRole"])
        value = classify(
            self.row(
                name="DashboardScreen", path="apps/client/test/dashboard_test.dart"
            )
        )
        self.assertEqual(value["primaryType"], "test")
        self.assertEqual(value["architecturalRole"], "screen")
        value = classify(
            self.row(
                name="Parser",
                path="tools/class_management/parser.py",
                managerId="tooling",
                baseName="object",
            )
        )
        self.assertEqual(value["primaryType"], "packages")

    def test_exact_four_types_and_central_ui_libraries_stay_packages(self):
        from organization import PRIMARY_TYPES

        self.assertEqual(set(PRIMARY_TYPES), {"ui", "api", "test", "packages"})
        value = classify(
            self.row(
                name="PrimeCard",
                path="packages/primecare_ui/lib/card.dart",
                managerId="ui",
            )
        )
        self.assertEqual(value["primaryType"], "packages")
        self.assertEqual(value["architecturalRole"], "ui_component")
        value = classify(
            self.row(
                name="PrimeCard",
                path="packages/primecare_ui/test/card_test.dart",
                managerId="ui",
            )
        )
        self.assertEqual(value["primaryType"], "test")

    def test_generated_location_is_a_hint_not_verified_generation(self):
        value = classify(
            self.row(
                path="apps/client/lib/generated_screens/dashboard/dashboard_screen.dart"
            )
        )
        self.assertEqual(value["sourceOrigin"], "generated_path_hint")
        self.assertTrue(value["isGeneratedPathHint"])
        self.assertEqual(value["classificationVersion"], 5)
        self.assertEqual(classify(self.row())["sourceOrigin"], "unmarked_source")

    def test_api_client_and_platform_module_are_distinct(self):
        self.assertEqual(
            classify(self.row(name="SchedulerApi", baseName="Object"))[
                "architecturalRole"
            ],
            "api_client",
        )
        self.assertEqual(
            classify(self.row(name="GovernanceModule", baseName="PlatformModule"))[
                "architecturalRole"
            ],
            "module",
        )
        self.assertEqual(
            classify(
                self.row(
                    name="RegistryTest",
                    path="tools/class_management/test_registry.py",
                    baseName="unittest.TestCase",
                )
            )["architecturalRole"],
            "test_support",
        )

    def test_declaration_kind_is_independent_of_role(self):
        self.assertEqual(
            classify(self.row(name="States", kind="enum"))["architecturalRole"],
            "data_contract",
        )


if __name__ == "__main__":
    unittest.main()
