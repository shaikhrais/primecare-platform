package ca.primecare.calls;

import android.Manifest;
import android.os.Handler;
import android.os.Looper;
import android.widget.EditText;
import org.json.JSONObject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.robolectric.Robolectric;
import org.robolectric.RobolectricTestRunner;
import org.robolectric.annotation.Config;
import org.robolectric.annotation.LooperMode;
import org.robolectric.Shadows;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executor;
import java.util.concurrent.TimeUnit;
import static org.junit.Assert.*;

@RunWith(RobolectricTestRunner.class)
@Config(sdk = 35)
@LooperMode(LooperMode.Mode.PAUSED)
public class NativeCallingTest {
    private static final String SESSION = "s".repeat(43);
    private static final String CHALLENGE = "c".repeat(43);
    static class Fixture implements BoundedJsonClient.Transport {
        final List<String> paths = new ArrayList<>();
        final List<JSONObject> bodies = new ArrayList<>();
        String ticket;
        boolean denied, mfa, cleanupFails;
        @Override public JSONObject send(String path, String token, JSONObject body) throws Exception {
            paths.add(path); bodies.add(body);
            if (path.equals("/v1/auth/login")) {
                assertNull(token);
                return mfa ? new JSONObject().put("status", "mfa_required").put("challenge", CHALLENGE).put("purpose", "verify")
                        : new JSONObject().put("status", "authenticated").put("token", SESSION);
            }
            if (path.equals("/v1/auth/mfa")) {
                assertNull(token); assertEquals(CHALLENGE, body.getString("challenge"));
                return new JSONObject().put("status", "authenticated").put("token", SESSION);
            }
            assertEquals(SESSION, token);
            switch (path) {
                case "/v1/auth/me": return new JSONObject().put("userId", "staff1").put("roles", "staff").put("status", "authenticated");
                case "/v1/auth/logout": return new JSONObject().put("status", "signed_out");
                case "/v1/external-calls/state":
                    if (denied) throw new BoundedJsonClient.ApiException(403);
                    return ticket == null ? new JSONObject().put("status", "idle") : new JSONObject().put("status", "active").put("ticket", ticket).put("phone", "+16475550123");
                case "/v1/external-calls/prepare":
                    assertEquals(2, body.length());
                    ticket = body.getString("requestId");
                    return new JSONObject().put("ticket", ticket).put("token", "test.jwt.fixture");
                case "/v1/external-calls/end":
                    assertEquals(1, body.length());
                    if (cleanupFails || denied) throw new BoundedJsonClient.ApiException(503);
                    ticket = null; return new JSONObject().put("status", "ended");
                default: throw new AssertionError("Unexpected endpoint");
            }
        }
    }
    static class FakeVoice implements VoicePort {
        int connects, disconnects; boolean muted, speaker;
        String ticket;
        Events events;
        @Override public void connect(String jwt, String value, Events callback) {
            connects++; ticket = value; events = callback;
        }
        @Override public void disconnect() { disconnects++; }
        @Override public void mute(boolean value) { muted = value; }
        @Override public void speaker(boolean value) { speaker = value; }
    }
    static class Life implements NativeCallController.Lifecycle {
        int starts, stops; boolean permission = true;
        @Override public boolean microphoneAllowed() { return permission; }
        @Override public void startCallService() { starts++; }
        @Override public void stopCallService() { stops++; }
    }
    static void idle() { Shadows.shadowOf(Looper.getMainLooper()).idle(); }
    static NativeCallController controller(Fixture f, FakeVoice v, Life life, Executor executor) {
        return new NativeCallController(new NativeSessionClient(f), v, executor, new Handler(Looper.getMainLooper()), life);
    }
    static void login(NativeCallController c) { c.login("staff@example.test", "test-password"); idle(); assertTrue(c.signedIn()); }

    @Test public void nativeLoginChecksIdentityAndCallingPermissionWithoutPlacingCall() {
        Fixture f = new Fixture(); FakeVoice v = new FakeVoice(); Life life = new Life();
        NativeCallController c = controller(f,v,life,Runnable::run); login(c);
        assertEquals(List.of("/v1/auth/login", "/v1/auth/me", "/v1/external-calls/state"), f.paths);
        assertEquals(0,v.connects); assertEquals(0,life.starts);
    }
    @Test public void deniedCallingGrantRevokesProvisionalSession() {
        Fixture f = new Fixture(); f.denied = true;
        NativeCallController c = controller(f,new FakeVoice(),new Life(),Runnable::run);
        c.login("staff@example.test", "test-password"); idle();
        assertFalse(c.signedIn()); assertTrue(f.paths.contains("/v1/auth/logout"));
    }
    @Test public void mfaCompletesInsideAppBeforeNativeSessionIsCommitted() {
        Fixture f = new Fixture(); f.mfa = true;
        NativeCallController c = controller(f,new FakeVoice(),new Life(),Runnable::run);
        c.login("admin@example.test", "test-password"); idle();
        assertTrue(c.needsMfa()); assertFalse(c.signedIn());
        c.verifyMfa("123456"); idle(); assertTrue(c.signedIn()); assertFalse(c.needsMfa());
    }
    @Test public void permissionDenialNeverPreparesOrStartsMedia() {
        Fixture f = new Fixture(); FakeVoice v = new FakeVoice(); Life life = new Life(); life.permission = false;
        NativeCallController c = controller(f,v,life,Runnable::run); login(c);
        c.dial("+16475550123"); idle();
        assertFalse(f.paths.contains("/v1/external-calls/prepare")); assertEquals(0,v.connects); assertEquals(0,life.starts);
    }
    @Test public void foregroundServiceMustStartBeforeTicketOnlyNativeConnection() {
        Fixture f = new Fixture(); FakeVoice v = new FakeVoice(); Life life = new Life();
        NativeCallController c = controller(f,v,life,Runnable::run); login(c);
        c.dial("+16475550123"); idle(); assertEquals(1,life.starts); assertEquals(0,v.connects);
        c.foregroundReady(); idle(); assertEquals(1,v.connects); assertEquals(f.ticket,v.ticket);
        c.toggleMute(); assertTrue(v.muted); c.toggleSpeaker(); assertTrue(v.speaker);
        c.end(); idle(); assertFalse(c.mediaActive()); assertFalse(c.hasReservation()); assertTrue(life.stops > 0);
    }
    @Test public void currentGrantRevocationStopsNativeAudioAndKeepsCleanupRetry() {
        Fixture f = new Fixture(); FakeVoice v = new FakeVoice(); Life life = new Life();
        NativeCallController c = controller(f,v,life,Runnable::run); login(c);
        c.dial("+16475550123"); c.foregroundReady(); idle(); f.denied = true;
        Shadows.shadowOf(Looper.getMainLooper()).idleFor(2, TimeUnit.SECONDS); idle();
        assertFalse(c.mediaActive()); assertTrue(c.hasReservation()); assertTrue(v.disconnects > 0);
        f.denied = false; c.end(); idle(); assertFalse(c.hasReservation());
    }
    @Test public void hangupBeforePrepareReturnsCannotConnectStaleMedia() {
        Fixture f = new Fixture(); FakeVoice v = new FakeVoice(); Life life = new Life();
        List<Runnable> queue = new ArrayList<>();
        NativeCallController c = controller(f,v,life,queue::add);
        c.login("staff@example.test", "test-password"); queue.remove(0).run(); idle();
        c.dial("+16475550123"); c.foregroundReady();
        c.end();
        while (!queue.isEmpty()) queue.remove(0).run(); idle();
        assertEquals(0,v.connects); assertFalse(c.hasReservation());
    }
    @Test public void failedCleanupDoesNotAllowDuplicateCall() {
        Fixture f = new Fixture(); FakeVoice v = new FakeVoice(); Life life = new Life();
        NativeCallController c = controller(f,v,life,Runnable::run); login(c);
        c.dial("+16475550123"); c.foregroundReady(); idle(); f.cleanupFails = true;
        c.end(); idle(); c.dial("+16475550999"); assertEquals(1,v.connects); assertTrue(c.hasReservation());
        f.cleanupFails = false; c.end(); idle(); assertFalse(c.hasReservation());
    }
    @Test public void oldServiceDestructionCannotEndNewCall() {
        Fixture f = new Fixture(); FakeVoice v = new FakeVoice(); Life life = new Life();
        NativeCallController c = controller(f,v,life,Runnable::run); login(c);
        c.dial("+16475550123"); c.foregroundReady(); idle(); int old = c.serviceGeneration();
        c.end(); idle(); c.dial("+16475550123"); c.foregroundReady(); idle();
        c.serviceDestroyed(old); assertTrue(c.mediaActive());
    }
    @Test public void nativeScreenLaunchDoesNotOpenBrowserOrAskForMicrophone() {
        var activity = Robolectric.buildActivity(MainActivity.class).setup().get();
        assertNotNull(activity.findViewById(R.id.sign_in));
        assertNull(Shadows.shadowOf(activity).getNextStartedActivity());
        assertNull(Shadows.shadowOf(activity).getLastRequestedPermission());
        assertTrue((activity.getWindow().getAttributes().flags & android.view.WindowManager.LayoutParams.FLAG_SECURE) != 0);
        assertFalse(((EditText) activity.findViewById(R.id.password)).isSaveEnabled());
    }
}
