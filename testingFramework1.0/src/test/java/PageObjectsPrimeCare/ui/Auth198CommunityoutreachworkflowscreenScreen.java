package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth198CommunityoutreachworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 198;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachworkflow-btn-3')]")
	private WebElement communityoutreachworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachworkflow-btn-1')]")
	private WebElement communityoutreachworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachworkflow-title')]")
	private WebElement communityoutreachworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachworkflow-loading')]")
	private WebElement communityoutreachworkflowLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachworkflow-screen')]")
	private WebElement communityoutreachworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachworkflow-btn-2')]")
	private WebElement communityoutreachworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachworkflow-content')]")
	private WebElement communityoutreachworkflowContent;

    public Auth198CommunityoutreachworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth198CommunityoutreachworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth198CommunityoutreachworkflowscreenScreen", "/management/community-outreach-workflow");
    }
}
