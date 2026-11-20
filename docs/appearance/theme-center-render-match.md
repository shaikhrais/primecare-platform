# Cloud-rendered Theme Center comparison

The original Vite skeleton from the supplied ZIP ran in GitHub Actions run [44835438131](https://github.com/shaikhrais/primecare-platform/actions/runs/44835438131). Its actual SettingsPanel, FuseSettings, form controllers, PaletteSelector, CSS and bundled Geist font were rendered in Chromium at desktop (1440×1000), tablet (820×1180), and mobile (390×844), in light and dark modes. A reference-only entry host supplies local settings, a guest user hook and router context. Visual components and styles are unchanged. No production login/data or external browser traffic was used.

This is a render of the original settings components, rather than a claim that the authenticated business application ran unchanged. The source remains confined to a temporary cloud runner; no vendor component is imported by PrimeCare.

| Measured property | Original Fuse | Shared Dart target |
| --- | --- | --- |
| Drawer width | 380px, maximum 90vw | Same |
| Panel inset | 24px desktop/tablet; 16px phone | Same |
| Body typography | Geist 13px, 19.5px line height | Same font and metrics |
| Title | 18.5714px, weight 600, line height 29.7143px | 18.57px, weight 600, 1.6 line height |
| Layout groups | Navbar/Toolbar/Footer nested inside Layout | Same hierarchy |
| Group borders | 1px, 2px corner radius | Same |
| Group inset | 12px top/sides, 0 bottom | Same |
| Radio rows | 32px height | Same |
| Switch visual track | 28×16px, with 8px margin | Same visual size in SDK control |
| Container number field | 209×32px | Same |
| Section previews | 128×80px | Same schematic layout |
| Palette dialog | 600×552px desktop, 8px radius | Same target |
| Dialog header | 48px height | Same |
| Color inputs | 200×32px swatches | Same, native RGB/hex picker |
| Color preview | 200×162px | Same |

PrimeCare keeps its 22 combinations, per-user save/load/import/export, undo/redo and saved-theme library in collapsed utility sections. Those are product extensions to the reference. The phone palette dialog reflows vertically to remain usable rather than retaining the original wide browser form. Native focus, semantics and readable foreground protection remain in place. Cross-engine painting and native color-picker UI are not claimed to be pixel-identical.

The cloud capture workflow produces PNGs and actual Dart dimensions for verification. Capture files are transient CI artifacts; final user deliverables are saved separately.
