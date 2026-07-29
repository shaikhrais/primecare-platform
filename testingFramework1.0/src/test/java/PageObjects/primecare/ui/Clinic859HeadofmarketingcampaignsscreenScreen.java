package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic859HeadofmarketingcampaignsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 859;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_campaigns-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_campaigns-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_campaigns-content')]")
	private WebElement primaryContent;

    public Clinic859HeadofmarketingcampaignsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic859HeadofmarketingcampaignsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic859HeadofmarketingcampaignsscreenScreen", "/generated/head-of-marketing-campaigns");
    }
}

