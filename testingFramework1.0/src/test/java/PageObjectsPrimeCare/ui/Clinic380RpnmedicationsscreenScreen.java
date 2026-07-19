package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic380RpnmedicationsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 380;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_medications-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_medications-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_medications-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnmedications-btn-1')]")
	private WebElement rpnmedicationsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnmedications-screen')]")
	private WebElement rpnmedicationsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnmedications-loading')]")
	private WebElement rpnmedicationsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnmedications-btn-3')]")
	private WebElement rpnmedicationsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnmedications-btn-2')]")
	private WebElement rpnmedicationsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnmedications-content')]")
	private WebElement rpnmedicationsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnmedications-title')]")
	private WebElement rpnmedicationsTitle;

    public Clinic380RpnmedicationsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic380RpnmedicationsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic380RpnmedicationsscreenScreen", "/offices/clinical/roles/rpn/medications");
    }
}
