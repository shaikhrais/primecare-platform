/** Shared spatial rules. Presentation only; screen registration still owns access. */
export class SpaceManager {
 constructor(private readonly surface:HTMLElement){}
 apply(density:'comfortable'|'compact'):void {
  if(!['comfortable','compact'].includes(density))throw Error('Unsupported spatial density');
  this.surface.dataset.spaceManaged='true';
  const compact=density==='compact';
  for(const [name,value] of Object.entries({'--pc-page-gap':compact?'clamp(10px, 2vw, 12px)':'clamp(12px, 2vw, 18px)','--pc-card-pad':compact?'clamp(10px, 1.5vw, 12px)':'clamp(12px, 1.5vw, 16px)','--pc-section-gap':compact?'10px':'clamp(10px, 1.5vw, 14px)','--pc-title-size':compact?'20px':'clamp(20px, 2vw, 24px)','--pc-chart-height':compact?'166px':'clamp(166px, 20vw, 196px)'}))this.surface.style.setProperty(name,value);
 }
 clear():void {delete this.surface.dataset.spaceManaged;for(const key of ['--pc-page-gap','--pc-card-pad','--pc-section-gap','--pc-title-size','--pc-chart-height'])this.surface.style.removeProperty(key);}
}
/** Central styles installed once, after application CSS, so every master uses the same rules. */
export function installSpaceStyles(doc:Document):void {
 if(doc.querySelector('style[data-pc-space-manager]'))return;
 const style=doc.createElement('style');style.dataset.pcSpaceManager='';style.textContent=spaceStyles;doc.head.append(style);
}
export const spaceStyles=`
.app-shell[data-space-managed]{--pc-page-gap:18px;--pc-card-pad:16px;--pc-section-gap:14px;--pc-title-size:24px;--pc-chart-height:196px}
.app-shell[data-space-managed] .workspace>main{padding:var(--pc-page-gap)}
.app-shell[data-space-managed] :is(.code-admin-page-header,.screen-header){margin:0 0 var(--pc-section-gap);padding:0;gap:8px;min-height:0}
.app-shell[data-space-managed] :is(.code-admin-title-row h1,.code-admin-page-header>h1,.screen-header h1){font-size:calc(var(--pc-title-size) * var(--theme-font-scale,1));line-height:1.25;letter-spacing:-.035em;margin:0;font-weight:700}
.app-shell[data-space-managed] :is(.code-admin-title-row>p,.code-admin-title-row>div>p,.code-admin-page-header>p,.screen-header>p){font-size:calc(12px * var(--theme-font-scale,1));line-height:1.45;margin:4px 0 0;color:var(--color-text-muted)}
.app-shell[data-space-managed] .code-admin-title-row{flex-basis:auto;width:auto}
.app-shell[data-space-managed] :is(.code-admin-eyebrow,.code-admin-breadcrumb,.code-admin-title-row>.media-heading-icon){display:none}
.app-shell[data-space-managed] :is(.approved-stats,.approved-columns){gap:var(--pc-section-gap);margin-bottom:var(--pc-section-gap)!important}
.app-shell[data-space-managed] :is(.section,.approved-panel){margin-block:var(--pc-section-gap);border-color:var(--color-border);border-radius:var(--radius-lg)}
.app-shell[data-space-managed] :is(.approved-stats .admin-stat,.approved-panel>header){padding:var(--pc-card-pad)}
.app-shell[data-space-managed] .topbar{min-height:52px;padding-block:6px}
.app-shell[data-space-managed] .approved-topbar{min-height:52px;padding-block:6px}
.app-shell[data-space-managed] .code-admin-nav-group{margin-block:14px}
.app-shell[data-space-managed] .code-admin-nav-group h2{margin-block:0 6px}
.app-shell[data-space-managed] .code-admin-nav-group a{min-height:36px;padding-block:8px}
.app-shell[data-space-managed] :is(.ems-widget,.ems-chart-card){border:1px solid var(--color-border);box-shadow:var(--shadow-card);border-radius:var(--radius-lg);padding:var(--pc-card-pad)}
.app-shell[data-space-managed] .ems-observatory{margin:0}
.app-shell[data-space-managed] .code-admin-page-body{gap:var(--pc-section-gap)}
.app-shell[data-space-managed] .ems-observatory-toolbar{justify-content:flex-end;gap:10px;margin:0 0 10px;flex-direction:row;align-items:center}
.app-shell[data-space-managed] .ems-observatory-toolbar>button{font-size:calc(11px * var(--theme-font-scale,1));min-height:30px;padding:4px 9px;background:transparent}
.app-shell[data-space-managed] .ems-notes{position:relative;font-size:calc(11px * var(--theme-font-scale,1));color:var(--color-text-muted)}
.app-shell[data-space-managed] .ems-notes summary{cursor:pointer;min-height:30px;display:flex;align-items:center}
.app-shell[data-space-managed] .ems-notes p{position:absolute;z-index:4;inset-inline-end:0;top:28px;width:min(300px,75vw);padding:12px;background:var(--color-surface);border:1px solid var(--color-border);border-radius:var(--radius-md);box-shadow:var(--shadow-card)}
.pc-visually-hidden{position:absolute!important;width:1px!important;height:1px!important;padding:0!important;margin:-1px!important;overflow:hidden!important;clip-path:inset(50%);white-space:nowrap!important;border:0!important}
.app-shell[data-space-managed] .ems-widget-grid{gap:var(--pc-section-gap)}
.app-shell[data-space-managed] .ems-widget h3{min-height:0;margin:0 26px 10px 0;padding:0;font-size:calc(11px * var(--theme-font-scale,1));line-height:1.35}
.app-shell[data-space-managed] .ems-widget>strong{font-size:calc(28px * var(--theme-font-scale,1));line-height:1.1;letter-spacing:-.04em}
.app-shell[data-space-managed] .ems-widget p{min-height:0;margin-top:7px;font-size:calc(10px * var(--theme-font-scale,1));line-height:1.4}
.app-shell[data-space-managed] .ems-widget-mark{width:26px;height:26px;padding:4px;border-radius:8px;background:color-mix(in srgb,var(--color-primary) 9%,var(--color-surface));color:var(--color-primary)}
.app-shell[data-space-managed] .ems-widget-1 .ems-widget-mark{color:var(--color-success);background:color-mix(in srgb,var(--color-success) 9%,var(--color-surface))}
.app-shell[data-space-managed] .ems-widget-2 .ems-widget-mark{color:var(--color-warning);background:color-mix(in srgb,var(--color-warning) 9%,var(--color-surface))}
.app-shell[data-space-managed] .ems-chart-grid{gap:var(--pc-section-gap);margin-block:var(--pc-section-gap)}
.app-shell[data-space-managed] .ems-chart-card>h3{border:0;padding:0;margin-bottom:8px;font-size:calc(13px * var(--theme-font-scale,1));line-height:1.4}
.app-shell[data-space-managed] .ems-chart-card svg{height:var(--pc-chart-height);max-height:var(--pc-chart-height);width:100%}
.app-shell[data-space-managed] .ems-status-card svg{height:calc(var(--pc-chart-height) * .72);max-height:calc(var(--pc-chart-height) * .72)}
.app-shell[data-space-managed] .ems-chart-card details{margin-top:4px;font-size:calc(11px * var(--theme-font-scale,1))}
.app-shell[data-space-managed] .ems-chart-card p{margin:6px 0;font-size:calc(10px * var(--theme-font-scale,1));line-height:1.4}
.app-shell[data-space-managed] .ems-chart-card details summary{padding:4px 0;font-weight:500}
.app-shell[data-space-managed] :is(.ems-status-list,.ems-service-bars){gap:10px;margin-block:8px}
.app-shell[data-space-managed] .ems-metric-grid{margin-block:var(--pc-section-gap);gap:var(--pc-section-gap)}
.app-shell[data-space-managed] [data-cy=ems-inventory]>h2{font-size:calc(16px * var(--theme-font-scale,1));margin-bottom:8px}
.app-shell[data-space-managed] .ems-series-1{fill:var(--color-error);stroke:var(--color-error)}
.app-shell[data-space-managed] .ems-series-2{fill:var(--color-warning);stroke:var(--color-warning)}
.app-shell[data-space-managed] .ems-series-3{fill:var(--color-info);stroke:var(--color-info)}
.app-shell[data-space-managed] .ems-chart-card circle[fill=none]{fill:none}

/* Active themes own control surfaces as well as card and text tokens. */
.app-shell[data-space-managed][data-theme-center-active] :is(button,input,select,textarea){background:var(--color-surface)!important;color:var(--color-text)!important;border-color:var(--color-border)!important}
.app-shell[data-space-managed][data-theme-center-active] :is(button.primary,button[type=submit],button[aria-pressed=true],button[aria-selected=true]){background:var(--color-primary)!important;color:var(--color-on-primary)!important}
.app-shell[data-space-managed][data-theme-center-active] .global-search label{background:var(--color-surface)!important;color:var(--color-text)!important;border-color:var(--color-border)!important}
.app-shell[data-space-managed][data-theme-center-active] .global-search kbd{background:var(--color-surface-soft);color:var(--color-text-muted);border-color:var(--color-border)}
.app-shell[data-space-managed][data-theme-center-active] aside nav a[aria-current=page] .shell-icon{color:var(--color-on-primary)!important}
/* Page identity stays accessible without reserving a visible title zone. */
.app-shell[data-space-managed] .workspace>main h1,.app-shell[data-space-managed] .topbar-title,.app-shell[data-space-managed] .code-admin-title-row{position:absolute!important;width:1px!important;height:1px!important;overflow:hidden!important;clip-path:inset(50%)!important;margin:0!important;padding:0!important;white-space:nowrap!important;border:0!important}
.app-shell[data-space-managed] .code-admin-page-header{border:0;margin:0;padding:0;gap:0;min-height:0}
.app-shell[data-space-managed] .code-admin-page-header:has(.approved-header-actions){margin-bottom:var(--pc-section-gap);justify-content:flex-end}
.app-shell[data-space-managed] .screen-header>p:not(.notice){display:none}
.app-shell[data-space-managed] .screen-header:not(:has(.notice)){margin:0;padding:0}
.app-shell[data-space-managed]:not(.shell-content-only){grid-template-columns:216px minmax(0,1fr)}
.app-shell[data-space-managed][data-sidebar-position=right]:not(.shell-content-only){grid-template-columns:minmax(0,1fr) 216px}
.app-shell[data-space-managed]>aside{width:216px;min-width:0;height:var(--pc-viewport-height,100dvh);top:var(--pc-viewport-offset,0px)}
.app-shell[data-space-managed]>aside .brand{height:56px;min-height:56px;padding:10px 16px;gap:9px}
.app-shell[data-space-managed]>aside .brand>span:last-child{font-size:17px}
.app-shell[data-space-managed]>aside>nav{padding:0 8px 8px}
.app-shell[data-space-managed]>aside .code-admin-nav-group{margin:0 0 8px;padding:0}
.app-shell[data-space-managed]>aside .code-admin-nav-group h2{margin:8px 10px 4px;line-height:1.4}
.app-shell[data-space-managed]>aside nav a{min-height:36px;padding:7px 10px;gap:9px;font-size:12px;line-height:1.35}
.app-shell[data-space-managed]>aside>.sidebar-role{min-height:52px;padding:10px 50px 10px 52px;font-size:10px}
.app-shell[data-space-managed]>aside>.sidebar-role:before{left:14px;top:11px}
.app-shell[data-space-managed] .app-footer{padding:8px 16px;font-size:11px;min-height:0}
.app-shell[data-space-managed] .app-footer:empty{display:none}
.app-shell[data-space-managed] .approved-sidebar-popover,.app-shell[data-space-managed] .approved-sidebar-popover button{background:var(--color-surface);color:var(--color-text);border-color:var(--color-border)}
.app-shell[data-space-managed] .approved-sidebar-popover button:hover{background:var(--color-surface-soft)}
.app-shell[data-space-managed] .approved-sidebar-popover .shell-icon{color:var(--color-text)}
.app-shell.approved-code-admin[data-space-managed]:has(.code-admin-layout) .topbar{height:56px;min-height:56px;padding:6px 16px;grid-template-columns:minmax(160px,1fr) auto;gap:10px;align-content:center}
.app-shell.approved-code-admin[data-space-managed]:has(.code-admin-layout) .topbar .global-search{grid-column:1;justify-self:start;width:min(360px,100%)}
.app-shell.approved-code-admin[data-space-managed]:has(.code-admin-layout) .topbar .shell-controls{grid-column:2}
@media(min-width:1025px){
 .app-shell[data-space-managed][data-navigation-mode=compact]:not(.shell-content-only){grid-template-columns:64px minmax(0,1fr)}
 .app-shell[data-space-managed][data-sidebar-position=right][data-navigation-mode=compact]:not(.shell-content-only){grid-template-columns:minmax(0,1fr) 64px}
 .app-shell[data-space-managed][data-navigation-mode=compact]>aside{width:64px}
 .app-shell[data-space-managed][data-navigation-mode=compact]>aside .brand{padding:10px;justify-content:center}
 .app-shell[data-space-managed][data-navigation-mode=compact]>aside .brand>span:last-child,.app-shell[data-space-managed][data-navigation-mode=compact]>aside .code-admin-nav-group h2{display:none}
 .app-shell[data-space-managed][data-navigation-mode=compact]>aside nav a{font-size:0;gap:0;min-height:40px;justify-content:center;padding:8px}
 .app-shell[data-space-managed][data-navigation-mode=compact]>aside>.sidebar-role{font-size:0;padding:10px 0;min-height:52px}
 .app-shell[data-space-managed][data-navigation-mode=compact]>aside>.sidebar-role:after{display:none}
 .app-shell[data-space-managed][data-navigation-mode=compact]>aside>.sidebar-role:before{display:none}
 .app-shell[data-space-managed][data-navigation-mode=compact] .approved-sidebar-menu{right:10px;bottom:4px}
 .app-shell[data-space-managed][data-navigation-mode=compact] .approved-sidebar-popover{position:fixed;left:64px;right:auto;top:calc(var(--pc-viewport-offset,0px) + var(--pc-viewport-height,100dvh) - 164px);bottom:auto}
 .app-shell[data-space-managed][data-sidebar-position=right][data-navigation-mode=compact] .approved-sidebar-popover{left:auto;right:64px}
}
@media(max-width:1024px){
 .app-shell[data-space-managed]:not(.shell-content-only){grid-template-columns:minmax(0,1fr)!important}
 .app-shell[data-space-managed][data-navigation-mode]>aside{width:248px}
 .app-shell.approved-code-admin[data-space-managed]:has(.code-admin-layout) .topbar{grid-template-columns:44px minmax(0,1fr) auto}
 .app-shell.approved-code-admin[data-space-managed]:has(.code-admin-layout) .topbar .global-search{grid-column:2}
 .app-shell.approved-code-admin[data-space-managed]:has(.code-admin-layout) .topbar .shell-controls{grid-column:3}
}
@media(max-width:600px){
 .app-shell.approved-code-admin[data-space-managed]:has(.code-admin-layout) .topbar{height:104px;min-height:104px;grid-template-columns:44px minmax(0,1fr) 44px 58px;grid-template-rows:44px 44px;padding:8px 12px;gap:0 8px;align-content:space-between}
 .app-shell.approved-code-admin[data-space-managed]:has(.code-admin-layout) .topbar .shell-controls{display:contents}
 .app-shell.approved-code-admin[data-space-managed]:has(.code-admin-layout) .topbar .topbar-tenant{grid-column:1/-1;grid-row:2}
}
@media(max-width:600px){.app-shell[data-space-managed]{--pc-page-gap:12px;--pc-card-pad:12px;--pc-section-gap:10px;--pc-title-size:20px;--pc-chart-height:166px}.app-shell[data-space-managed] .code-admin-title-row{flex-basis:auto}.app-shell[data-space-managed] .ems-widget>strong{font-size:calc(25px * var(--theme-font-scale,1))}.app-shell[data-space-managed] .ems-widget h3{min-height:28px;margin-bottom:6px}.app-shell[data-space-managed] .ems-chart-grid{grid-template-columns:repeat(2,minmax(0,1fr));grid-template-areas:'trend trend' 'readiness readiness' 'services services' 'status status'}.app-shell[data-space-managed] .ems-readiness-card svg{height:var(--pc-chart-height)}.app-shell[data-space-managed] .ems-chart-card svg text:not(.ems-chart-total){font-size:calc(16px * var(--theme-font-scale,1))}.app-shell[data-space-managed] .ems-operational-card{display:none}.app-shell[data-space-managed] .ems-status-list{font-size:calc(11px * var(--theme-font-scale,1))}.app-shell[data-space-managed] .ems-observatory-toolbar{margin-bottom:8px}}
`;
