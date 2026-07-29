package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic739TrainingcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 739;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcompliancescreen-screen')]")
	private WebElement trainingcompliancescreenScreen;

    public Clinic739TrainingcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic739TrainingcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic739TrainingcompliancescreenScreen", "/offices/corporate/roles/compliance_manager/training-compliance");
    }
}

