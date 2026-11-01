# B12 original asset design

The existing 56 canonical SVG icons and seven assets are retained centrally. This batch inventories actual shared shell/navigation/component keys, adds original geometry for missing semantics, and derives web and Flutter render data from those same canonical files. There are no per-app asset copies and no third-party SVG parser/renderer dependency.

A strict build-time compiler accepts only bounded basic SVG geometry (svg/g/path/rect/circle/ellipse/line/polyline/polygon), supported numeric transforms, approved fills/strokes and an allowlisted path grammar. Script, external links, embedded images, CSS, event attributes and unknown elements/attributes fail. Generated web records and Dart data are reproducible mirrors; canonical SVGs remain the single authoring source. The native renderer consumes compiled path commands, not arbitrary SVG or network input.

Decorative assets are hidden from accessibility. Meaningful assets require a nonempty localized host-provided label; semantic key names are inventory metadata, not UI text. Directional glyphs declare RTL mirroring explicitly. Colours resolve from host theme tokens; external standalone SVG images retain their source palette and cannot inherit host CSS tint.

The shared web shell keeps its existing ShellIcon/navigationIcon API and CSS classes while mapping its known legacy keys to the original registry. Native shared defaults and B10 field/expand glyphs adopt the same source; other application-specific Material/Lucide uses remain inventoried migration work. Existing package asset keys and original constants stay compatible.

Production metadata adds optional asset presentation controls and the Prime original asset primitive before implementation. No business routes, grants, API, host activation or claim of trademark clearance is introduced. Human accessibility/localization/release and all-app migration remain explicit gates.
