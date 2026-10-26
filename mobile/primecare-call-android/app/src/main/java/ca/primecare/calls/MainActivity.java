package ca.primecare.calls;

import android.net.Uri;

/** Composition root reuses the deployed shared calling UI and native API grants. */
public final class MainActivity extends BrowserPortalActivity {
    @Override protected Uri portalUri() {
        return Uri.parse("https://primecare-clinic.pages.dev/login");
    }
}
