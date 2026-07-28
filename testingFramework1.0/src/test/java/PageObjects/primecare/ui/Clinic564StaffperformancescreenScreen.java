package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic564StaffperformancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 564;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staff_performance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staff_performance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staff_performance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffperformance-title')]")
	private WebElement staffperformanceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffperformance-loading')]")
	private WebElement staffperformanceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffperformance-btn-3')]")
	private WebElement staffperformanceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffperformance-screen')]")
	private WebElement staffperformanceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffperformance-content')]")
	private WebElement staffperformanceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffperformance-btn-1')]")
	private WebElement staffperformanceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffperformance-btn-2')]")
	private WebElement staffperformanceBtn2;

    public Clinic564StaffperformancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic564StaffperformancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic564StaffperformancescreenScreen", "/offices/clinical/roles/clinical_director/staff-performance");
    }
}

