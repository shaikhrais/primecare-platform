package ca.primecare.calls;

import org.json.JSONObject;
import java.io.IOException;

/** Reuses current registered auth and scoped external-call endpoints unchanged. */
public class NativeSessionClient extends BoundedJsonClient {
    private volatile String token;
    public NativeSessionClient() { super(); }
    NativeSessionClient(Transport transport) { super(transport); }
    public JSONObject login(String email, String password) throws Exception {
        return post("/v1/auth/login", null, new JSONObject().put("email", email).put("password", password));
    }
    public JSONObject mfa(String challenge, String code) throws Exception {
        return post("/v1/auth/mfa", null, new JSONObject().put("challenge", challenge).put("code", code));
    }
    public JSONObject confirm(JSONObject authenticated) throws Exception {
        String candidate = authenticated.getString("token");
        if (!candidate.matches("[A-Za-z0-9_-]{43}")) throw new IOException("Invalid session");
        try {
            JSONObject identity = post("/v1/auth/me", candidate, new JSONObject());
            if (!"authenticated".equals(identity.optString("status"))
                    || !identity.optString("userId").matches("[A-Za-z0-9][A-Za-z0-9_-]{0,199}")
                    || identity.optString("roles").trim().isEmpty()) throw new IOException("Invalid identity");
            JSONObject state = post("/v1/external-calls/state", candidate, new JSONObject());
            token = candidate;
            return state;
        } catch (Exception error) {
            try { post("/v1/auth/logout", candidate, new JSONObject()); } catch (Exception ignored) { }
            throw error;
        }
    }
    public boolean signedIn() { return token != null; }
    public JSONObject state() throws Exception { return post("/v1/external-calls/state", session(), new JSONObject()); }
    public JSONObject prepare(String phone, String requestId) throws Exception {
        return post("/v1/external-calls/prepare", session(), new JSONObject().put("phone", phone).put("requestId", requestId));
    }
    public void end(String ticket) throws Exception {
        post("/v1/external-calls/end", session(), new JSONObject().put("ticket", ticket));
    }
    public void logout() throws Exception {
        String current = session();
        JSONObject result = post("/v1/auth/logout", current, new JSONObject());
        if (!"signed_out".equals(result.optString("status"))) throw new IOException("Sign out failed");
        token = null;
    }
    public void forget() { token = null; }
    private String session() throws IOException {
        String current = token;
        if (current == null) throw new IOException("Sign in required");
        return current;
    }
}
