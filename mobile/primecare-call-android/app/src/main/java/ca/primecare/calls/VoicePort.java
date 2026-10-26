package ca.primecare.calls;

/** Platform media boundary; tests never instantiate the provider or place calls. */
public interface VoicePort {
    interface Events { void status(String text); void ended(boolean failed); }
    void connect(String accessToken, String ticket, Events events);
    void mute(boolean muted);
    void speaker(boolean enabled);
    void disconnect();
}
