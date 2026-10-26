package ca.primecare.calls;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import androidx.browser.customtabs.CustomTabColorSchemeParams;
import androidx.browser.customtabs.CustomTabsIntent;

/** Shared host lifecycle only; authenticated web services remain the authority.
 * No JavaScript bridge, credentials, tenant overrides, or caller identity live here.
 */
public abstract class BrowserPortalActivity extends Activity {
    private static final String CHROME = "com.android.chrome";
    private TextView status;
    protected abstract Uri portalUri();

    @Override public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ScrollView scroll = new ScrollView(this);
        LinearLayout body = new LinearLayout(this);
        body.setOrientation(LinearLayout.VERTICAL);
        int padding = Math.round(24 * getResources().getDisplayMetrics().density);
        body.setPadding(padding, padding, padding, padding);
        body.setBackgroundColor(Color.rgb(242, 250, 249));
        // Respect Android 15 edge-to-edge system bars and display cutouts.
        scroll.setOnApplyWindowInsetsListener((view, insets) -> {
            view.setPadding(insets.getSystemWindowInsetLeft(), insets.getSystemWindowInsetTop(),
                    insets.getSystemWindowInsetRight(), insets.getSystemWindowInsetBottom());
            return insets;
        });
        addText(body, R.string.heading, 30);
        addText(body, R.string.description, 18);
        addText(body, R.string.instructions, 18);
        Button open = new Button(this);
        open.setText(R.string.open_portal);
        open.setOnClickListener(view -> openPortal());
        body.addView(open);
        status = addText(body, R.string.chrome_required, 17);
        status.setVisibility(View.GONE);
        addText(body, R.string.limitations, 16);
        addText(body, R.string.origin, 14);
        scroll.addView(body);
        setContentView(scroll);
        // Opening the app never dials or requests microphone access.
    }

    private TextView addText(LinearLayout body, int resource, int size) {
        TextView text = new TextView(this);
        text.setText(resource);
        text.setTextSize(size);
        text.setTextColor(Color.rgb(17, 49, 48));
        int gap = Math.round(18 * getResources().getDisplayMetrics().density);
        text.setPadding(0, 0, 0, gap);
        body.addView(text);
        return text;
    }

    private void openPortal() {
        Uri uri = portalUri();
        // Exact trusted portal only: ignore all incoming Intent URLs/extras.
        if (!"https".equals(uri.getScheme()) || !"primecare-clinic.pages.dev".equals(uri.getHost())
                || !"/login".equals(uri.getPath()) || uri.getQuery() != null
                || uri.getFragment() != null || uri.getPort() != -1 || uri.getUserInfo() != null) {
            throw new IllegalStateException("Unapproved portal");
        }
        try {
            if (!getPackageManager().getApplicationInfo(CHROME, 0).enabled) {
                status.setVisibility(View.VISIBLE);
                return;
            }
            CustomTabsIntent tab = new CustomTabsIntent.Builder()
                    .setShowTitle(true)
                    .setDefaultColorSchemeParams(new CustomTabColorSchemeParams.Builder()
                            .setToolbarColor(Color.rgb(0, 107, 104)).build())
                    .build();
            tab.intent.setPackage(CHROME);
            tab.launchUrl(this, uri);
            status.setVisibility(View.GONE);
        } catch (PackageManager.NameNotFoundException | ActivityNotFoundException exception) {
            status.setVisibility(View.VISIBLE);
        }
    }
}
