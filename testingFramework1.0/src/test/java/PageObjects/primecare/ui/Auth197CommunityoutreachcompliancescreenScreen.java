package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth197CommunityoutreachcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 197;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachcompliance-content')]")
	private WebElement communityoutreachcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachcompliance-title')]")
	private WebElement communityoutreachcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachcompliance-btn-2')]")
	private WebElement communityoutreachcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachcompliance-screen')]")
	private WebElement communityoutreachcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachcompliance-btn-1')]")
	private WebElement communityoutreachcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachcompliance-btn-3')]")
	private WebElement communityoutreachcomplianceBtn3;

    public Auth197CommunityoutreachcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth197CommunityoutreachcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth197CommunityoutreachcompliancescreenScreen", "/management/community-outreach-compliance");
    }
}

