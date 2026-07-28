package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client288CaregivertasksscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 288;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_tasks-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_tasks-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_tasks-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregivertasks-btn-3')]")
	private WebElement caregivertasksBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregivertasks-screen')]")
	private WebElement caregivertasksScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregivertasks-btn-2')]")
	private WebElement caregivertasksBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregivertasks-title')]")
	private WebElement caregivertasksTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregivertasks-loading')]")
	private WebElement caregivertasksLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregivertasks-btn-1')]")
	private WebElement caregivertasksBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregivertasks-content')]")
	private WebElement caregivertasksContent;

    public Client288CaregivertasksscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client288CaregivertasksscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client288CaregivertasksscreenScreen", "/offices/clinical/roles/caregiver/tasks");
    }
}

