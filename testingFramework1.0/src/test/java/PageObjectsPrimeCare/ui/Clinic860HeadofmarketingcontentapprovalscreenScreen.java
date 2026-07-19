package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic860HeadofmarketingcontentapprovalscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 860;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_content_approval-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_content_approval-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_content_approval-content')]")
	private WebElement primaryContent;

    public Clinic860HeadofmarketingcontentapprovalscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic860HeadofmarketingcontentapprovalscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic860HeadofmarketingcontentapprovalscreenScreen", "/generated/head-of-marketing-content-approval");
    }
}
