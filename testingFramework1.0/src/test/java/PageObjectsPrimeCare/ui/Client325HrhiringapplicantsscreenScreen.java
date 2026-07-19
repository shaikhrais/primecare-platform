package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client325HrhiringapplicantsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 325;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_applicants-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_applicants-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_applicants-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringapplicants-content')]")
	private WebElement hrhiringapplicantsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringapplicants-btn-1')]")
	private WebElement hrhiringapplicantsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringapplicants-btn-4')]")
	private WebElement hrhiringapplicantsBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringapplicants-title')]")
	private WebElement hrhiringapplicantsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringapplicants-btn-3')]")
	private WebElement hrhiringapplicantsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringapplicants-btn-5')]")
	private WebElement hrhiringapplicantsBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringapplicants-screen')]")
	private WebElement hrhiringapplicantsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringapplicants-btn-2')]")
	private WebElement hrhiringapplicantsBtn2;

    public Client325HrhiringapplicantsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client325HrhiringapplicantsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client325HrhiringapplicantsscreenScreen", "/offices/franchise/roles/hr_hiring/applicants");
    }
}
