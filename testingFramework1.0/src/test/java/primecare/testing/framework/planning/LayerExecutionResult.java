package primecare.testing.framework.planning;

public class LayerExecutionResult {
    public final boolean passed;
    public final String message;
    public final Throwable error;

    public LayerExecutionResult(boolean passed, String message, Throwable error) {
        this.passed = passed;
        this.message = message;
        this.error = error;
    }

    public static LayerExecutionResult pass(String message) {
        return new LayerExecutionResult(true, message, null);
    }

    public static LayerExecutionResult fail(String message, Throwable error) {
        return new LayerExecutionResult(false, message, error);
    }
}
