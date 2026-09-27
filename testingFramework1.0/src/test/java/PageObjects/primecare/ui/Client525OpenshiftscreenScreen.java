package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client525OpenshiftscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 525;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'open_shift-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'open_shift-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'open_shift-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'openshift-btn-5')]")
	private WebElement openshiftBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'openshift-loading')]")
	private WebElement openshiftLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'openshift-btn-4')]")
	private WebElement openshiftBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'openshift-content')]")
	private WebElement openshiftContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'openshift-btn-2')]")
	private WebElement openshiftBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'openshift-title')]")
	private WebElement openshiftTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'openshift-screen')]")
	private WebElement openshiftScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'openshift-btn-3')]")
	private WebElement openshiftBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'openshift-btn-1')]")
	private WebElement openshiftBtn1;

    public Client525OpenshiftscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client525OpenshiftscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client525OpenshiftscreenScreen", "/staff/open-shift");
    }
}

