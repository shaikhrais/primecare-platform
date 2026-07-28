package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate488PayrollscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 488;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'payroll-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'payroll-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'payroll-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'payroll-btn-1')]")
	private WebElement payrollBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'payroll-loading')]")
	private WebElement payrollLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'payroll-btn-2')]")
	private WebElement payrollBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'payroll-btn-3')]")
	private WebElement payrollBtn3;

    public Corporate488PayrollscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate488PayrollscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate488PayrollscreenScreen", "/executive/payroll");
    }
}

