/** Original structural CSS; all surface colours inherit from PrimeCare tokens. */
export const workspaceLayoutStyles = `
[data-pc-workspace] { display:grid!important; grid-template-columns:var(--pc-nav-width) minmax(0,1fr); grid-template-areas:"nav toolbar" "nav stage" "nav footer"; grid-template-rows:auto 1fr auto; min-height:100dvh; width:100%; max-width:none; margin-inline:auto; gap:0; isolation:isolate; }
[data-pc-workspace] > [data-pc-slot] { min-width:0; min-height:0; box-sizing:border-box; }
[data-pc-workspace] > [data-pc-slot=nav] { grid-area:nav; position:sticky!important; inset:auto!important; top:0!important; width:100%!important; max-width:none; height:100dvh; overflow:auto; z-index:20; }
[data-pc-workspace] > [data-pc-slot=toolbar] { grid-area:toolbar; position:static!important; inset:auto!important; z-index:21; }
[data-pc-workspace][data-toolbar-style=sticky] > [data-pc-slot=toolbar] { position:sticky!important; top:0!important; }
[data-pc-workspace][data-toolbar=bottom][data-toolbar-style=sticky] > [data-pc-slot=toolbar] { top:auto!important; bottom:0!important; }
[data-pc-workspace] > [data-pc-slot=footer] { grid-area:footer; position:static!important; }
[data-pc-workspace][data-footer=sticky] > [data-pc-slot=footer] { position:sticky!important; bottom:var(--pc-footer-offset,0px)!important; z-index:19; }
[data-pc-workspace][data-footer=hidden] > [data-pc-slot=footer], [data-pc-workspace][data-navigation=hidden] > [data-pc-slot=nav] { display:none!important; }
[data-pc-workspace][data-container=boxed] { max-width:var(--pc-max-width); }
[data-pc-workspace][data-container=content] [data-pc-slot=main] { width:100%; max-width:var(--pc-max-width); margin-inline:auto; }
[data-pc-workspace] > [data-pc-stage] { grid-area:stage; display:grid; min-width:0; min-height:0; grid-template-areas:"top top top" "left main right" "bottom bottom bottom"; grid-template-columns:auto minmax(0,1fr) auto; grid-template-rows:auto 1fr auto; align-content:start; }
[data-pc-workspace] [data-pc-slot=main] { grid-area:main; min-width:0; min-height:0; box-sizing:border-box; }
[data-pc-workspace] [data-pc-dock] { display:flex; flex-direction:column; gap:var(--spacing-md,1rem); min-width:0; min-height:0; }
[data-pc-workspace] [data-pc-dock]:empty { display:none; }
[data-pc-workspace] [data-pc-dock=left] { grid-area:left; } [data-pc-workspace] [data-pc-dock=right] { grid-area:right; }
[data-pc-workspace] [data-pc-dock=top] { grid-area:top; } [data-pc-workspace] [data-pc-dock=bottom] { grid-area:bottom; }
[data-pc-workspace] [data-pc-panel] { box-sizing:border-box; width:min(var(--pc-panel-width),100%); max-width:100%; min-width:0; overflow:auto; background:var(--color-surface); color:var(--color-text); border:1px solid var(--color-border); border-radius:var(--radius-md); }
[data-pc-workspace] [data-pc-dock=left] > [data-pc-panel], [data-pc-workspace] [data-pc-dock=right] > [data-pc-panel] { width:var(--pc-panel-width); }
[data-pc-workspace] [data-pc-panel][data-panel-dock=floating] { position:fixed; left:var(--pc-panel-x); top:var(--pc-panel-y); width:var(--pc-panel-width); height:var(--pc-panel-height); max-height:calc(100dvh - 16px); z-index:30; }
[data-pc-workspace] [data-layout-drag], [data-pc-workspace] [data-layout-resize] { touch-action:none; }
[data-pc-workspace] [data-layout-drag] { cursor:move; } [data-pc-workspace] [data-layout-resize] { cursor:nwse-resize; }
[data-pc-workspace][data-scroll=content] { height:100dvh; min-height:0; overflow:hidden; }
[data-pc-workspace][data-scroll=content] [data-pc-stage] { overflow:auto; }
[data-pc-workspace][data-scroll=content] > [data-pc-slot=nav] { height:100%; }
[data-pc-workspace][data-narrow=true] { display:flex!important; flex-direction:column; height:auto; min-height:100dvh; overflow:visible; }
[data-pc-workspace][data-narrow=true] > [data-pc-slot=nav] { position:static!important; height:auto; max-height:35dvh; }
[data-pc-workspace][data-narrow=true] > [data-pc-stage] { display:flex; flex-direction:column; overflow:visible; width:100%; }
[data-pc-workspace][data-narrow=true] [data-pc-dock] { width:100%; }
[data-pc-workspace][data-narrow=true] [data-pc-panel] { position:static; width:100%!important; height:auto; max-height:none; }
[data-pc-workspace] [hidden] { display:none!important; }
@media(prefers-reduced-motion:reduce) { [data-pc-workspace] * { scroll-behavior:auto; transition:none; } }
`;
