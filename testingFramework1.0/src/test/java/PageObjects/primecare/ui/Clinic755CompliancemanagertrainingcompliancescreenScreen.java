package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic755CompliancemanagertrainingcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 755;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_training_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_training_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_training_compliance-content')]")
	private WebElement primaryContent;

    public Clinic755CompliancemanagertrainingcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic755CompliancemanagertrainingcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic755CompliancemanagertrainingcompliancescreenScreen", "/generated/compliance-manager-training-compliance");
    }
}

