package utilities;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;

import org.apache.commons.io.FileUtils;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.logging.LogEntries;
import org.openqa.selenium.logging.LogEntry;
import org.openqa.selenium.logging.LogType;
import org.testng.ITestContext;
import org.testng.ITestListener;
import org.testng.ITestResult;

import com.aventstack.extentreports.ExtentReports;
import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.Status;
import com.aventstack.extentreports.reporter.ExtentHtmlReporter;
import com.aventstack.extentreports.reporter.configuration.Theme;

import base.baseTest;

public class TestListener implements ITestListener {

	private static ExtentReports extent;
	private static ThreadLocal<ExtentTest> test = new ThreadLocal<>();

	@Override
	public void onStart(ITestContext context) {
		System.out.println("==============================================================");
		System.out.println("INITIALIZING PRIMECARE HIGH-FIDELITY TESTNG REPORTING SUITE");
		System.out.println("==============================================================");
		
		String repName = "PrimeCare_E2E_Report.html";
		String reportsDir = System.getProperty("user.dir") + "/reports/";
		
		// Ensure reports directory exists
		File dir = new File(reportsDir);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		
		ExtentHtmlReporter htmlReporter = new ExtentHtmlReporter(reportsDir + repName);
		htmlReporter.config().setDocumentTitle("PrimeCare Platform - QA E2E Execution Report");
		htmlReporter.config().setReportName("PrimeCare Platform E2E Automated Verification Suite");
		htmlReporter.config().setTheme(Theme.DARK);
		
		extent = new ExtentReports();
		extent.attachReporter(htmlReporter);
		extent.setSystemInfo("Host Name", "PrimeCare Platform");
		extent.setSystemInfo("Environment", "QA Production Blueprint Sandbox");
		extent.setSystemInfo("Automation Framework", "Selenium TestNG PageFactory POM");
		extent.setSystemInfo("OS", System.getProperty("os.name"));
		extent.setSystemInfo("Java Version", System.getProperty("java.version"));
	}

	@Override
	public void onTestStart(ITestResult result) {
		String testName = result.getMethod().getMethodName();
		String desc = result.getMethod().getDescription();
		System.out.println("[TEST STARTED] " + testName + (desc != null ? " - " + desc : ""));
		
		ExtentTest extentTest = extent.createTest(testName, desc);
		test.set(extentTest);
		test.get().log(Status.INFO, "Test Execution Started: " + testName);
	}

	@Override
	public void onTestSuccess(ITestResult result) {
		String testName = result.getMethod().getMethodName();
		System.out.println("[TEST PASSED] " + testName);
		
		test.get().log(Status.PASS, "Test Passed Cleanly: " + testName);
		
		// Capture final screenshot and browser logs on successful completion of test
		captureStepState(testName + "_Passed", Status.PASS);
	}

	@Override
	public void onTestFailure(ITestResult result) {
		String testName = result.getMethod().getMethodName();
		System.err.println("[TEST FAILED] " + testName);
		System.err.println("Exception: " + result.getThrowable().getMessage());
		
		test.get().log(Status.FAIL, "Test Failed: " + testName);
		test.get().log(Status.FAIL, result.getThrowable());
		
		// Capture state with screenshot and logs on failure
		captureStepState(testName + "_Failed", Status.FAIL);
	}

	@Override
	public void onTestSkipped(ITestResult result) {
		String testName = result.getMethod().getMethodName();
		System.out.println("[TEST SKIPPED] " + testName);
		test.get().log(Status.SKIP, "Test Skipped: " + testName);
	}

	@Override
	public void onFinish(ITestContext context) {
		System.out.println("==============================================================");
		System.out.println("FLUSHING EXTENT HTML REPORT TO DISK");
		System.out.println("==============================================================");
		if (extent != null) {
			extent.flush();
		}
		System.out.println("HTML execution report written successfully to ./reports/PrimeCare_E2E_Report.html");
	}

	private void captureStepState(String filename, Status logStatus) {
		WebDriver driver = baseTest.driver;
		if (driver == null) {
			test.get().log(Status.WARNING, "WebDriver is null, skipping screenshot and log extraction.");
			return;
		}

		// 1. Capture and save screenshot inside ./reports/ScreenShots/
		String dateName = new SimpleDateFormat("yyyyMMddhhmmss").format(new Date());
		String screenshotName = filename + "_" + dateName + ".png";
		String destPath = System.getProperty("user.dir") + "/reports/ScreenShots/" + screenshotName;
		
		try {
			File screenshotDir = new File(System.getProperty("user.dir") + "/reports/ScreenShots/");
			if (!screenshotDir.exists()) {
				screenshotDir.mkdirs();
			}
			
			TakesScreenshot ts = (TakesScreenshot) driver;
			File source = ts.getScreenshotAs(OutputType.FILE);
			FileUtils.copyFile(source, new File(destPath));
			
			// Attach screenshot to the HTML report using RELATIVE PATH from /reports/
			test.get().addScreenCaptureFromPath("ScreenShots/" + screenshotName);
			test.get().log(Status.INFO, "Captured UI State Screenshot.");
		} catch (IOException e) {
			test.get().log(Status.WARNING, "Failed to capture or save UI screenshot: " + e.getMessage());
		}

		// 2. Extract and format browser console logs
		try {
			LogEntries logEntries = driver.manage().logs().get(LogType.BROWSER);
			boolean hasConsoleLogs = false;
			
			for (LogEntry entry : logEntries) {
				if (!hasConsoleLogs) {
					test.get().log(Status.INFO, "<b>--- Browser Console Logs ---</b>");
					hasConsoleLogs = true;
				}
				
				// Highlight errors in red inside HTML report
				if (entry.getLevel() == Level.SEVERE) {
					test.get().log(Status.INFO, "<span style='color: #ef4444; font-family: monospace;'>[ERR] " + entry.getMessage() + "</span>");
				} else if (entry.getLevel() == Level.WARNING) {
					test.get().log(Status.INFO, "<span style='color: #f59e0b; font-family: monospace;'>[WARN] " + entry.getMessage() + "</span>");
				} else {
					test.get().log(Status.INFO, "<span style='color: #94a3b8; font-family: monospace;'>[INFO] " + entry.getMessage() + "</span>");
				}
			}
		} catch (Exception e) {
			test.get().log(Status.INFO, "Console log extraction not supported or enabled for this browser type.");
		}
	}
}
