package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic857CommunityoutreachvolunteersscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 857;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_volunteers-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_volunteers-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_volunteers-content')]")
	private WebElement primaryContent;

    public Clinic857CommunityoutreachvolunteersscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic857CommunityoutreachvolunteersscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic857CommunityoutreachvolunteersscreenScreen", "/generated/community-outreach-volunteers");
    }
}

