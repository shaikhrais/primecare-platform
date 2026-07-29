package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1016VaccinationcampaignmanagerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1016;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vaccination_campaign_manager-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vaccination_campaign_manager-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vaccination_campaign_manager-content')]")
	private WebElement primaryContent;

    public Clinic1016VaccinationcampaignmanagerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1016VaccinationcampaignmanagerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1016VaccinationcampaignmanagerscreenScreen", "/generated/vaccination-campaign-manager");
    }
}

