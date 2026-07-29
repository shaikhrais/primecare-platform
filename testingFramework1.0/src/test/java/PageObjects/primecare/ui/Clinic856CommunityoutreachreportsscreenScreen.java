package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic856CommunityoutreachreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 856;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_reports-content')]")
	private WebElement primaryContent;

    public Clinic856CommunityoutreachreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic856CommunityoutreachreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic856CommunityoutreachreportsscreenScreen", "/generated/community-outreach-reports");
    }
}

