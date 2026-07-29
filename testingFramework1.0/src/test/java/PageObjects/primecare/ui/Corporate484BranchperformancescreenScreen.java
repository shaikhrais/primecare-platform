package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate484BranchperformancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 484;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'branch_performance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'branch_performance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'branch_performance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'branchperformance-content')]")
	private WebElement branchperformanceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'branchperformance-btn-3')]")
	private WebElement branchperformanceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'branchperformance-loading')]")
	private WebElement branchperformanceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'branchperformance-btn-1')]")
	private WebElement branchperformanceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'branchperformance-screen')]")
	private WebElement branchperformanceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'branchperformance-btn-2')]")
	private WebElement branchperformanceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'branchperformance-title')]")
	private WebElement branchperformanceTitle;

    public Corporate484BranchperformancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate484BranchperformancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate484BranchperformancescreenScreen", "/executive/branch-performance");
    }
}

