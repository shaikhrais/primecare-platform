package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic540VitalstrackingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 540;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitals_tracking-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitals_tracking-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitals_tracking-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitalstracking-content')]")
	private WebElement vitalstrackingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitalstracking-btn-1')]")
	private WebElement vitalstrackingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitalstracking-loading')]")
	private WebElement vitalstrackingLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitalstracking-screen')]")
	private WebElement vitalstrackingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitalstracking-btn-3')]")
	private WebElement vitalstrackingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitalstracking-title')]")
	private WebElement vitalstrackingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitalstracking-btn-2')]")
	private WebElement vitalstrackingBtn2;

    public Clinic540VitalstrackingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic540VitalstrackingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic540VitalstrackingscreenScreen", "/offices/clinical/roles/rpn/vitals-tracking");
    }
}
