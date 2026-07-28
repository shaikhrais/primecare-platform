package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic852CommunityoutreacheventsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 852;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_events-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_events-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_events-content')]")
	private WebElement primaryContent;

    public Clinic852CommunityoutreacheventsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic852CommunityoutreacheventsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic852CommunityoutreacheventsscreenScreen", "/generated/community-outreach-events");
    }
}

