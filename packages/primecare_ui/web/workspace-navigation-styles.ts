/** Original opt-in navigation; appearance inherits the host's shared tokens. */
export const workspaceNavigationStyles=`
[data-workspace-navigation]{position:relative;min-width:0;color:var(--color-text);background:var(--color-surface)}
[data-workspace-navigation] ul{list-style:none;padding:0;margin:0;min-width:0}
[data-workspace-navigation] a,[data-workspace-navigation] button{box-sizing:border-box;display:flex;align-items:center;gap:var(--spacing-sm,.5rem);width:100%;min-height:44px;padding:.5rem .75rem;text-align:start;font:inherit;white-space:normal;color:inherit;background:transparent;border:0;border-radius:var(--radius-sm,.25rem);text-decoration:none;cursor:pointer}
[data-workspace-navigation] :is(a,button):focus-visible{outline:2px solid var(--color-primary,currentColor);outline-offset:-2px}
[data-workspace-navigation] :is(a,button):hover,[data-workspace-navigation] [aria-current=page],[data-workspace-navigation] [aria-selected=true]{background:var(--color-primary);color:var(--color-on-primary)}
[data-workspace-navigation] button:disabled{opacity:.55;cursor:default}
[data-workspace-navigation] [data-nav-copy]{display:flex;flex-direction:column;min-width:0;overflow-wrap:anywhere}
[data-workspace-navigation] [data-nav-pin]{overflow-wrap:anywhere}
[data-workspace-navigation] small{font-size:.8em;white-space:normal}
[data-workspace-navigation] [data-nav-badge]{margin-inline-start:auto;font-size:.8em}
[data-workspace-navigation] svg{flex:none;width:22px;height:22px}
[data-workspace-navigation] [data-nav-children]{padding-inline-start:1rem}
[data-workspace-navigation] [hidden]{display:none!important}
[data-workspace-navigation][data-family^=horizontal] > nav > ul{display:flex;flex-wrap:wrap;gap:.25rem}
[data-workspace-navigation][data-family^=horizontal] > nav > ul > li{position:relative}
[data-workspace-navigation][data-family^=horizontal] [data-nav-children]{position:absolute;z-index:75;inset-inline-start:0;top:100%;padding:.25rem;min-width:220px;max-width:min(320px,calc(100vw - 16px));max-height:65dvh;overflow:auto;background:var(--color-surface);color:var(--color-text);border:1px solid var(--color-border)}
[data-workspace-navigation][data-family=horizontal-footer] > nav > ul > li > [data-nav-children]{top:auto;bottom:100%}
[data-workspace-navigation][data-family^=horizontal] [data-nav-children] [data-nav-children]{position:static;min-width:0;border:0;padding-inline-start:.75rem}
[data-workspace-navigation][data-family=vertical] > nav{width:260px;max-width:100%}
[data-workspace-navigation][data-family=vertical][data-mode=folded]:not([data-expanded=true]) > nav{width:64px}
[data-workspace-navigation][data-family=vertical][data-mode=folded]:not([data-expanded=true]) [data-nav-copy], [data-workspace-navigation][data-family=vertical][data-mode=folded]:not([data-expanded=true]) [data-nav-badge]{position:absolute;width:1px;height:1px;clip-path:inset(50%);overflow:hidden}
[data-workspace-navigation][data-mode=rail][data-family=vertical] > nav{display:flex;width:340px}
[data-workspace-navigation] [role=tablist]{width:72px;flex:none}
[data-workspace-navigation] [role=tabpanel]{flex:1;min-width:0}
[data-workspace-navigation] [data-nav-open],[data-workspace-navigation] [data-nav-close],[data-workspace-navigation] [data-nav-backdrop]{display:none}
@media(max-width:1024px){
 [data-workspace-navigation] [data-nav-open]{display:flex}
 [data-workspace-navigation] > nav{display:none!important;position:fixed;inset-block:0;inset-inline-start:0;z-index:81;width:min(340px,calc(100vw - 44px))!important;max-width:100%;overflow:auto;background:var(--color-surface);color:var(--color-text);padding:.5rem}
 [data-workspace-navigation][data-drawer-open=true] > nav{display:block!important}
 [data-workspace-navigation][data-drawer-open=true] [data-nav-backdrop]{display:block;position:fixed;inset:0;z-index:80;background:var(--color-backdrop,rgba(0,0,0,.35));border:0;border-radius:0;width:100vw;height:100dvh}
 [data-workspace-navigation] [data-nav-close]{display:flex}
 [data-workspace-navigation] > nav > ul{display:block!important}
 [data-workspace-navigation] [data-nav-children]{position:static!important;min-width:0!important;max-width:100%!important;max-height:none!important;border:0!important;padding-inline-start:1rem!important}
 [data-workspace-navigation] [data-nav-copy],[data-workspace-navigation] [data-nav-badge]{position:static!important;width:auto!important;height:auto!important;clip-path:none!important;overflow:visible!important}
 [data-workspace-navigation] [role=tablist]{width:100%;display:flex;flex-wrap:wrap}
}
@media(prefers-reduced-motion:reduce){[data-workspace-navigation] *{scroll-behavior:auto;transition:none}}
`;
