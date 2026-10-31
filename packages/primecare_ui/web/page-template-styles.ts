export const pageTemplateStyles=`
[data-pc-page]{min-width:0;box-sizing:border-box;color:var(--color-text);display:flex;flex-direction:column;gap:var(--spacing-md,1rem)}
[data-pc-page] *,[data-pc-page-dialog] *{box-sizing:border-box}
[data-pc-page] [hidden]{display:none!important}
[data-pc-page-header]{display:flex;flex-wrap:wrap;align-items:center;justify-content:space-between;gap:var(--spacing-md,1rem);padding:var(--spacing-md,1rem)}
[data-pc-page-heading]{margin:0;font:inherit;font-size:var(--font-size-xl,1.5rem);font-weight:var(--font-weight-bold,700)}
[data-pc-page-breadcrumbs] ol{display:flex;flex-wrap:wrap;list-style:none;padding:0;gap:var(--spacing-sm,.5rem)}
[data-pc-page-controls]{display:flex;flex-wrap:wrap;gap:var(--spacing-sm,.5rem)}
[data-pc-page-row]{display:flex;direction:ltr;align-items:stretch;min-height:0;min-width:0;gap:var(--spacing-md,1rem)}
[data-pc-page-row] > *{direction:var(--pc-page-direction,ltr);min-width:0}
[data-pc-page-center]{flex:1;min-width:0;display:flex;flex-direction:column}
[data-pc-page-side]{flex:none;min-width:0;max-width:var(--pc-page-sidebar-budget,28%);overflow:auto}
[data-pc-page-content]{min-width:0;padding:var(--spacing-md,1rem)}
[data-pc-page][data-template=carded] [data-pc-page-center]{background:var(--color-surface);border:1px solid var(--color-border);border-radius:var(--radius-md)}
[data-pc-page][data-scroll=page]{height:100%;overflow:auto;min-height:0}
[data-pc-page][data-scroll=content]{height:100%;overflow:hidden;min-height:0}
[data-pc-page][data-scroll=content] [data-pc-page-row]{flex:1;overflow:hidden}
[data-pc-page][data-scroll=content] [data-pc-page-content]{flex:1;overflow:auto;min-height:0}
[data-pc-page][data-scroll=normal]{height:auto;overflow:visible}
[data-pc-page-dialog]{position:fixed;margin:0;top:0;bottom:0;height:100dvh;max-height:100dvh;max-width:calc(100vw - 44px);background:var(--color-surface,Canvas);color:var(--color-text,CanvasText);border:1px solid var(--color-border);padding:var(--spacing-md,1rem);overflow:auto}
[data-pc-page-dialog=left]{left:0;right:auto}[data-pc-page-dialog=right]{right:0;left:auto}
[data-pc-page-dialog]::backdrop{background:var(--color-overlay, rgb(0 0 0 / .45))}
[data-pc-page-dialog] button,[data-pc-page-controls] button{font:inherit;min-height:44px;min-width:44px}
[data-pc-page-chrome-navigation=hidden]{--pc-nav-width:0px!important}
[data-pc-page-chrome-toolbar=hidden]{--pc-footer-offset:0px!important}
[data-pc-page-chrome-navigation=hidden] > [data-pc-slot=nav],
[data-pc-page-chrome-toolbar=hidden] > [data-pc-slot=toolbar],
[data-pc-page-chrome-footer=hidden] > [data-pc-slot=footer]{display:none!important}
`;
