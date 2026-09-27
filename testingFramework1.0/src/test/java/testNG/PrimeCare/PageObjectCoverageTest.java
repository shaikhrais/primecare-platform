package testNG.PrimeCare;

import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Fast, browser-free contract test for complete Page Object coverage.
 *
 * This test validates the source-of-truth governance database against every
 * generated Page Object. It deliberately does not start Selenium: the platform
 * build workflows verify compilation, while full browser verification remains
 * available through AllScreensVerificationTest when explicitly requested.
 */
public class PageObjectCoverageTest {

    private static final Pattern ROUTE_PATTERN = Pattern.compile(
        "verifyNavigationProtocol\\(\\s*(?:SCREEN_ID|\\d+)\\s*,\\s*\"([^\"]+)\"\\s*,\\s*\"([^\"]+)\"\\)"
    );

    @Test
    public void everyActiveScreenHasPageObject() throws Exception {
        File pomDirectory = new File("src/test/java/PageObjects/primecare/ui");
        Assert.assertTrue(pomDirectory.isDirectory(),
            "POM directory not found with exact Linux casing: " + pomDirectory.getAbsolutePath());

        Map<String, String> routeToClass = new HashMap<>();
        Set<String> duplicateRoutes = new HashSet<>();
        File[] files = pomDirectory.listFiles((dir, name) -> name.endsWith(".java"));
        Assert.assertNotNull(files, "Unable to list POM directory");

        for (File file : files) {
            String source = Files.readString(file.toPath(), StandardCharsets.UTF_8);
            Matcher matcher = ROUTE_PATTERN.matcher(source);
            if (!matcher.find()) {
                continue;
            }

            String route = cleanRoute(matcher.group(2));
            String previous = routeToClass.putIfAbsent(route, file.getName());
            if (previous != null && !previous.equals(file.getName())) {
                duplicateRoutes.add(route + " -> " + previous + ", " + file.getName());
            }
        }

        Assert.assertTrue(routeToClass.size() > 0,
            "No Page Object routes were discovered; check scanner path casing and source format");

        String dbUrl = System.getProperty(
            "db.url",
            "jdbc:sqlite:../.agents/governance/governance.db"
        );

        Set<String> activeRoutes = new HashSet<>();
        try (Connection connection = DriverManager.getConnection(dbUrl);
             Statement statement = connection.createStatement();
             ResultSet rows = statement.executeQuery(
                 "SELECT route_path FROM screens " +
                 "WHERE active = 1 AND route_path IS NOT NULL " +
                 "AND TRIM(route_path) <> ''"
             )) {
            while (rows.next()) {
                activeRoutes.add(cleanRoute(rows.getString("route_path")));
            }
        }

        Set<String> missingRoutes = new HashSet<>(activeRoutes);
        missingRoutes.removeAll(routeToClass.keySet());

        System.out.printf(
            "POM coverage: %d Java files, %d mapped routes, %d active routes, %d missing%n",
            files.length,
            routeToClass.size(),
            activeRoutes.size(),
            missingRoutes.size()
        );

        Assert.assertTrue(
            missingRoutes.isEmpty(),
            "Active screens missing Page Objects: " + missingRoutes
        );

        if (!duplicateRoutes.isEmpty()) {
            System.out.println("Duplicate route aliases (non-blocking): " + duplicateRoutes);
        }
    }

    private static String cleanRoute(String route) {
        if (route == null) {
            return "";
        }
        return route.split("\\?", 2)[0].trim();
    }
}
