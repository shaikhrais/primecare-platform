package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic864HeadofmarketingregionalcampaignsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 864;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_regional_campaigns-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_regional_campaigns-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_regional_campaigns-content')]")
	private WebElement primaryContent;

    public Clinic864HeadofmarketingregionalcampaignsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic864HeadofmarketingregionalcampaignsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic864HeadofmarketingregionalcampaignsscreenScreen", "/generated/head-of-marketing-regional-campaigns");
    }
}

