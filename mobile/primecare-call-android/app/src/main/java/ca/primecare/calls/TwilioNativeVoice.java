package ca.primecare.calls;

import android.content.Context;
import android.media.AudioAttributes;
import android.media.AudioFocusRequest;
import android.media.AudioManager;
import com.twilio.voice.Call;
import com.twilio.voice.CallException;
import com.twilio.voice.ConnectOptions;
import com.twilio.voice.LogLevel;
import com.twilio.voice.Voice;
import java.util.Collections;

/** All Voice SDK operations run on the main Looper, per Twilio's contract. */
public final class TwilioNativeVoice implements VoicePort {
    private final Context context;
    private final AudioManager audio;
    private Call call;
    private AudioFocusRequest focus;
    private int previousMode;
    private boolean previousSpeaker;
    private int generation;
    public TwilioNativeVoice(Context context) {
        this.context = context.getApplicationContext();
        audio = (AudioManager) context.getSystemService(Context.AUDIO_SERVICE);
    }
    @Override public void connect(String token, String ticket, Events events) {
        disconnect();
        final int current = ++generation;
        Voice.setLogLevel(LogLevel.OFF);
        previousMode = audio.getMode();
        previousSpeaker = audio.isSpeakerphoneOn();
        focus = new AudioFocusRequest.Builder(AudioManager.AUDIOFOCUS_GAIN_TRANSIENT)
                .setAudioAttributes(new AudioAttributes.Builder().setUsage(AudioAttributes.USAGE_VOICE_COMMUNICATION)
                        .setContentType(AudioAttributes.CONTENT_TYPE_SPEECH).build())
                .setOnAudioFocusChangeListener(change -> {
                    if (change == AudioManager.AUDIOFOCUS_LOSS || change == AudioManager.AUDIOFOCUS_LOSS_TRANSIENT) {
                        if (current == generation) { disconnect(); events.ended(true); }
                    }
                }).build();
        if (audio.requestAudioFocus(focus) != AudioManager.AUDIOFOCUS_REQUEST_GRANTED) {
            audio.abandonAudioFocusRequest(focus); focus = null;
            throw new IllegalStateException("Audio is in use");
        }
        audio.setMode(AudioManager.MODE_IN_COMMUNICATION);
        audio.setSpeakerphoneOn(false);
        ConnectOptions options = new ConnectOptions.Builder(token)
                .params(Collections.singletonMap("Ticket", ticket)).build();
        call = Voice.connect(context, options, new Call.Listener() {
            private void status(String value) { if (current == generation) events.status(value); }
            private void ended(boolean failed) {
                if (current != generation) return;
                disconnect(); events.ended(failed);
            }
            @Override public void onRinging(Call value) { status("Ringing…"); }
            @Override public void onConnected(Call value) { status("Connected"); }
            @Override public void onReconnecting(Call value, CallException error) { status("Reconnecting…"); }
            @Override public void onReconnected(Call value) { status("Connected"); }
            @Override public void onConnectFailure(Call value, CallException error) { ended(true); }
            @Override public void onDisconnected(Call value, CallException error) { ended(error != null); }
        });
    }
    @Override public void mute(boolean muted) { if (call != null) call.mute(muted); }
    @Override public void speaker(boolean enabled) { if (call != null) audio.setSpeakerphoneOn(enabled); }
    @Override public void disconnect() {
        ++generation;
        Call previous = call; call = null;
        if (previous != null) previous.disconnect();
        if (focus != null) {
            audio.setSpeakerphoneOn(previousSpeaker);
            audio.setMode(previousMode);
            audio.abandonAudioFocusRequest(focus); focus = null;
        }
    }
}
