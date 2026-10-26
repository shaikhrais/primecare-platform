package ca.primecare.calls;

/** Composition root uses the same native calling screen and controller lifecycle. */
public final class MainActivity extends NativeCallActivityBase {
    @Override protected NativeCallController controller() {
        return ((PrimeCareApplication) getApplication()).calls();
    }
}
