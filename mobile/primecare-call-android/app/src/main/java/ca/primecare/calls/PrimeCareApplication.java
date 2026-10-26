package ca.primecare.calls;

import android.Manifest;
import android.app.Application;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import java.util.concurrent.Executors;

/** Process-owned memory session; no password, MFA seed or token is written to disk. */
public final class PrimeCareApplication extends Application {
    private NativeCallController controller;
    public NativeCallController calls() {
        if (controller == null) {
            controller = new NativeCallController(new NativeSessionClient(), new TwilioNativeVoice(this),
                    Executors.newSingleThreadExecutor(), new Handler(Looper.getMainLooper()), new NativeCallController.Lifecycle() {
                @Override public boolean microphoneAllowed() {
                    return checkSelfPermission(Manifest.permission.RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED;
                }
                @Override public void startCallService() {
                    Intent intent = new Intent(PrimeCareApplication.this, NativeCallService.class);
                    if (Build.VERSION.SDK_INT >= 26) startForegroundService(intent);
                    else startService(intent);
                }
                @Override public void stopCallService() {
                    stopService(new Intent(PrimeCareApplication.this, NativeCallService.class));
                }
            });
        }
        return controller;
    }
}
