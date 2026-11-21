"""Render the read-only HTML5 class explorer from a recorded class catalog."""

import argparse
import json
from pathlib import Path
from organization import PRIMARY_TYPES

ROOT = Path(__file__).resolve().parents[2]


def safe_json(value):
    return (
        json.dumps(value, ensure_ascii=False)
        .replace("<", "\\u003c")
        .replace(">", "\\u003e")
        .replace("&", "\\u0026")
    )


def theme(palette, dark=False):
    grey = palette["grey"]
    common = palette["common"]
    background = palette["background"]
    return {
        "bg": background["default"],
        "surface": background["paper"],
        "text": palette["text"]["primary"],
        "muted": palette["text"]["secondary"],
        "line": palette["divider"],
        "soft": grey["800"] if dark else grey["100"],
        "accent": palette["info"]["light"] if dark else palette["info"]["dark"],
        "onAccent": grey["900"] if dark else common["white"],
        "nav": grey["900"],
        "navText": common["white"],
        "navHover": grey["800"],
        "backdrop": palette["action"]["disabledBackground"],
    }


def render(value):
    palettes = json.loads((ROOT / "scripts/primecare_presets.json").read_text())
    light = theme(palettes["default"])
    dark = theme(palettes["defaultDark"], True)
    html = Path(__file__).with_name("dashboard.html").read_text()
    # Replace template tokens before embedding untrusted descriptions. A source
    # comment containing a token must remain data and never become executable.
    html = html.replace(
        "__THEME__", ";".join("--" + key + ":" + item for key, item in light.items())
    )
    for key, item in [
        ("__PRIMARY_TYPES__", PRIMARY_TYPES),
        ("__LIGHT_THEME__", light),
        ("__DARK_THEME__", dark),
    ]:
        html = html.replace(key, safe_json(item))
    return html.replace("__CATALOG__", safe_json(value))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--catalog", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    value = json.loads(args.catalog.read_text())
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(render(value))
    print(
        json.dumps(
            {
                "classes": len(value["classes"]),
                "databaseReadback": value.get("dataKind") == "production_readback",
            }
        )
    )


if __name__ == "__main__":
    main()
