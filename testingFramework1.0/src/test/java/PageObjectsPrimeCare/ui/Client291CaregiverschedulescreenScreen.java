package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client291CaregiverschedulescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 291;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_schedule-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_schedule-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_schedule-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverschedule-btn-2')]")
	private WebElement caregiverscheduleBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverschedule-content')]")
	private WebElement caregiverscheduleContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverschedule-title')]")
	private WebElement caregiverscheduleTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverschedule-loading')]")
	private WebElement caregiverscheduleLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverschedule-btn-3')]")
	private WebElement caregiverscheduleBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverschedule-screen')]")
	private WebElement caregiverscheduleScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverschedule-btn-1')]")
	private WebElement caregiverscheduleBtn1;

    public Client291CaregiverschedulescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client291CaregiverschedulescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client291CaregiverschedulescreenScreen", "/offices/clinical/roles/caregiver/schedule");
    }
}
