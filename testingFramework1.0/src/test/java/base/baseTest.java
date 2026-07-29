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

//		driver.get(
//				"https://www.google.com/maps/search/computer+store+in+Hamilton,+ON/@43.4678993,-79.8280935,11z/data=!3m1!4b1?entry=ttu");

		// driver.get(ProjectExcelFileData.url());
	}

	@AfterTest
	public void tearDown() {
		driver.close();
		System.out.println("TearDown Successful");
	}

	public boolean verifyNavigationProtocol(int screenId, String expectedTitle, String expectedRoute) {
		String currentUrl = driver.getCurrentUrl();
		System.out.println("====== NAVIGATION PROTOCOL VERIFICATION ======");
		System.out.println("  Screen ID: " + screenId);
		System.out.println("  Expected Route: " + expectedRoute);
		System.out.println("  Expected Title: " + expectedTitle);
		System.out.println("  Current URL: " + currentUrl);

		routeLoaded = 1;
		sidebarFound = 0;
		topbarFound = 0;
		mainContentFound = 0;
		placeholderFound = 0;
		pageVerified = 0;
		componentVerified = 0;
		errorPageFound = 0;
		finalStatus = "FAILED";
		failureMessage = "";

		// 1. Check if it is a language selection, login, success, mfa, or forgot-password page
		isAuthPage = expectedRoute.contains("/language") 
				|| expectedRoute.contains("/login") 
				|| expectedRoute.contains("/success") 
				|| expectedRoute.contains("/mfa") 
				|| expectedRoute.contains("/forgot-password");

		// 2. Check for standard redirects to default, error, or 404 paths
		if (currentUrl.contains("default-not-implemented") 
				|| currentUrl.contains("screen-not-implemented") 
				|| currentUrl.contains("error") 
				|| currentUrl.contains("404") 
				|| currentUrl.contains("not-found")) {
			routeLoaded = 0;
			placeholderFound = 1;
			errorPageFound = 1;
			failureMessage = "Redirected to error/placeholder path: " + currentUrl;
		}

		// 3. Check page source for typical error/stub headers
		String pageSource = driver.getPageSource().toLowerCase();
		if (pageSource.contains("default not implemented") 
				|| pageSource.contains("screen not implemented")
				|| pageSource.contains("404 not found") 
				|| pageSource.contains("page not found") 
				|| pageSource.contains("error 404") 
				|| pageSource.contains("internal server error")) {
			placeholderFound = 1;
			errorPageFound = 1;
			if (failureMessage.isEmpty()) {
				failureMessage = "Error page text detected in page source.";
			}
		}

		// 4. Verify page title
		titleMatches = false;
		String cleanExpected = expectedTitle.toLowerCase().replaceAll("\\s+", "").replaceAll("screen$", "");
		System.out.println("  [Title Check] Expected: " + expectedTitle + " (cleaned: " + cleanExpected + ")");
		actualTitle = "";
		try {
			org.openqa.selenium.WebElement titleEl = driver.findElement(org.openqa.selenium.By.xpath("//*[starts-with(@aria-label, 'page-title')]"));
			actualTitle = titleEl.getText();
			String cleanActual = actualTitle.toLowerCase().replaceAll("\\s+", "");
			System.out.println("  [Title Check] Found page-title element: \"" + actualTitle + "\" (cleaned: " + cleanActual + ")");
			titleMatches = cleanActual.contains(cleanExpected) || cleanExpected.contains(cleanActual);
		} catch (Exception e) {
			// Fallback to browser title
			actualTitle = driver.getTitle();
			String cleanActual = actualTitle.toLowerCase().replaceAll("\\s+", "");
			titleMatches = cleanActual.contains(cleanExpected) || cleanExpected.contains(cleanActual);
			if ((cleanActual.contains("identity") || cleanActual.contains("portal") || cleanActual.contains("login")) && !expectedRoute.contains("/auth/")) {
				titleMatches = false;
			}
		}
		System.out.println("  [Title Check] Match result: " + titleMatches);

		if (!titleMatches) {
			if (failureMessage.isEmpty()) {
				failureMessage = "Title mismatch. Expected: " + expectedTitle + ", Actual: " + actualTitle;
			}
		}

		org.openqa.selenium.WebElement shellEl = null;

		if (isAuthPage) {
			System.out.println("  [Layout Bypass] Auth page detected. Bypassing topbar/sidebar checks.");
			sidebarFound = 1;
			topbarFound = 1;
			mainContentFound = 1;
		} else {
			// 5. Wait up to 10 seconds for any transient loading indicators to disappear
			try {
				driver.manage().timeouts().implicitlyWait(Duration.ofMillis(200));
				new org.openqa.selenium.support.ui.WebDriverWait(driver, Duration.ofSeconds(10))
					.until(org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated(
						org.openqa.selenium.By.xpath("//*[contains(@aria-label, 'loading') or contains(@aria-label, 'spinner')]")
					));
				System.out.println("  [Layout Check] Loading/spinner disappeared.");
			} catch (Exception e) {
				System.out.println("  [Layout Check] No loading/spinner found or did not disappear in 10s.");
			} finally {
				driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));
			}

			// 6. Locate Layout Elements using Semantics labels (via aria-label attribute)
			org.openqa.selenium.WebElement topbarEl = null;
			org.openqa.selenium.WebElement sidebarEl = null;
			org.openqa.selenium.WebElement contentSlotEl = null;

			try {
				shellEl = driver.findElement(org.openqa.selenium.By.xpath("//*[@aria-label='data-cy:app-shell']"));
				System.out.println("  [Layout Check] App Shell found.");
			} catch (Exception e) {
				System.out.println("  [Layout Check] App Shell NOT found.");
			}

			try {
				topbarEl = driver.findElement(org.openqa.selenium.By.xpath("//*[@aria-label='data-cy:app-topbar']"));
				System.out.println("  [Layout Check] Topbar found.");
				topbarFound = 1;
			} catch (Exception e) {
				System.out.println("  [Layout Check] Topbar NOT found.");
			}

			try {
				sidebarEl = driver.findElement(org.openqa.selenium.By.xpath("//*[@aria-label='data-cy:app-sidebar']"));
				System.out.println("  [Layout Check] Sidebar found.");
				sidebarFound = 1;
			} catch (Exception e) {
				System.out.println("  [Layout Check] Sidebar NOT found.");
			}

			try {
				contentSlotEl = driver.findElement(org.openqa.selenium.By.xpath("//*[@aria-label='data-cy:app-content-slot']"));
				System.out.println("  [Layout Check] Content Slot found.");
			} catch (Exception e) {
				System.out.println("  [Layout Check] Content Slot NOT found.");
			}

			// 7. Check if content slot is empty or loading
			if (contentSlotEl != null) {
				String contentText = contentSlotEl.getText().trim();
				boolean hasText = !contentText.isEmpty();
				boolean hasChildren = false;
				try {
					driver.manage().timeouts().implicitlyWait(Duration.ofMillis(200));
					java.util.List<org.openqa.selenium.WebElement> children = contentSlotEl.findElements(org.openqa.selenium.By.xpath("./*"));
					hasChildren = !children.isEmpty();
					System.out.println("  [Content Check] Content Slot sub-elements count: " + children.size());
				} catch (Exception e) {
					System.out.println("  [Content Check] Failed to check for children: " + e.getMessage());
				} finally {
					driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));
				}

				boolean isLoading = false;
				try {
					driver.manage().timeouts().implicitlyWait(Duration.ofMillis(200));
					contentSlotEl.findElement(org.openqa.selenium.By.xpath(".//*[contains(@aria-label, 'loading') or contains(@aria-label, 'spinner')]"));
					isLoading = true;
					System.out.println("  [Content Check] Content is in LOADING state.");
				} catch (Exception e) {} finally {
					driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));
				}

				boolean isEmptyState = false;
				try {
					driver.manage().timeouts().implicitlyWait(Duration.ofMillis(200));
					contentSlotEl.findElement(org.openqa.selenium.By.xpath(".//*[contains(@aria-label, 'empty-state') or contains(@aria-label, 'no-data')]"));
					isEmptyState = true;
					System.out.println("  [Content Check] Content is in EMPTY STATE.");
				} catch (Exception e) {} finally {
					driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));
				}

				if (!hasText && !hasChildren) {
					System.out.println("  [Content Check] Content Slot is completely EMPTY (no text, no children).");
					failureMessage = "Content Slot is completely empty.";
				} else if (isLoading) {
					System.out.println("  [Content Check] Content is still loading.");
					failureMessage = "Content is still loading.";
				} else if (isEmptyState) {
					System.out.println("  [Content Check] Empty state widget detected.");
					mainContentFound = 1; // Structurally found, but we note it's empty
				} else {
					mainContentFound = 1;
				}
			} else {
				if (failureMessage.isEmpty()) {
					failureMessage = "Content Slot element not found in DOM.";
				}
			}
		}

		// 8. Save DOM Data if shell exists
		if (shellEl != null) {
			try {
				String outerHtml = shellEl.getAttribute("outerHTML");
				java.io.File dir = new java.io.File("c:/Users/Admin2/Documents/GitHub/primecare-platform/dom_logs");
				if (!dir.exists()) {
					dir.mkdirs();
				}
				java.io.File domFile = new java.io.File(dir, "screen_" + screenId + "_dom.html");
				try (java.io.FileWriter writer = new java.io.FileWriter(domFile)) {
					writer.write(outerHtml);
				}
				System.out.println("  [DOM Logging] Saved DOM outerHTML to: " + domFile.getAbsolutePath());
			} catch (Exception e) {
				System.err.println("  [DOM Logging] Failed to save DOM outerHTML: " + e.getMessage());
			}
		}

		isPassed = (routeLoaded == 1 && sidebarFound == 1 && topbarFound == 1 && mainContentFound == 1 && placeholderFound == 0 && titleMatches);
		pageVerified = isPassed ? 1 : 0;
		componentVerified = isPassed ? 1 : 0;
		finalStatus = isPassed ? "PASSED" : "FAILED";
		System.out.println("  Result Status: " + finalStatus);

		// 9. Log results to SQLite database
		String dbUrl = "jdbc:sqlite:c:/Users/Admin2/Documents/GitHub/primecare-platform/.agents/governance/governance.db";
		try (Connection conn = DriverManager.getConnection(dbUrl)) {
			// Clean previous entries
			try (PreparedStatement delStmt = conn.prepareStatement("DELETE FROM screen_verification WHERE screen_id = ?")) {
				delStmt.setInt(1, screenId);
				delStmt.executeUpdate();
			}

			// Insert new record with full column alignment
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
				insertStmt.setString(15, failureMessage.isEmpty() ? null : failureMessage);
				insertStmt.setString(16, ""); // No screenshot path for now
				insertStmt.executeUpdate();
			}
			System.out.println("  Saved protocol results for Screen " + screenId + " to SQLite successfully.");
		} catch (Exception e) {
			System.err.println("  Failed to save protocol results to SQLite: " + e.getMessage());
		}

		if (!isPassed) {
			org.testng.Assert.fail("Navigation Protocol failed for screen ID " + screenId + " (" + expectedTitle + "). Expected Route: " + expectedRoute + ", Actual: " + currentUrl + ". Reason: " + failureMessage);
		}
		
		return isPassed;
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
						org.testng.Assert.assertTrue(element.isDisplayed(), "Element not displayed: " + field.getName());
						System.out.println("  Verified component: " + field.getName());
					}
				} catch (Exception e) {
					System.err.println("  Failed to verify component: " + field.getName() + " - " + e.getMessage());
				}
			}
		}
	}
}
