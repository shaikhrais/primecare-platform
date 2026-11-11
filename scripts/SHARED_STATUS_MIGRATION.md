# Shared status migration

Preview: `python3 scripts/migrate-shared-status.py --add-imports`

Apply: `python3 scripts/migrate-shared-status.py --add-imports --apply`

The tool scans shared feature and screen libraries. It replaces exact generated
red error icons, grey inbox icons and `state.error!` messages with shared semantic
controls. Error and muted colors resolve from the active product theme. Existing
const parents, numeric icon sizes, message expressions and inherited typography
remain intact. Optional narrow imports are added only inside this package.

Unknown colors, other icon meanings, concrete Icon/Text types, keys, custom styles,
semantic labels and comments inside argument lists are skipped. Existing screen
callbacks, error conditions and data-cy wrappers remain untouched. The strict
boundary gate still rejects all remaining literal colors; this is a conservative
lexical migration and does not establish screen runtime acceptance.
