package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic372RnmedicationsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 372;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_medications-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_medications-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_medications-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnmedications-title')]")
	private WebElement rnmedicationsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnmedications-loading')]")
	private WebElement rnmedicationsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnmedications-btn-3')]")
	private WebElement rnmedicationsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnmedications-btn-1')]")
	private WebElement rnmedicationsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnmedications-btn-2')]")
	private WebElement rnmedicationsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnmedications-content')]")
	private WebElement rnmedicationsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnmedications-screen')]")
	private WebElement rnmedicationsScreen;

    public Clinic372RnmedicationsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic372RnmedicationsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic372RnmedicationsscreenScreen", "/offices/clinical/roles/rn/medications");
    }
}

