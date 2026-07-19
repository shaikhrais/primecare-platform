package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic861HeadofmarketingfunnelanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 861;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_funnel_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_funnel_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_funnel_analytics-content')]")
	private WebElement primaryContent;

    public Clinic861HeadofmarketingfunnelanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic861HeadofmarketingfunnelanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic861HeadofmarketingfunnelanalyticsscreenScreen", "/generated/head-of-marketing-funnel-analytics");
    }
}
