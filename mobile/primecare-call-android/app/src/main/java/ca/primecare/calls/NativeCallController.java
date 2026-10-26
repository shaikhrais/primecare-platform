package ca.primecare.calls;

import android.os.Handler;
import org.json.JSONObject;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.Executor;

/** Shared session and call lifecycle. Media is injected; authority stays server-side. */
public final class NativeCallController {
    public interface Lifecycle {
        boolean microphoneAllowed();
        void startCallService();
        void stopCallService();
    }
    private final NativeSessionClient api;
    private final VoicePort voice;
    private final Executor worker;
    private final Handler main;
    private final Lifecycle lifecycle;
    private final List<Runnable> observers = new ArrayList<>();
    private int operation;
    private String challenge;
    private String setupKey;
    private String ticket;
    private String selectedPhone;
    private boolean busy;
    private boolean media;
    private boolean muted;
    private boolean speaker;
    private boolean startingService;
    private String message = "Sign in to call";
    private final Runnable watchdog = this::watch;

    public NativeCallController(NativeSessionClient api, VoicePort voice, Executor worker, Handler main, Lifecycle lifecycle) {
        this.api = api; this.voice = voice; this.worker = worker; this.main = main; this.lifecycle = lifecycle;
    }
    public boolean signedIn() { return api.signedIn(); }
    public boolean busy() { return busy; }
    public boolean hasReservation() { return ticket != null; }
    public boolean mediaActive() { return media; }
    public boolean muted() { return muted; }
    public boolean speaker() { return speaker; }
    public boolean needsMfa() { return challenge != null; }
    public String setupKey() { return setupKey; }
    public String message() { return message; }
    public void observe(Runnable callback) { observers.add(callback); callback.run(); }
    public void removeObserver(Runnable callback) { observers.remove(callback); }
    private void changed() { for (Runnable observer : new ArrayList<>(observers)) observer.run(); }
    private void message(String value) { message = value; changed(); }

    public void login(String email, String password) {
        if (busy || signedIn()) return;
        if (email.trim().isEmpty() || email.length() > 254 || password.isEmpty()
                || password.getBytes(java.nio.charset.StandardCharsets.UTF_8).length > 72) {
            message("Enter your email and password"); return;
        }
        busy = true; challenge = null; setupKey = null;
        int current = ++operation; message("Signing in…");
        worker.execute(() -> {
            try {
                JSONObject result = api.login(email.trim(), password);
                if ("mfa_required".equals(result.optString("status"))) {
                    String pending = result.getString("challenge");
                    String purpose = result.getString("purpose");
                    String seed = result.optString("setupKey", "");
                    if (!pending.matches("[A-Za-z0-9_-]{43}") || !(purpose.equals("verify") || purpose.equals("enroll"))
                            || purpose.equals("enroll") && !seed.matches("[A-Z2-7]{32}")) throw new Exception("Invalid MFA");
                    main.post(() -> {
                        if (current != operation) return;
                        busy = false; challenge = pending; setupKey = purpose.equals("enroll") ? seed : null;
                        message("Enter the six-digit authenticator code");
                    });
                } else confirm(result, current);
            } catch (Exception error) { authFailed(current); }
        });
    }
    public void verifyMfa(String code) {
        if (busy || challenge == null) return;
        if (!code.matches("[0-9]{6}")) { message("Enter a six-digit code"); return; }
        String pending = challenge;
        int current = ++operation; busy = true; message("Verifying…");
        worker.execute(() -> {
            try { confirm(api.mfa(pending, code), current); }
            catch (Exception error) { authFailed(current); }
        });
    }
    private void confirm(JSONObject result, int current) throws Exception {
        JSONObject state = api.confirm(result);
        main.post(() -> {
            if (current != operation) return;
            challenge = null; setupKey = null; busy = false;
            restore(state);
            message(ticket == null ? "Ready to call" : "An earlier call is reserved. Tap End call before dialing.");
        });
    }
    private void authFailed(int current) {
        main.post(() -> {
            if (current != operation) return;
            busy = false;
            message("Sign-in or verification failed. Check credentials, calling access and connection.");
        });
    }
    public void cancelMfa() {
        if (busy || signedIn()) return;
        ++operation; challenge = null; setupKey = null; message("Sign in to call");
    }
    private void restore(JSONObject state) {
        String status = state.optString("status");
        if ((status.equals("prepared") || status.equals("active")) && state.optString("ticket").matches("[a-f0-9-]{36}")) {
            ticket = state.optString("ticket");
            selectedPhone = state.optString("phone");
        }
    }
    public void dial(String phone) {
        if (busy || !signedIn() || ticket != null) return;
        if (!phone.matches("\\+[1-9][0-9]{6,14}")) { message("Enter a full phone number with country code, such as +1…"); return; }
        if (!lifecycle.microphoneAllowed()) { message("Allow microphone access, then tap Call phone again"); return; }
        ++operation; busy = true; selectedPhone = phone; ticket = UUID.randomUUID().toString();
        startingService = true; message("Preparing call…");
        try { lifecycle.startCallService(); }
        catch (Exception error) {
            startingService = false; ticket = null; selectedPhone = null; busy = false;
            message("Unable to start Android call service. Check microphone permission.");
        }
    }
    /** Invoked only after Service.startForeground succeeded; not from background auto-start. */
    public void foregroundReady() {
        if (!startingService) return;
        startingService = false;
        final int current = operation;
        final String reservation = ticket, phone = selectedPhone;
        worker.execute(() -> {
            try {
                JSONObject prepared = api.prepare(phone, reservation);
                String jwt = prepared.getString("token");
                if (!reservation.equals(prepared.getString("ticket")) || jwt.length() > 8192 || jwt.split("\\.").length != 3) {
                    throw new Exception("Invalid call response");
                }
                main.post(() -> {
                    if (current != operation || !reservation.equals(ticket)) return;
                    if (!lifecycle.microphoneAllowed()) { end(); return; }
                    try {
                        media = true;
                        voice.connect(jwt, reservation, new VoicePort.Events() {
                            @Override public void status(String value) {
                                if (current == operation) message(value);
                            }
                            @Override public void ended(boolean failed) {
                                if (current == operation) {
                                    end();
                                    message(failed ? "Call disconnected. Ending reservation…" : "Call ended. Releasing reservation…");
                                }
                            }
                        });
                        if (current != operation || !media) return;
                        busy = false; message("Calling " + phone + "…");
                        main.postDelayed(watchdog, 2000);
                    } catch (Exception error) { end(); }
                });
            } catch (Exception error) {
                main.post(() -> {
                    if (current != operation) return;
                    // Keep the same ticket for End: the prepare request may have committed.
                    releaseMedia(); busy = false;
                    message("Unable to start call. Tap End call to clear this attempt before retrying.");
                });
            }
        });
    }
    public void serviceFailed() {
        if (startingService) { startingService = false; end(); }
    }
    public void toggleMute() {
        if (!media) return;
        muted = !muted; voice.mute(muted); changed();
    }
    public void toggleSpeaker() {
        if (!media) return;
        speaker = !speaker; voice.speaker(speaker); changed();
    }
    private void watch() {
        if (!media || ticket == null) return;
        final int current = operation;
        final String reservation = ticket;
        if (!lifecycle.microphoneAllowed()) { end(); return; }
        worker.execute(() -> {
            try {
                JSONObject state = api.state();
                String status = state.optString("status");
                boolean active = reservation.equals(state.optString("ticket")) && (status.equals("prepared") || status.equals("active"));
                main.post(() -> {
                    if (current != operation) return;
                    if (!active) { end(); return; }
                    main.postDelayed(watchdog, 2000);
                });
            } catch (Exception error) {
                main.post(() -> {
                    if (current != operation) return;
                    end(); message("Call closed. Check your session, calling access and connection.");
                });
            }
        });
    }
    public void end() {
        final String reservation = ticket;
        final int current = ++operation;
        startingService = false; releaseMedia();
        if (reservation == null) { busy = false; message("Ready to call"); return; }
        busy = true; message("Ending call…");
        worker.execute(() -> {
            boolean ended = false;
            try { api.end(reservation); ended = true; }
            catch (BoundedJsonClient.ApiException error) { ended = error.status == 404; }
            catch (Exception ignored) { }
            final boolean confirmed = ended;
            main.post(() -> {
                if (current != operation) return;
                busy = false;
                if (confirmed) { ticket = null; selectedPhone = null; }
                message(confirmed ? "Call ended" : "Audio stopped. Could not confirm server cleanup; tap End call to retry.");
            });
        });
    }
    private void releaseMedia() {
        main.removeCallbacks(watchdog);
        media = false; muted = false; speaker = false;
        voice.disconnect(); lifecycle.stopCallService();
    }
    public void logout() {
        if (busy || !signedIn()) return;
        final int current = ++operation;
        String reservation = ticket;
        startingService = false; releaseMedia(); busy = true; message("Signing out…");
        worker.execute(() -> {
            boolean signedOut = false;
            try {
                if (reservation != null) { try { api.end(reservation); } catch (Exception ignored) { } }
                api.logout(); signedOut = true;
            } catch (Exception ignored) { }
            final boolean confirmed = signedOut;
            main.post(() -> {
                if (current != operation) return;
                busy = false;
                if (confirmed) { ticket = null; selectedPhone = null; challenge = null; setupKey = null; }
                message(confirmed ? "Signed out" : "Audio stopped. Could not confirm sign out; try again.");
            });
        });
    }
    /** Foreground service destruction releases media even if no Activity exists. */
    public int serviceGeneration() { return operation; }
    public void serviceDestroyed(int generation) {
        if (generation == operation && (media || startingService)) end();
    }
}
