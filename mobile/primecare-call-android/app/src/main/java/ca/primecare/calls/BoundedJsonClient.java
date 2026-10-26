package ca.primecare.calls;

import org.json.JSONObject;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Set;
import javax.net.ssl.HttpsURLConnection;

/** Fixed-origin, bounded HTTPS transport. No cookies, redirects or token logging. */
public abstract class BoundedJsonClient {
    static final String ORIGIN = "https://primecare-api-gateway.itpro-mohammed.workers.dev";
    static final Set<String> PATHS = java.util.Collections.unmodifiableSet(new java.util.HashSet<>(java.util.Arrays.asList("/v1/auth/login", "/v1/auth/mfa", "/v1/auth/me",
            "/v1/auth/logout", "/v1/external-calls/state", "/v1/external-calls/prepare", "/v1/external-calls/end")));
    public static final class ApiException extends IOException {
        public final int status;
        ApiException(int status) { super("Request failed (" + status + ")"); this.status = status; }
    }
    public interface Transport { JSONObject send(String path, String token, JSONObject body) throws Exception; }
    private final Transport transport;
    protected BoundedJsonClient() { this.transport = BoundedJsonClient::https; }
    protected BoundedJsonClient(Transport transport) { this.transport = transport; }
    protected JSONObject post(String path, String token, JSONObject body) throws Exception {
        if (!PATHS.contains(path)) throw new IllegalArgumentException("Unapproved endpoint");
        if (token != null && !token.matches("[A-Za-z0-9_-]{43}")) throw new IOException("Invalid session");
        return transport.send(path, token, body);
    }
    private static JSONObject https(String path, String token, JSONObject body) throws Exception {
        byte[] bytes = body.toString().getBytes(StandardCharsets.UTF_8);
        if (bytes.length > 4096) throw new IOException("Request too large");
        HttpsURLConnection connection = (HttpsURLConnection) new URL(ORIGIN + path).openConnection();
        try {
            connection.setInstanceFollowRedirects(false);
            connection.setConnectTimeout(8000);
            connection.setReadTimeout(8000);
            connection.setUseCaches(false);
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Accept", "application/json");
            connection.setRequestProperty("Cache-Control", "no-store");
            if (token != null) connection.setRequestProperty("Authorization", "Bearer " + token);
            connection.setDoOutput(true);
            connection.setFixedLengthStreamingMode(bytes.length);
            try (var output = connection.getOutputStream()) { output.write(bytes); }
            int status = connection.getResponseCode();
            if (status < 200 || status > 299) throw new ApiException(status);
            String type = connection.getContentType();
            if (type == null || !type.split(";")[0].trim().equalsIgnoreCase("application/json")) {
                throw new IOException("Invalid response");
            }
            try (InputStream input = connection.getInputStream(); ByteArrayOutputStream output = new ByteArrayOutputStream()) {
                byte[] buffer = new byte[4096];
                int count;
                while ((count = input.read(buffer)) != -1) {
                    if (output.size() + count > 32768) throw new IOException("Response too large");
                    output.write(buffer, 0, count);
                }
                return new JSONObject(output.toString(StandardCharsets.UTF_8.name()));
            }
        } finally { connection.disconnect(); }
    }
}
