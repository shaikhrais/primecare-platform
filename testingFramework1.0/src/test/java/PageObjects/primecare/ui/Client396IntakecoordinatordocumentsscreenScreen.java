package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client396IntakecoordinatordocumentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 396;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_documents-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_documents-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_documents-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatordocuments-btn-1')]")
	private WebElement intakecoordinatordocumentsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatordocuments-btn-2')]")
	private WebElement intakecoordinatordocumentsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatordocuments-btn-3')]")
	private WebElement intakecoordinatordocumentsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatordocuments-title')]")
	private WebElement intakecoordinatordocumentsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatordocuments-content')]")
	private WebElement intakecoordinatordocumentsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatordocuments-screen')]")
	private WebElement intakecoordinatordocumentsScreen;

    public Client396IntakecoordinatordocumentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client396IntakecoordinatordocumentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client396IntakecoordinatordocumentsscreenScreen", "/executive/intake-coordinator-documents");
    }
}

