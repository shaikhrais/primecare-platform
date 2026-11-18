# PrimeCare HTML5 Dashboard Simulator

[Download the offline ZIP](PrimeCare-Dashboard-115-HTML5.zip), extract all files, and open `index.html` in a browser. Open `roles.html` for the role-by-role guide. No install, sign-in, or network is required.

- 115 dashboard pages, 61 catalog owner roles, 584 registered sections and 336 fictional task templates.
- Create and edit practice tasks without leaving the dashboard; start, block, complete and reopen tasks, filter/search, retain local history, and export or reset the current dashboard's practice data.
- The downloaded bundle contains the HTML5, CSS and JavaScript; `source/` contains the reproducible builder, task templates and shared runner.

This is an offline simulator, not a PrimeCare deployment. Use fictional information only. No production routes, permissions, API calls or clinical records are connected. Storage availability depends on the browser and context.

## Rebuild

Run `python3 docs/demos/primecare-dashboard-html5/source/build.py --out /tmp/primecare-dashboard-html5 --zip /tmp/PrimeCare-Dashboard-115-HTML5.zip` from a checkout containing the pinned source commit `c6772fc0a4b3500b4c5159ef777c9fd589dcc616`. Only the pinned checked-in catalog and the versioned fictional scenarios are used; the generator does not query databases or invoke business APIs.

Delivery checks: exact catalog/section parity, ZIP/local-link validation, and simulated DOM task-lifecycle checks on all 115 screens. Physical devices and production workflows were not tested.

Delivered ZIP SHA-256: `c899a1af1f2f50804dafb4b317a050788395f8a28ec7bd9f460f5ddf71c74f1d`.
