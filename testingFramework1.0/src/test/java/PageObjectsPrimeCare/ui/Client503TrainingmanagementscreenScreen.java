package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client503TrainingmanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 503;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingmanagement-btn-1')]")
	private WebElement trainingmanagementBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingmanagement-title')]")
	private WebElement trainingmanagementTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingmanagement-screen')]")
	private WebElement trainingmanagementScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingmanagement-content')]")
	private WebElement trainingmanagementContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingmanagement-btn-2')]")
	private WebElement trainingmanagementBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingmanagement-btn-3')]")
	private WebElement trainingmanagementBtn3;

    public Client503TrainingmanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client503TrainingmanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client503TrainingmanagementscreenScreen", "/management/training-management");
    }
}
