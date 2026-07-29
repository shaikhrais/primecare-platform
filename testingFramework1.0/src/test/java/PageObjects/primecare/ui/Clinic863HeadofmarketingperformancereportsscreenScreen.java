package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic863HeadofmarketingperformancereportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 863;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_performance_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_performance_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_performance_reports-content')]")
	private WebElement primaryContent;

    public Clinic863HeadofmarketingperformancereportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic863HeadofmarketingperformancereportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic863HeadofmarketingperformancereportsscreenScreen", "/generated/head-of-marketing-performance-reports");
    }
}

