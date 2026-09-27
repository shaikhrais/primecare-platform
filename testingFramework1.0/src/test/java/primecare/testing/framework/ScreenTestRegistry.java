package primecare.testing.framework;

import java.util.*;

public class ScreenTestRegistry {
    private static final Map<String, ScreenTestProvider> registry = new HashMap<>();
    private static final Map<String, List<ScreenTestProvider>> moduleRegistry = new HashMap<>();

    public static synchronized void register(ScreenTestProvider provider) {
        String key = provider.getScreenKey();
        if (registry.containsKey(key)) {
            throw new IllegalArgumentException("DuplicateInitializationException: Duplicate screen test provider for key '" + key + "'");
        }
        registry.put(key, provider);

        PrimeCareScreenTestSuite anno = provider.getClass().getAnnotation(PrimeCareScreenTestSuite.class);
        if (anno != null) {
            String module = anno.module();
            moduleRegistry.computeIfAbsent(module, k -> new ArrayList<>()).add(provider);
        }
    }

    public static Optional<ScreenTestProvider> findByScreenKey(String screenKey) {
        return Optional.ofNullable(registry.get(screenKey));
    }

    public static List<ScreenTestProvider> findByModule(String moduleName) {
        return moduleRegistry.getOrDefault(moduleName, Collections.emptyList());
    }

    public static List<ScreenTestProvider> findAll() {
        return new ArrayList<>(registry.values());
    }

    public static void clear() {
        registry.clear();
        moduleRegistry.clear();
    }
}

