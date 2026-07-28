package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class BusinessDevelopment508OutreachcampaignscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 508;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'outreach_campaign-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'outreach_campaign-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'outreach_campaign-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'outreachcampaign-btn-3')]")
	private WebElement outreachcampaignBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'outreachcampaign-btn-1')]")
	private WebElement outreachcampaignBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'outreachcampaign-title')]")
	private WebElement outreachcampaignTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'outreachcampaign-content')]")
	private WebElement outreachcampaignContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'outreachcampaign-screen')]")
	private WebElement outreachcampaignScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'outreachcampaign-btn-2')]")
	private WebElement outreachcampaignBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'outreachcampaign-loading')]")
	private WebElement outreachcampaignLoading;

    public BusinessDevelopment508OutreachcampaignscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public BusinessDevelopment508OutreachcampaignscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "BusinessDevelopment508OutreachcampaignscreenScreen", "/management/outreach-campaign");
    }
}

