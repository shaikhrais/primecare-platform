package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic854CommunityoutreachpartnershipsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 854;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_partnerships-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_partnerships-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_partnerships-content')]")
	private WebElement primaryContent;

    public Clinic854CommunityoutreachpartnershipsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic854CommunityoutreachpartnershipsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic854CommunityoutreachpartnershipsscreenScreen", "/generated/community-outreach-partnerships");
    }
}
