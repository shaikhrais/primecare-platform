"""Check the immutable tested candidate against current main, without logging tokens."""

import json, os, sys, urllib.request


def main():
    sha = os.environ.get("GITHUB_SHA", "")
    repo = os.environ.get("GITHUB_REPOSITORY", "")
    if (
        repo != "shaikhrais/primecare-platform"
        or os.environ.get("GITHUB_REF") != "refs/heads/main"
    ):
        raise SystemExit(
            "Class metadata writes require the approved repository and main branch"
        )
    if (
        os.environ.get("GITHUB_EVENT_NAME") == "workflow_dispatch"
        and os.environ.get("EXPECTED_MAIN") != sha
    ):
        raise SystemExit(
            "Manual production synchronization requires exact expected_main"
        )
    request = urllib.request.Request(
        "https://api.github.com/repos/" + repo + "/git/ref/heads/main",
        headers={
            "Authorization": "Bearer " + os.environ["GH_TOKEN"],
            "Accept": "application/vnd.github+json",
        },
    )
    try:
        with urllib.request.urlopen(request, timeout=30) as response:
            current = json.load(response)["object"]["sha"]
    except Exception:
        raise SystemExit("Unable to verify current main") from None
    if current != sha:
        raise SystemExit("Main advanced; rerun the latest verified source snapshot")
    print("Exact current main verified:", sha)


if __name__ == "__main__":
    main()
