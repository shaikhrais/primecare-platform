# Screen inheritance candidate inventory

`direct-widget-exceptions.json` records classes named `*Screen`, `*View` or
`*Page` that directly extend common Flutter or Riverpod widget bases in app and
shared UI/core library directories. Run `python3 scripts/check_screen_inheritance.py`
to report additions and removals by file, class and base. Review the changes and
run the same command with `--update-baseline` only when the inventory change is
intentional. CI checks the inventory on pull requests and main.

These are candidates for manual review, not approved adapters or a list of
verified route screens. Some are reusable components, public authentication
pages, or deliberately standalone views. The scan is textual: it can miss
indirect inheritance, other class names, generated routes and adapters, and can
match comments. It does not check registration, manager connections, routing,
permissions, translations or runtime behaviour. A clean result does not prove
that the application is managed or safe.

The current governed bases enforce an `AppShellBoundary` and apply inherited
feature settings. `ScreenInheritanceManager` reads theme, locale and direction;
`PrimeScreenInheritanceManager` additionally reads `PrimeTheme`. Neither is a
screen registration boundary. `GovernanceRouter` filters module routes by role,
but shared workspace routes and public authentication routes also need separate
review. Do not equate registration with authorization or migrate these candidates
by changing parent classes without testing their layout and behaviour.

`screen_manager.dart` contains a first, opt-in registration boundary. It checks
for a shell, a Flutter theme ancestor, locale/direction and media query before
building, and supplies the registered feature settings. These checks establish
only that those Flutter contexts exist; they do not prove PrimeCare-specific
providers or controls are connected. It is not connected to production routes,
does not cover public-page adapters, and has not yet been validated by Flutter
CI. Do not treat it as enforcement for existing screens.
