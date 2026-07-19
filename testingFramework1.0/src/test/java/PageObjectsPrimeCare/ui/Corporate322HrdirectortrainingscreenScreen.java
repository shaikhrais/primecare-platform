package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate322HrdirectortrainingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 322;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_training-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_training-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_training-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectortraining-title')]")
	private WebElement hrdirectortrainingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectortraining-btn-1')]")
	private WebElement hrdirectortrainingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectortraining-screen')]")
	private WebElement hrdirectortrainingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectortraining-btn-3')]")
	private WebElement hrdirectortrainingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectortraining-content')]")
	private WebElement hrdirectortrainingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectortraining-btn-2')]")
	private WebElement hrdirectortrainingBtn2;

    public Corporate322HrdirectortrainingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate322HrdirectortrainingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate322HrdirectortrainingscreenScreen", "/executive/hr-director-training");
    }
}
