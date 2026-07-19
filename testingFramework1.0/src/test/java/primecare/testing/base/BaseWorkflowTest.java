package primecare.testing.base;

import java.util.HashMap;
import java.util.Map;

public class BaseWorkflowTest extends BaseUiTest {
    protected final Map<String, Object> workflowContext = new HashMap<>();

    public void setContext(String key, Object value) {
        workflowContext.put(key, value);
    }

    @SuppressWarnings("unchecked")
    public <T> T getContext(String key) {
        return (T) workflowContext.get(key);
    }

    public void clearContext() {
        workflowContext.clear();
    }
}
