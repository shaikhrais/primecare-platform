package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic853CommunityoutreachfollowupsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 853;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_follow_ups-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_follow_ups-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_follow_ups-content')]")
	private WebElement primaryContent;

    public Clinic853CommunityoutreachfollowupsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic853CommunityoutreachfollowupsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic853CommunityoutreachfollowupsscreenScreen", "/generated/community-outreach-follow-ups");
    }
}
