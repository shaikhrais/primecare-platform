/** Original, shared appearance panel styles. Runtime colors inherit Theme Center tokens. */
export const themeCenterStyles = `
body dialog.layout-customizer.prime-theme-center[data-prime-theme-center]{
 --color-surface:inherit;--color-text:inherit;--color-text-muted:inherit;
 --color-surface-text:inherit;--color-surface-muted:inherit;--color-border:inherit;
 position:fixed;inset:0 0 0 auto;margin:0;width:min(48rem,100vw);height:100dvh;
 max-width:100vw;max-height:100dvh;max-block-size:100dvh;box-sizing:border-box;overflow:auto;
 border:0;border-inline-start:1px solid var(--color-border);border-radius:0;
 padding:var(--spacing-lg,1.5rem);background:var(--color-surface);color:var(--color-text);
 font-family:var(--font-family,system-ui,sans-serif);box-shadow:none;
}
dialog.prime-theme-center::backdrop{background:rgb(0 0 0 / .35)}
dialog.prime-theme-center>h2{font-size:var(--font-size-heading,1.5rem);margin:0 0 var(--spacing-sm,.5rem)}
dialog.prime-theme-center>p{color:var(--color-text-muted);line-height:1.6}
dialog.prime-theme-center form{display:block}
dialog.prime-theme-center [data-cy=theme-center]{
 display:grid;grid-template-columns:minmax(0,1fr);gap:var(--spacing-lg,1.5rem);
 background:transparent;border:0;padding:0;margin:0;
}
dialog.prime-theme-center fieldset{
 min-width:0;margin:0;padding:var(--spacing-md,1rem);display:grid;
 grid-template-columns:repeat(2,minmax(0,1fr));gap:var(--spacing-md,1rem);
 border:1px solid var(--color-border);border-radius:var(--radius-lg,.75rem);
 background:var(--color-background);
}
dialog.prime-theme-center legend{font-weight:700;padding-inline:var(--spacing-sm,.5rem)}
dialog.prime-theme-center label{display:grid;align-content:start;gap:var(--spacing-sm,.5rem);color:var(--color-text);font-size:var(--font-size-caption,.875rem)}
dialog.prime-theme-center :is(input,select,button){font:inherit;min-height:2.75rem;box-sizing:border-box;border-radius:var(--radius-md,.5rem)}
dialog.prime-theme-center :is(input,select,.theme-center-quick button){background:var(--color-surface);color:var(--color-text);border:1px solid var(--color-border)}
dialog.prime-theme-center :is(.quick-links,.theme-center-quick,details,output,.theme-center-note){grid-column:1/-1}
dialog.prime-theme-center .quick-links{display:flex;gap:var(--spacing-sm,.5rem);flex-wrap:wrap}
dialog.prime-theme-center .theme-center-quick{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:var(--spacing-sm,.5rem)}
dialog.prime-theme-center .theme-center-quick button[aria-pressed=true]{border-color:var(--color-primary);background:var(--color-surface-soft)}
dialog.prime-theme-center details>summary{cursor:pointer;padding-block:var(--spacing-sm,.5rem)}
dialog.prime-theme-center .theme-center-colors{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:var(--spacing-md,1rem)}
dialog.prime-theme-center output{overflow-wrap:anywhere}
dialog.prime-theme-center [data-cy=appearance-close]{position:sticky;bottom:0;margin-block-start:var(--spacing-md,1rem);width:100%;background:var(--color-primary);color:var(--color-on-primary);border:0}
dialog.prime-theme-center :focus-visible{outline:3px solid var(--color-primary);outline-offset:3px}
@media(max-width:600px){dialog.prime-theme-center fieldset,dialog.prime-theme-center .theme-center-quick{grid-template-columns:minmax(0,1fr)}}
@media(prefers-reduced-motion:reduce){dialog.prime-theme-center *{animation:none;transition:none;scroll-behavior:auto}}
`;

/** One style owner per document, reused across role shells and repeated mounts. */
export function installThemeCenterStyles(document:Document):void {
 if(document.head.querySelector('style[data-prime-theme-center]'))return;
 const style=document.createElement('style');style.dataset.primeThemeCenter='';
 style.textContent=themeCenterStyles;document.head.append(style);
}
