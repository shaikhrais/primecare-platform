package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic543ShifttasksscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 543;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shift_tasks-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shift_tasks-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shift_tasks-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shifttasks-btn-1')]")
	private WebElement shifttasksBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shifttasks-content')]")
	private WebElement shifttasksContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shifttasks-screen')]")
	private WebElement shifttasksScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shifttasks-title')]")
	private WebElement shifttasksTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shifttasks-loading')]")
	private WebElement shifttasksLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shifttasks-btn-3')]")
	private WebElement shifttasksBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shifttasks-btn-2')]")
	private WebElement shifttasksBtn2;

    public Clinic543ShifttasksscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic543ShifttasksscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic543ShifttasksscreenScreen", "/offices/clinical/roles/psw/shift-tasks");
    }
}

