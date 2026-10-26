package ca.primecare.calls;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.text.InputType;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import java.util.ArrayList;
import java.util.List;

/** Reusable native presentation; no browser, WebView or provider credentials. */
public abstract class NativeCallActivityBase extends Activity {
    protected abstract NativeCallController controller();
    private NativeCallController calls;
    private LinearLayout body;
    private TextView status;
    private EditText email, password, code, phone;
    private Button submit, cancel, dial, end, mute, speaker, logout;
    private String mode = "";
    private boolean notificationAsked;
    private final Runnable observer = this::render;
    @Override public void onCreate(Bundle state) {
        super.onCreate(state);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_SECURE);
        ScrollView scroll = new ScrollView(this);
        body = new LinearLayout(this);
        body.setOrientation(LinearLayout.VERTICAL);
        int pad = dp(24); body.setPadding(pad, pad, pad, pad);
        body.setBackgroundColor(0xfff2faf9);
        scroll.setOnApplyWindowInsetsListener((view, insets) -> {
            view.setPadding(insets.getSystemWindowInsetLeft(), insets.getSystemWindowInsetTop(),
                    insets.getSystemWindowInsetRight(), insets.getSystemWindowInsetBottom()); return insets;
        });
        scroll.addView(body); setContentView(scroll);
        calls = controller(); calls.observe(observer);
    }
    @Override public void onDestroy() {
        if (calls != null) calls.removeObserver(observer);
        super.onDestroy();
    }
    private int dp(int value) { return Math.round(value * getResources().getDisplayMetrics().density); }
    private TextView text(String value, int size) {
        TextView view = new TextView(this); view.setText(value); view.setTextSize(size);
        view.setTextColor(0xff113130); view.setPadding(0, dp(8), 0, dp(12)); body.addView(view); return view;
    }
    private EditText field(String hint, int type, int id) {
        EditText view = new EditText(this); view.setId(id); view.setHint(hint); view.setInputType(type);
        view.setSingleLine(true); view.setTextColor(0xff113130); view.setSaveEnabled(false);
        view.setImportantForAutofill(View.IMPORTANT_FOR_AUTOFILL_NO);
        body.addView(view); return view;
    }
    private Button button(String title, int id, Runnable action) {
        Button view = new Button(this); view.setId(id); view.setText(title); view.setOnClickListener(v -> action.run());
        body.addView(view); return view;
    }
    private void render() {
        String next = calls.signedIn() ? "calls" : calls.needsMfa() ? "mfa" : "login";
        if (!mode.equals(next)) {
            mode = next; body.removeAllViews(); text(getString(R.string.heading), 29);
            if (mode.equals("login")) {
                text(getString(R.string.sign_in_guidance), 17);
                email = field("Email", InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS, R.id.email);
                password = field("Password", InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD, R.id.password);
                submit = button("Sign in", R.id.sign_in, () -> {
                    String secret = password.getText().toString(); password.setText("");
                    calls.login(email.getText().toString(), secret);
                });
            } else if (mode.equals("mfa")) {
                text("Verify your identity", 22);
                if (calls.setupKey() != null) {
                    text("Add this private setup key to your authenticator app:", 17);
                    text(calls.setupKey(), 18);
                }
                code = field("Six-digit authenticator code", InputType.TYPE_CLASS_NUMBER, R.id.mfa_code);
                code.setFilters(new android.text.InputFilter[]{new android.text.InputFilter.LengthFilter(6)});
                submit = button("Verify code", R.id.verify_mfa, () -> {
                    String value = code.getText().toString(); code.setText(""); calls.verifyMfa(value);
                });
                cancel = button("Return to sign in", R.id.cancel_mfa, calls::cancelMfa);
            } else {
                text(getString(R.string.call_guidance), 17);
                phone = field("Phone number with country code (+1…)", InputType.TYPE_CLASS_PHONE, R.id.phone);
                phone.setFilters(new android.text.InputFilter[]{new android.text.InputFilter.LengthFilter(16)});
                dial = button("Call phone", R.id.call_phone, this::requestCall);
                mute = button("Mute", R.id.mute_call, calls::toggleMute);
                speaker = button("Speaker on", R.id.speaker_call, calls::toggleSpeaker);
                end = button("End call", R.id.end_call, calls::end);
                logout = button("Sign out", R.id.sign_out, calls::logout);
                text(getString(R.string.native_limitations), 15);
            }
            status = text("", 18); status.setId(R.id.call_status);
            status.setAccessibilityLiveRegion(View.ACCESSIBILITY_LIVE_REGION_POLITE);
        }
        status.setText(calls.message());
        if (mode.equals("calls")) {
            phone.setEnabled(!calls.busy() && !calls.hasReservation());
            dial.setEnabled(!calls.busy() && !calls.hasReservation());
            end.setEnabled(calls.hasReservation() && (!calls.busy() || calls.mediaActive()));
            // Allow cancelling a pending native prepare too; server cleanup is queued after it.
            if (calls.hasReservation() && calls.busy()) end.setEnabled(true);
            mute.setEnabled(calls.mediaActive()); mute.setText(calls.muted() ? "Unmute" : "Mute");
            speaker.setEnabled(calls.mediaActive()); speaker.setText(calls.speaker() ? "Speaker off" : "Speaker on");
            logout.setEnabled(!calls.busy());
        } else {
            submit.setEnabled(!calls.busy());
            if (mode.equals("mfa")) cancel.setEnabled(!calls.busy());
        }
    }
    private void requestCall() {
        List<String> permissions = new ArrayList<>();
        if (checkSelfPermission(Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) permissions.add(Manifest.permission.RECORD_AUDIO);
        if (Build.VERSION.SDK_INT >= 33 && !notificationAsked
                && checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) {
            notificationAsked = true; permissions.add(Manifest.permission.POST_NOTIFICATIONS);
        }
        if (!permissions.isEmpty()) { requestPermissions(permissions.toArray(new String[0]), 17); return; }
        calls.dial(phone.getText().toString().trim());
    }
    @Override public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] results) {
        super.onRequestPermissionsResult(requestCode, permissions, results);
        if (requestCode == 17) status.setText("Microphone permission is required. Tap Call phone again when ready.");
    }
}
