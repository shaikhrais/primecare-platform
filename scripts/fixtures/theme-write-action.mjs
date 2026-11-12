/** Await the existing Theme Center Web Locks write before readback or navigation. */
export async function writeThemeFixtureAction(page,id) {
 if(!['new','update','apply','rename','duplicate','delete','reset'].includes(id))throw Error('Unknown Theme Center write action');
 await page.locator('[data-cy=theme-center-'+id+']').click();
 await page.waitForFunction(()=>document.querySelector('[data-cy=theme-center-new]')?.disabled===false);
}
