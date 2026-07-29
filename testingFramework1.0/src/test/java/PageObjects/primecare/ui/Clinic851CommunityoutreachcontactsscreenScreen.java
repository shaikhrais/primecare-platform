package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic851CommunityoutreachcontactsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 851;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_contacts-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_contacts-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_contacts-content')]")
	private WebElement primaryContent;

    public Clinic851CommunityoutreachcontactsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic851CommunityoutreachcontactsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic851CommunityoutreachcontactsscreenScreen", "/generated/community-outreach-contacts");
    }
}

