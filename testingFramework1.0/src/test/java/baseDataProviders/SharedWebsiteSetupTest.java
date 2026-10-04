package baseDataProviders;

import base.baseTest;
import java.lang.reflect.Proxy;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

/** Offline regressions: never launches a browser or accesses website records. */
public class SharedWebsiteSetupTest {
    private String originalUrl;
    private String originalFile;
    private WebDriver originalDriver;
    private Path workbookPath;
    private final List<String> calls = new ArrayList<>();

    @BeforeMethod
    public void prepare() throws Exception {
        originalUrl = System.getProperty("url");
        originalFile = ProjectExcelFileData.mainDataFile;
        originalDriver = baseTest.driver;
        workbookPath = Files.createTempFile("website-config-", ".xlsx");
        ProjectExcelFileData.mainDataFile = workbookPath.toString();
        System.clearProperty("url");
        calls.clear();
        writeUrl(null);
    }

    @AfterMethod(alwaysRun = true)
    public void restore() throws Exception {
        if (originalUrl == null) System.clearProperty("url");
        else System.setProperty("url", originalUrl);
        ProjectExcelFileData.mainDataFile = originalFile;
        baseTest.driver = originalDriver;
        Files.deleteIfExists(workbookPath);
    }

    private void writeUrl(String value) throws Exception {
        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            var sheet = workbook.createSheet("config");
            if (value != null) {
                var row = sheet.createRow(0);
                row.createCell(0).setCellValue("url");
                row.createCell(1).setCellValue(value);
            }
            try (var out = Files.newOutputStream(workbookPath)) { workbook.write(out); }
        }
    }

    private Object driverProxy(Class<?> type, boolean failQuit) {
        return Proxy.newProxyInstance(type.getClassLoader(), new Class<?>[]{type},
            (proxy, method, args) -> {
                calls.add(method.getName());
                if (failQuit && method.getName().equals("quit"))
                    throw new IllegalStateException("Simulated browser shutdown failure");
                Class<?> result = method.getReturnType();
                if (result.isInterface()) return driverProxy(result, failQuit);
                if (result == boolean.class) return false;
                if (result == int.class) return 0;
                return null;
            });
    }

    @Test
    public void vmUrlOverridesWorkbook() throws Exception {
        writeUrl("https://excel.example/login");
        System.setProperty("url", " https://vm.example/login ");
        Assert.assertEquals(ProjectExcelFileData.url(), "https://vm.example/login");
    }

    @Test
    public void workbookUrlIsPreserved() throws Exception {
        writeUrl("https://website.example/login?existing=value");
        Assert.assertEquals(ProjectExcelFileData.url(), "https://website.example/login?existing=value");
    }

    @Test
    public void blankVmUrlFallsBackToWorkbook() throws Exception {
        writeUrl("https://excel.example/login");
        System.setProperty("url", "  ");
        Assert.assertEquals(ProjectExcelFileData.url(), "https://excel.example/login");
    }

    @Test(expectedExceptions = IllegalStateException.class)
    public void missingUrlFailsInsteadOfOpeningPrimeCare() {
        ProjectExcelFileData.url();
    }

    @Test
    public void sharedSetupDoesNotNavigate() throws Exception {
        baseTest.driver = (WebDriver) driverProxy(WebDriver.class, false);
        new baseTest().setUp();
        Assert.assertFalse(calls.contains("get"), "Shared setup must not select a website");
        Assert.assertFalse(calls.contains("navigate"));
        Assert.assertTrue(calls.contains("pageLoadTimeout"));
    }

    @Test
    public void cleanupQuitsAndResetsDriver() {
        baseTest.driver = (WebDriver) driverProxy(WebDriver.class, false);
        new baseTest().tearDown();
        Assert.assertTrue(calls.contains("quit"));
        Assert.assertFalse(calls.contains("close"));
        Assert.assertNull(baseTest.driver);
        new baseTest().tearDown(); // Also safe when setup never created a driver.
    }

    @Test
    public void cleanupResetsDriverEvenWhenQuitFails() {
        baseTest.driver = (WebDriver) driverProxy(WebDriver.class, true);
        Assert.expectThrows(IllegalStateException.class, () -> new baseTest().tearDown());
        Assert.assertNull(baseTest.driver);
    }
}
