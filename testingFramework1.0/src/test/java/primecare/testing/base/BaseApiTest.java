package primecare.testing.base;

import io.restassured.RestAssured;
import io.restassured.specification.RequestSpecification;
import org.testng.annotations.BeforeClass;

public class BaseApiTest extends BaseTest {
    protected String apiBaseUrl;

    @BeforeClass(alwaysRun = true)
    public void setupApi() {
        apiBaseUrl = appProps.getProperty("API_BASE_URL", "http://localhost:8080/api");
        RestAssured.baseURI = apiBaseUrl;
    }

    protected RequestSpecification getGuestRequest() {
        return RestAssured.given()
                .header("Content-Type", "application/json")
                .header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
    }

    protected RequestSpecification getAuthenticatedRequest(String role) {
        // Retrieve bearer token from configuration or call login endpoint
        String token = appProps.getProperty("auth.token." + role.toLowerCase(), "mock_token_" + role.toUpperCase());
        return getGuestRequest()
                .header("Authorization", "Bearer " + token);
    }
}
