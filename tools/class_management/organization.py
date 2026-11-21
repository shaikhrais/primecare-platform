"""Explainable architecture labels; ownership and verified runtime state are unchanged."""

import re
from pathlib import PurePosixPath

ROLE_LABELS = {
    "screen": "Screens / pages (candidates)",
    "section": "Screen sections / panels",
    "ui_component": "UI components / widgets",
    "widget_state": "Widget lifecycle state",
    "view_model": "View models / state controllers",
    "controller": "Controllers",
    "model": "Models / DTOs / entities",
    "repository": "Repositories",
    "service": "Services / clients / adapters",
    "api_client": "API client classes",
    "module": "Application / platform modules",
    "api_route": "API routes / handlers",
    "navigation": "Navigation / routes",
    "theme": "Theme / design tokens",
    "manager": "Managers / registries",
    "configuration": "Configuration / settings",
    "data_contract": "Enums / interfaces / mixins",
    "test_support": "Test support / fakes",
    "external": "Vendor / generated dependencies",
    "other": "Other / needs classification",
}


PRIMARY_TYPES = {
    "ui": ("UI", "Screens, sections, widgets, UI state, navigation and theme."),
    "api": (
        "API & services",
        "API clients, backend routes and service/transport adapters; not an endpoint count.",
    ),
    "data": ("Data", "Models, DTOs, repositories and language contracts."),
    "application": ("Application", "Application and platform module composition."),
    "platform": ("Platform", "Managers, registries and configuration."),
    "test": (
        "Test",
        "Declarations in test/fixture source, regardless of their detailed role.",
    ),
    "tooling": ("Tooling", "Non-test scanners, generators and maintenance scripts."),
    "external": ("External", "Declared vendor/generated dependency ownership scope."),
    "other": ("Needs review", "No supported primary type rule matched."),
}


def primary_type(role, app_class, test):
    if test:
        return "test", "Test/fixture source takes precedence over architecture role."
    if app_class == "external":
        return "external", "Declared external source scope."
    if app_class == "tooling":
        return "tooling", "Non-test tooling source location."
    if role in {"model", "repository", "data_contract"}:
        return "data", "Data architecture role."
    if role in {"api_client", "api_route", "service"}:
        return "api", "API/service architecture role."
    if role in {
        "screen",
        "section",
        "ui_component",
        "widget_state",
        "view_model",
        "controller",
        "navigation",
        "theme",
    }:
        return "ui", "Presentation architecture role."
    if role == "module":
        return "application", "Application/platform composition role."
    if role in {"manager", "configuration"}:
        return "platform", "Management/configuration role."
    if app_class == "backend":
        return "api", "Backend source location; detailed role still unresolved."
    return "other", "No supported primary type evidence; manual review required."


def classify(row):
    """Use ordered name/path/base evidence, never claim a route or behavior is verified."""
    path = PurePosixPath(row["path"])
    parts = path.parts
    name = row["name"].split(".")[-1].lstrip("_")
    base = re.split(r"[<\[]", row.get("baseName") or "")[0].split(".")[-1]
    root = parts[0] if parts else ""
    container = parts[1] if len(parts) > 1 else None
    test = (
        row.get("scope") == "test"
        or any(p in {"test", "tests", "fixtures"} for p in parts)
        or path.name.startswith("test_")
        or path.stem.endswith("_test")
    )
    if row.get("managerId") == "external":
        app_class = "external"
    elif root == "apps":
        app_class = "application"
    elif root == "websites":
        app_class = "website"
    elif root in {"services", "cloudflare"}:
        app_class = "backend"
    elif root in {"tools", "scripts"}:
        app_class = "tooling"
    elif root == "packages":
        app_class = "shared_package"
    else:
        app_class = "unknown"
    widget = bool(re.search(r"(Widget|Screen|Page)$", base))
    role, evidence = "other", "No supported role rule matched; manual review required."
    rules = [
        (
            "external",
            row.get("managerId") == "external",
            "Declared external ownership scope.",
        ),
        (
            "data_contract",
            row.get("kind") in {"enum", "mixin", "interface"},
            "AST declaration kind.",
        ),
        (
            "test_support",
            (
                name.startswith(("Mock", "Fake", "Stub"))
                or name.endswith(("Test", "Tests"))
                or base in {"TestCase", "Fake"}
            )
            and test,
            "Test scope and fake/mock/stub name.",
        ),
        (
            "widget_state",
            name.endswith("State") and (base.endswith("State") or base == "State"),
            "State suffix and Flutter state base.",
        ),
        (
            "view_model",
            bool(re.search(r"(ViewModel|Notifier|Cubit|Bloc|Provider)$", name)),
            "ViewModel/state-management suffix.",
        ),
        ("controller", name.endswith("Controller"), "Controller suffix; not a screen."),
        ("repository", name.endswith("Repository"), "Repository suffix."),
        (
            "api_route",
            app_class == "backend"
            and bool(re.search(r"(Routes|Router|Route|Handler|Middleware)$", name)),
            "Backend scope and route/handler suffix; no endpoint acceptance inferred.",
        ),
        (
            "navigation",
            bool(re.search(r"(Routes|Router|Route|Navigator|RouteDelegate)$", name)),
            "Navigation suffix; not a screen.",
        ),
        (
            "model",
            bool(
                re.search(
                    r"(Model|Dto|DTO|Entity|Request|Response|Record|Payload|Result|Event|Exception|Error)$",
                    name,
                )
            )
            or any(p in {"models", "entities", "dto", "dtos"} for p in parts),
            "Data-model path or suffix.",
        ),
        (
            "screen",
            bool(re.search(r"(Screen|Page|View)$", name))
            and (
                widget
                or any(
                    p in {"screens", "pages", "views", "generated_screens"}
                    for p in parts
                )
            ),
            "Screen/page/view name with widget-base or presentation-path evidence; route binding unverified.",
        ),
        (
            "section",
            bool(re.search(r"(Section|Panel)$", name))
            and (widget or "sections" in parts),
            "Presentation section/panel; not a whole screen.",
        ),
        ("theme", row.get("managerId") == "theme", "Theme manager scope."),
        (
            "ui_component",
            widget
            or (
                row.get("managerId") in {"ui", "foundation"}
                and bool(
                    re.search(
                        r"(Widget|Card|Button|Field|Dialog|Table|Chart|Bar|Layout)$",
                        name,
                    )
                )
            ),
            "Widget base or UI-component name in UI scope.",
        ),
        (
            "api_client",
            bool(re.search(r"(Api|API)$", name)),
            "API client suffix; not an API route or endpoint acceptance claim.",
        ),
        (
            "module",
            name.endswith("Module") or base == "PlatformModule",
            "Application/platform module suffix or base.",
        ),
        (
            "service",
            bool(
                re.search(r"(Service|Client|Adapter|Gateway|Transport|Channel)$", name)
            ),
            "Service/client/adapter suffix.",
        ),
        (
            "manager",
            bool(re.search(r"(Manager|Registry)$", name)),
            "Manager/registry suffix; does not confer ownership.",
        ),
        (
            "configuration",
            bool(re.search(r"(Config|Configuration|Settings|Options)$", name)),
            "Configuration/settings suffix.",
        ),
    ]
    for candidate, matches, reason in rules:
        if matches:
            role, evidence = candidate, reason
            break
    primary, primary_evidence = primary_type(role, app_class, test)
    generated_hint = any(
        part in {"generated", "generated_screens", "gen"} for part in parts
    ) or path.name.endswith((".g.dart", ".freezed.dart"))
    origin = (
        "test"
        if test
        else "external_scope"
        if app_class == "external"
        else "generated_path_hint"
        if generated_hint
        else "unmarked_source"
    )
    return {
        "primaryType": primary,
        "primaryTypeLabel": PRIMARY_TYPES[primary][0],
        "primaryTypeEvidence": primary_evidence,
        "sourceOrigin": origin,
        "isGeneratedPathHint": generated_hint,
        "appClass": app_class,
        "isAppClass": app_class in {"application", "website"},
        "appName": container if app_class in {"application", "website"} else None,
        "sourceContainer": "/".join(parts[:2]) if len(parts) > 1 else root,
        "architecturalRole": role,
        "architecturalRoleLabel": ROLE_LABELS[role],
        "classificationStatus": "inferred_needs_review",
        "classificationEvidence": evidence,
        "classificationVersion": 3,
        "usageScope": "test" if test else "source",
        "runtimeReadiness": "not_assessed",
    }
