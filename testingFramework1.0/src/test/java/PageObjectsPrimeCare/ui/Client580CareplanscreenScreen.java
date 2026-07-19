package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client580CareplanscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 580;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'care_plan-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'care_plan-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'care_plan-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careplan-btn-2')]")
	private WebElement careplanBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careplan-btn-3')]")
	private WebElement careplanBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careplan-screen')]")
	private WebElement careplanScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careplan-loading')]")
	private WebElement careplanLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careplan-title')]")
	private WebElement careplanTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careplan-btn-1')]")
	private WebElement careplanBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careplan-content')]")
	private WebElement careplanContent;

    public Client580CareplanscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client580CareplanscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client580CareplanscreenScreen", "/clinic/care-plan");
    }
}
