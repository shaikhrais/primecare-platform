package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic855CommunityoutreachprogramsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 855;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_programs-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_programs-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_programs-content')]")
	private WebElement primaryContent;

    public Clinic855CommunityoutreachprogramsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic855CommunityoutreachprogramsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic855CommunityoutreachprogramsscreenScreen", "/generated/community-outreach-programs");
    }
}

