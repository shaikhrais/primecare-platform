package ca.primecare.calls;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Intent;
import android.content.pm.ServiceInfo;
import android.os.Build;
import android.os.IBinder;

/** User-started microphone foreground service; never creates or redials a call. */
public final class NativeCallService extends Service {
    private NativeCallController calls;
    private int generation = -1;
    @Override public void onCreate() {
        super.onCreate(); calls = ((PrimeCareApplication) getApplication()).calls();
        NotificationManager notifications = getSystemService(NotificationManager.class);
        notifications.createNotificationChannel(new NotificationChannel("active-calls", "Active calls", NotificationManager.IMPORTANCE_LOW));
    }
    @Override public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent != null && "END_CALL".equals(intent.getAction())) {
            calls.end(); stopSelf(); return START_NOT_STICKY;
        }
        if (!calls.hasReservation()) { stopSelf(); return START_NOT_STICKY; }
        PendingIntent open = PendingIntent.getActivity(this, 0, new Intent(this, MainActivity.class), PendingIntent.FLAG_IMMUTABLE | PendingIntent.FLAG_UPDATE_CURRENT);
        PendingIntent end = PendingIntent.getService(this, 1, new Intent(this, NativeCallService.class).setAction("END_CALL"), PendingIntent.FLAG_IMMUTABLE | PendingIntent.FLAG_UPDATE_CURRENT);
        Notification notification = new Notification.Builder(this, "active-calls")
                .setSmallIcon(R.drawable.ic_call).setContentTitle("PrimeCare call")
                .setContentText("Call service active · tap to return")
                .setContentIntent(open).setOngoing(true).setCategory(Notification.CATEGORY_CALL)
                .setVisibility(Notification.VISIBILITY_PRIVATE)
                .addAction(new Notification.Action.Builder(null, "End call", end).build()).build();
        try {
            generation = calls.serviceGeneration();
            if (Build.VERSION.SDK_INT >= 29) startForeground(73, notification, ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE);
            else startForeground(73, notification);
            calls.foregroundReady();
        } catch (RuntimeException error) { calls.serviceFailed(); stopSelf(); }
        return START_NOT_STICKY;
    }
    @Override public void onDestroy() {
        calls.serviceDestroyed(generation); super.onDestroy();
    }
    @Override public IBinder onBind(Intent intent) { return null; }
}
