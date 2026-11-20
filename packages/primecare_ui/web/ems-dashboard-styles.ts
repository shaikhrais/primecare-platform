/** Central EMS presentation. All appearance inherits the active PrimeCare theme. */
export const emsDashboardStyles = `/* EMS charts inherit the active shared theme, including dark and contrast modes. */
.ems-observatory{margin-block:var(--spacing-lg);min-width:0}
.ems-chart-grid,.ems-metric-grid{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:var(--spacing-lg);margin-block:var(--spacing-lg)}
.ems-chart-card,.ems-metric-grid>div{min-width:0;padding:var(--spacing-lg);border:1px solid var(--color-border);border-radius:var(--radius-lg);background:var(--color-surface)}
.ems-chart-card h3{margin-block:0 var(--spacing-md)}
.ems-chart-card svg{display:block;width:100%;height:auto;overflow:visible}
.ems-chart-card svg text{fill:var(--color-text);font-size:var(--font-size-caption);font-family:inherit}
.ems-chart-card svg .ems-chart-total{font-size:var(--font-size-heading);font-weight:bold}
.ems-chart-card details{overflow:auto;margin-block-start:var(--spacing-md)}
.ems-chart-card summary{cursor:pointer}.ems-chart-card table{width:100%}
.ems-chart-gridline{stroke:var(--color-border);stroke-width:1}
.ems-trend-line{stroke:var(--color-primary);stroke-width:3;fill:none}
.ems-series-0{stroke:var(--color-primary);fill:var(--color-primary)}
.ems-series-1{stroke:var(--color-error,var(--color-secondary));fill:var(--color-error,var(--color-secondary))}
.ems-series-2{stroke:var(--color-warning,var(--color-info));fill:var(--color-warning,var(--color-info))}
.ems-series-3{stroke:var(--color-secondary);fill:var(--color-secondary)}
.ems-series-4{stroke:var(--color-success,var(--color-primary));fill:var(--color-success,var(--color-primary))}
.ems-chart-card circle[fill=none]{fill:none}
.ems-metric-grid{grid-template-columns:repeat(3,minmax(0,1fr))}.ems-metric-grid dd{margin:var(--spacing-sm) 0 0;font-size:var(--font-size-heading);font-weight:bold}
@media(max-width:700px){.ems-chart-grid,.ems-metric-grid{grid-template-columns:minmax(0,1fr)}}
/* EMS summary widgets and visual hierarchy. */
.ems-observatory-toolbar{display:flex;align-items:center;justify-content:space-between;gap:var(--spacing-lg);margin-bottom:var(--spacing-lg)}
.ems-observatory-toolbar h2{margin:0;font-size:var(--font-size-heading);letter-spacing:-.025em}
.ems-observatory-toolbar p{margin:var(--spacing-sm) 0;color:var(--color-text-muted);max-width:70ch}
.ems-observatory-toolbar>button{flex:none}
.ems-widget-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:var(--spacing-md)}
.ems-widget{position:relative;overflow:hidden;min-width:0;padding:var(--spacing-lg);border:1px solid var(--color-border);border-radius:var(--radius-lg);background:var(--color-surface);box-shadow:var(--shadow-card,none);border-block-start:3px solid var(--color-primary)}
.ems-widget h3{font-size:var(--font-size-body,15px);font-weight:500;color:var(--color-text-muted);margin:0 44px var(--spacing-md) 0}
.ems-widget>strong{display:block;font-size:calc(var(--font-size-heading)*1.5);font-weight:750;letter-spacing:-.035em;line-height:1.15;font-variant-numeric:tabular-nums;color:var(--color-text)}
.ems-widget p{font-size:var(--font-size-caption,12px);color:var(--color-text-muted);margin:var(--spacing-sm) 0 0}
.ems-widget-mark{position:absolute;inset-inline-end:var(--spacing-lg);inset-block-start:var(--spacing-md);display:grid;place-items:center;width:36px;height:36px;border-radius:var(--radius-md);color:var(--color-primary);background:var(--color-surface-soft);font-size:20px;font-weight:700}
.ems-widget-1{border-block-start-color:var(--color-success,var(--color-primary))}.ems-widget-2{border-block-start-color:var(--color-warning,var(--color-info))}
.ems-chart-card{box-shadow:var(--shadow-card,none)}
.ems-chart-card>h3{padding-block-end:var(--spacing-md);border-block-end:1px solid var(--color-border);letter-spacing:-.015em}
.ems-chart-card details summary{color:var(--color-primary);font-weight:600;padding:var(--spacing-sm) 0}
.ems-metric-grid>div{background:var(--color-surface-soft);border-color:transparent}.ems-metric-grid dt{color:var(--color-text-muted);font-size:var(--font-size-caption,13px)}
[data-cy=ems-overview],[data-cy=ems-inventory]{padding:var(--spacing-lg);margin-block:var(--spacing-lg);border:1px solid var(--color-border);border-radius:var(--radius-lg);background:var(--color-surface);min-width:0}
[data-cy=ems-overview]>[role=status]{padding:var(--spacing-md);background:var(--color-surface-soft);border-radius:var(--radius-md);line-height:1.8}
[data-cy=ems-maintenance]{overflow:auto}
@media(max-width:900px){.ems-widget-grid{grid-template-columns:repeat(2,minmax(0,1fr))}}
@media(max-width:520px){.ems-widget-grid{grid-template-columns:minmax(0,1fr)}.ems-observatory-toolbar{align-items:flex-start;flex-direction:column}}

[data-pc-ems-dashboard]{color:var(--color-text);font-family:var(--font-family,inherit);font-size:var(--font-size-body)}
[data-pc-ems-dashboard] :is(button,input,select){font:inherit;box-sizing:border-box;max-inline-size:100%;min-block-size:var(--control-min-height,44px);padding:var(--spacing-sm) var(--spacing-md);border:var(--border-width,1px) solid var(--color-border);border-radius:var(--radius-md);background:var(--color-surface);color:var(--color-text)}
[data-pc-ems-dashboard] button{cursor:pointer}[data-pc-ems-dashboard] button:disabled{cursor:default;opacity:.55}
[data-pc-ems-dashboard] :focus-visible{outline:var(--border-width,2px) solid var(--color-primary);outline-offset:var(--spacing-sm)}
[data-pc-ems-dashboard] form{display:flex;flex-wrap:wrap;align-items:center;gap:var(--spacing-sm)}
[data-pc-ems-dashboard] table{border-collapse:collapse;color:var(--color-text);background:var(--color-surface)}
[data-pc-ems-dashboard] :is(th,td){text-align:start;padding:var(--spacing-sm) var(--spacing-md);border-block-end:var(--border-width,1px) solid var(--color-border)}
[data-pc-ems-dashboard] th{font-size:var(--font-size-caption);color:var(--color-text-muted)}
[data-pc-ems-dashboard] [hidden]{display:none!important}

/* Compact EMS composition follows the master dashboard's central theme. */
.ems-observatory{margin-block:var(--spacing-md)}
.ems-observatory-toolbar{margin-bottom:var(--spacing-md);gap:var(--spacing-md)}
.ems-observatory-toolbar h2{font-size:var(--font-size-heading)}
.ems-observatory-toolbar p{font-size:var(--font-size-caption);margin:var(--spacing-sm) 0 0}
.ems-widget-grid{grid-template-columns:repeat(6,minmax(0,1fr));gap:var(--spacing-md)}
.ems-widget{padding:var(--spacing-md);border-block-start-width:var(--border-width,1px)}
.ems-widget h3{margin:0 0 var(--spacing-sm);padding-inline-end:var(--spacing-lg);font-size:var(--font-size-caption);min-height:2.2em}
.ems-widget>strong{font-size:calc(var(--font-size-heading)*1.15)}
.ems-widget p{font-size:var(--font-size-caption);line-height:1.45;min-height:2.8em}
.ems-widget-mark{width:var(--spacing-lg);height:var(--spacing-lg);inset-inline-end:var(--spacing-sm);inset-block-start:var(--spacing-sm);background:transparent}
.ems-widget-mark svg{width:100%;height:100%}
.ems-chart-grid{grid-template-columns:repeat(3,minmax(0,1fr));grid-template-areas:'trend trend readiness' 'operational services status';gap:var(--spacing-md);margin-block:var(--spacing-md);align-items:stretch}
.ems-trend-card{grid-area:trend}.ems-readiness-card{grid-area:readiness}.ems-operational-card{grid-area:operational}.ems-services-card{grid-area:services}.ems-status-card{grid-area:status}
.ems-chart-card{padding:var(--spacing-md)}
.ems-chart-card h3{font-size:var(--font-size-body);margin:0 0 var(--spacing-sm);padding-bottom:var(--spacing-sm)}
.ems-chart-card svg{max-height:240px}
.ems-trend-card svg{max-height:270px}
.ems-chart-card p{font-size:var(--font-size-caption);color:var(--color-text-muted);line-height:1.5}
.ems-trend-area{fill:var(--color-primary);opacity:.12}
.ems-status-list{display:grid;gap:var(--spacing-md);margin:var(--spacing-md) 0}
.ems-status-list>div{display:flex;justify-content:space-between;gap:var(--spacing-sm);border-bottom:var(--border-width,1px) solid var(--color-border);padding-bottom:var(--spacing-sm)}
.ems-status-list dd{margin:0;font-weight:700;font-variant-numeric:tabular-nums}
.ems-status-list dt{color:var(--color-text-muted)}
.ems-service-bars{display:grid;gap:var(--spacing-md);padding-block:var(--spacing-sm)}
.ems-service-bars>div{display:grid;grid-template-columns:minmax(60px,1fr) 2fr auto;gap:var(--spacing-sm);align-items:center;font-size:var(--font-size-caption)}
.ems-service-bars meter{width:100%;accent-color:var(--color-primary);height:var(--spacing-md)}
.ems-operation-disclosure{margin-block:var(--spacing-md)}
.ems-metric-grid{gap:var(--spacing-md);margin-block:var(--spacing-md)}
.ems-metric-grid>div{padding:var(--spacing-md)}
.ems-metric-grid dd{font-size:var(--font-size-body)}
[data-cy=ems-overview]{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:var(--spacing-sm);padding:var(--spacing-md);margin-block:var(--spacing-md)}
[data-cy=ems-overview]>h2{font-size:var(--font-size-body);margin:var(--spacing-sm) 0}
[data-cy=ems-overview]>[role=status]{margin:0;padding:var(--spacing-sm);font-size:var(--font-size-caption)}
[data-cy=ems-summary]{grid-column:1/-1}
[data-cy=ems-inventory]{padding:var(--spacing-md);margin-block:var(--spacing-md)}
[data-cy=ems-inventory]>h2{font-size:var(--font-size-heading);margin:0 0 var(--spacing-md)}
[data-cy=ems-inventory] table{font-size:var(--font-size-caption);white-space:nowrap}
.ems-method,.ems-state{display:inline-flex;padding:calc(var(--spacing-sm)*.5) var(--spacing-sm);border-radius:var(--radius-md);background:var(--color-surface-soft);font-weight:600}
.ems-method{color:var(--color-primary)}
.ems-state-ready{color:var(--color-success,var(--color-primary))}
.ems-state-blocked{color:var(--color-error,var(--color-secondary))}
@media(max-width:1200px){.ems-widget-grid{grid-template-columns:repeat(3,minmax(0,1fr))}}
@media(max-width:900px){.ems-chart-grid{grid-template-columns:repeat(2,minmax(0,1fr));grid-template-areas:'trend trend' 'readiness operational' 'services status'}}
@media(max-width:600px){.ems-widget-grid{grid-template-columns:repeat(2,minmax(0,1fr));gap:var(--spacing-sm)}.ems-widget h3{min-height:2.5em}.ems-widget p{display:none}.ems-chart-grid{grid-template-columns:minmax(0,1fr);grid-template-areas:'trend' 'readiness' 'services' 'status' 'operational'}[data-cy=ems-overview]{grid-template-columns:minmax(0,1fr)}.ems-observatory-toolbar{align-items:flex-start}.ems-widget>strong{font-size:var(--font-size-heading)}}

.ems-capacity-card,.ems-maintenance-panel{min-width:0;padding:var(--spacing-md);background:var(--color-surface-soft);border-radius:var(--radius-md)}
.ems-capacity-card h3{font-size:var(--font-size-body);margin:0 0 var(--spacing-sm)}
.ems-capacity-card p{font-size:var(--font-size-caption);line-height:1.6;margin:0}
.ems-maintenance-panel>summary{cursor:pointer;font-weight:600;font-size:var(--font-size-body)}
[data-cy=ems-inventory] .table-scroll{max-height:650px;overflow:auto;border:var(--border-width,1px) solid var(--color-border);border-radius:var(--radius-md)}
[data-cy=ems-inventory] thead{position:sticky;top:0;z-index:1;background:var(--color-surface-soft)}
[data-cy=ems-inventory] tr:hover{background:var(--color-surface-soft)}
@media(prefers-reduced-motion:no-preference){.ems-widget,.ems-chart-card{transition:border-color .15s ease}.ems-widget:hover,.ems-chart-card:hover{border-color:var(--color-primary)}}

[data-cy=ems-inventory] table[data-ems-detailed=false] :is(th,td):is(:nth-child(3),:nth-child(6),:nth-child(7),:nth-child(9),:nth-child(10),:nth-child(13),:nth-child(14),:nth-child(15),:nth-child(17),:nth-child(18)){display:none}
[data-pc-ems-dashboard] input[type=checkbox]{min-block-size:auto;padding:0;accent-color:var(--color-primary)}

/* Keep the master toolbar compact and avoid content-sized maintenance columns. */
[data-pc-ems-master] .topbar{display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:var(--spacing-sm);padding:var(--spacing-sm) var(--spacing-md)}
[data-pc-ems-master] .global-navigation{flex:1 1 240px;min-width:0}
[data-pc-ems-master] .shell-controls{display:flex;align-items:center;flex-wrap:wrap;gap:var(--spacing-sm);flex:0 1 auto}
[data-pc-ems-master] .shell-controls :is(select,button){width:auto;min-height:var(--control-min-height,40px)}
[data-pc-ems-master] .topbar>[data-cy=appearance-open]{width:auto;min-height:var(--control-min-height,40px)}
[data-cy=ems-overview]{display:flex;flex-wrap:wrap;align-items:flex-start}
[data-cy=ems-summary]{flex:1 0 100%;order:0}
[data-cy=ems-refresh]{order:1}
.ems-capacity-card{flex:1 1 300px;order:2}
.ems-maintenance-panel{flex:1 1 300px;order:3}
.ems-maintenance-panel[open]{flex-basis:100%}
[data-pc-ems-master] dialog:not([open]){display:none}
@media(max-width:600px){[data-pc-ems-master] .global-navigation{flex-basis:100%}.ems-capacity-card,.ems-maintenance-panel{flex-basis:100%}}
`;
export function installEmsDashboardStyles(doc:Document):void {
 if(doc.head.querySelector('style[data-pc-ems-styles]'))return;
 const style=doc.createElement('style');style.dataset.pcEmsStyles='';style.textContent=emsDashboardStyles;doc.head.append(style);
}
