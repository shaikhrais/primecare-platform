package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client574StaffprogressscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 574;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staff_progress-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staff_progress-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staff_progress-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffprogress-btn-1')]")
	private WebElement staffprogressBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffprogress-btn-2')]")
	private WebElement staffprogressBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffprogress-title')]")
	private WebElement staffprogressTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffprogress-btn-5')]")
	private WebElement staffprogressBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffprogress-btn-3')]")
	private WebElement staffprogressBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffprogress-btn-4')]")
	private WebElement staffprogressBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffprogress-screen')]")
	private WebElement staffprogressScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffprogress-loading')]")
	private WebElement staffprogressLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffprogress-content')]")
	private WebElement staffprogressContent;

    public Client574StaffprogressscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client574StaffprogressscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client574StaffprogressscreenScreen", "/staff/staff-progress");
    }
}

