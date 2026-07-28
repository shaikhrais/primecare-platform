package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client391SchedulerprovideravailabilityscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 391;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_provider_availability-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_provider_availability-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_provider_availability-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerprovideravailability-btn-1')]")
	private WebElement schedulerprovideravailabilityBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerprovideravailability-btn-2')]")
	private WebElement schedulerprovideravailabilityBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerprovideravailability-btn-5')]")
	private WebElement schedulerprovideravailabilityBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerprovideravailability-btn-3')]")
	private WebElement schedulerprovideravailabilityBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerprovideravailability-screen')]")
	private WebElement schedulerprovideravailabilityScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerprovideravailability-content')]")
	private WebElement schedulerprovideravailabilityContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerprovideravailability-btn-4')]")
	private WebElement schedulerprovideravailabilityBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerprovideravailability-title')]")
	private WebElement schedulerprovideravailabilityTitle;

    public Client391SchedulerprovideravailabilityscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client391SchedulerprovideravailabilityscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client391SchedulerprovideravailabilityscreenScreen", "/staff/scheduler-provider-availability");
    }
}

