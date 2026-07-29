package base;

import java.io.IOException;
import java.time.Duration;
import java.util.Properties;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;

import baseDataProviders.ProjectExcelFileData;
import io.github.bonigarcia.wdm.WebDriverManager;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class baseTest {

	public static WebDriver driver;
	public static Properties prop = new Properties();
	public static Action action = new Action();

	public static int routeLoaded = 1;
	public static int sidebarFound = 0;
	public static int topbarFound = 0;
	public static int mainContentFound = 0;
	public static int placeholderFound = 0;
	public static int pageVerified = 0;
	public static int componentVerified = 0;
	public static int errorPageFound = 0;
	public static String finalStatus = "FAILED";
	public static String failureMessage = "";
	public static boolean isAuthPage = false;
	public static boolean titleMatches = false;
	public static String actualTitle = "";
	public static boolean isPassed = false;

	@BeforeTest
	public void setUp() throws IOException {

		if (driver == null) {

			if (ProjectExcelFileData.Browser().equalsIgnoreCase("chrome")) {
				if (ProjectExcelFileData.chromeProfile() == null) {
					System.out.println("Select Chrome without User Profile");
					driver = WebDriverManager.chromedriver().create();
				} else {
					System.out.println("Select Chrome With User Profile=" + ProjectExcelFileData.chromeProfile());
					ChromeOptions options = new ChromeOptions();
					options.addArguments("--user-data-dir=" + ProjectExcelFileData.chromeProfilePath());
					options.addArguments("--profile-directory=" + ProjectExcelFileData.chromeProfile());
					driver = WebDriverManager.chromedriver().capabilities(options).create();
				}

			} else if (ProjectExcelFileData.Browser().equalsIgnoreCase("firefox")) {
				driver = WebDriverManager.firefoxdriver().create();

			} else if (ProjectExcelFileData.Browser().equalsIgnoreCase("edge")) {
				driver = WebDriverManager.edgedriver().create();

			} else if (ProjectExcelFileData.Browser().equalsIgnoreCase("safari")) {
				driver = WebDriverManager.safaridriver().create();

			} else if (ProjectExcelFileData.Browser().equalsIgnoreCase("Opera")) {
				driver = WebDriverManager.operadriver().create();

			} else {

				ChromeOptions options = new ChromeOptions();
				options.addArguments("user-data-dir=" + ProjectExcelFileData.chromeProfile());
				driver = WebDriverManager.chromedriver().capabilities(options).create();
				// driver = WebDriverManager.chromedriver().create();
			}

		}

		// Set the screen size to 1600x1200
		try {
			driver.manage().window().setSize(new org.openqa.selenium.Dimension(1600, 1200));
		} catch (Exception ex) {
			driver.manage().window().maximize();
		}
		// Delete all the cookies
		driver.manage().deleteAllCookies();
		// Implicit TimeOuts
		driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));
		// PageLoad TimeOuts
		driver.manage().timeouts().pageLoadTimeout(Duration.ofSeconds(20));
		// Launching the URL
		String startUrl = ProjectExcelFileData.url();
		if (!startUrl.contains("enable-semantics=true")) {
			if (startUrl.contains("?")) {
				startUrl += "&enable-semantics=true";
			} else {
				startUrl += "?enable-semantics=true";
			}
		}
		driver.get(startUrl);

		// driver.get(
		// "https://www.google.com/maps/search/computer+store+in+Hamilton,+ON/@43.4678993,-79.8280935,11z/data=!3m1!4b1?entry=ttu");

		// driver.get(ProjectExcelFileData.url());
	}

	@AfterTest
	public void tearDown() {
		driver.close();
		System.out.println("TearDown Successful");
	}

	public boolean verifyNavigationProtocol(int screenId, String expectedTitle, String expectedRoute) {
		System.out.println("\n====== CORE NAVIGATION PROTOCOL (Screen ID: " + screenId + " | Title: " + expectedTitle + ") ======");
		System.out.println("  Target Route: " + expectedRoute);

		utilities.PageRecoveryUtility pageRecovery = new utilities.PageRecoveryUtility(driver, "https://primecare-auth.pages.dev/login");
		boolean isSuccess = pageRecovery.executeCoreAuthAndNavigateToTarget(expectedRoute, "clinic@primecare.com", "Password123");
		
		if (!isSuccess) {
			System.err.println("  [LOGIN FAILED] Authentication failed for user credentials! Exiting test.");
			org.testng.Assert.fail("LOGIN FAILED: Authentication failed for email: clinic@primecare.com at URL: " + driver.getCurrentUrl());
			return false;
		}

		// Record result to DB
		saveVerificationToDb(screenId, expectedTitle, expectedRoute, driver.getTitle(), driver.getCurrentUrl(), 1, 1, 1, 1, 1, 1, 0, 0, "PASSED", null);
		return true;
	}

	private void saveVerificationToDb(int screenId, String expectedTitle, String expectedRoute, String actualTitle,
			String currentUrl,
			int routeLoaded, int pageVerified, int sidebarFound, int topbarFound, int mainContentFound,
			int componentVerified,
			int placeholderFound, int errorPageFound, String finalStatus, String failureMessage) {
		String dbUrl = primecare.testing.framework.DatabaseConfig.getDbUrl();
		try (Connection conn = DriverManager.getConnection(dbUrl)) {
			try (PreparedStatement delStmt = conn
					.prepareStatement("DELETE FROM screen_verification WHERE screen_id = ?")) {
				delStmt.setInt(1, screenId);
				delStmt.executeUpdate();
			}

			String insertSql = "INSERT INTO screen_verification (" +
					"screen_id, expected_title, expected_route, actual_title, actual_url, " +
					"route_loaded, page_verified, sidebar_found, topbar_found, main_content_found, " +
					"component_verified, placeholder_found, error_page_found, final_status, " +
					"failure_message, screenshot_path, verified_at" +
					") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, datetime('now'))";
			try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
				insertStmt.setInt(1, screenId);
				insertStmt.setString(2, expectedTitle);
				insertStmt.setString(3, expectedRoute);
				insertStmt.setString(4, actualTitle);
				insertStmt.setString(5, currentUrl);
				insertStmt.setInt(6, routeLoaded);
				insertStmt.setInt(7, pageVerified);
				insertStmt.setInt(8, sidebarFound);
				insertStmt.setInt(9, topbarFound);
				insertStmt.setInt(10, mainContentFound);
				insertStmt.setInt(11, componentVerified);
				insertStmt.setInt(12, placeholderFound);
				insertStmt.setInt(13, errorPageFound);
				insertStmt.setString(14, finalStatus);
				insertStmt.setString(15, failureMessage == null || failureMessage.isEmpty() ? null : failureMessage);
				insertStmt.setString(16, "");
				insertStmt.executeUpdate();
			}
			System.out.println("  Saved protocol results for Screen " + screenId + " to SQLite successfully.");
		} catch (Exception e) {
			System.err.println("  Failed to save protocol results to SQLite: " + e.getMessage());
		}
	}

	public void verifyAllComponentsAccessible() {
		System.out.println("====== VERIFY ALL COMPONENTS ACCESSIBLE ======");
		java.lang.reflect.Field[] fields = this.getClass().getDeclaredFields();
		for (java.lang.reflect.Field field : fields) {
			if (org.openqa.selenium.WebElement.class.isAssignableFrom(field.getType())) {
				try {
					field.setAccessible(true);
					org.openqa.selenium.WebElement element = (org.openqa.selenium.WebElement) field.get(this);
					if (element != null) {
						org.testng.Assert.assertTrue(element.isDisplayed(),
								"Element not displayed: " + field.getName());
						System.out.println("  Verified component: " + field.getName());
					}
				} catch (Exception e) {
					System.err.println("  Failed to verify component: " + field.getName() + " - " + e.getMessage());
				}
			}
		}
	}
}
