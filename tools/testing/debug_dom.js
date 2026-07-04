const { chromium } = require('playwright');

async function main() {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();
  await page.goto("https://primecare-auth.pages.dev/login?redirect_uri=https%3A%2F%2Fprimecare-clinic.pages.dev%2Fauth%2Fcallback&enable-semantics=true");
  await page.waitForTimeout(10000);

  const info = await page.evaluate(() => {
    const pane = document.querySelector('flt-glass-pane');
    return {
      hasGlassPane: !!pane,
      hasShadowRoot: pane ? !!pane.shadowRoot : false,
      bodyHtml: document.body.innerHTML,
      shadowHtml: pane && pane.shadowRoot ? pane.shadowRoot.innerHTML : null
    };
  });

  console.log("=== DOM Info ===");
  console.log(`hasGlassPane: ${info.hasGlassPane}`);
  console.log(`hasShadowRoot: ${info.hasShadowRoot}`);
  console.log(`bodyHtml length: ${info.bodyHtml.length}`);
  console.log(`bodyHtml: ${info.bodyHtml}`);
  console.log(`shadowHtml: ${info.shadowHtml}`);

  await browser.close();
}

main().catch(console.error);
