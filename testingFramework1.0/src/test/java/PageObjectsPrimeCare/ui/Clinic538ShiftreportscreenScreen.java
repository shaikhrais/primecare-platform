package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic538ShiftreportscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 538;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shift_report-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shift_report-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shift_report-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shiftreport-title')]")
	private WebElement shiftreportTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shiftreport-btn-1')]")
	private WebElement shiftreportBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shiftreport-btn-2')]")
	private WebElement shiftreportBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shiftreport-content')]")
	private WebElement shiftreportContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shiftreport-btn-3')]")
	private WebElement shiftreportBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shiftreport-loading')]")
	private WebElement shiftreportLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shiftreport-screen')]")
	private WebElement shiftreportScreen;

    public Clinic538ShiftreportscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic538ShiftreportscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic538ShiftreportscreenScreen", "/offices/clinical/roles/rn/shift-report");
    }
}
