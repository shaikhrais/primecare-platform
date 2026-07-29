package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1000DruginteractionalertcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1000;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'drug_interaction_alert_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'drug_interaction_alert_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'drug_interaction_alert_center-content')]")
	private WebElement primaryContent;

    public Clinic1000DruginteractionalertcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1000DruginteractionalertcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1000DruginteractionalertcenterscreenScreen", "/generated/drug-interaction-alert-center");
    }
}

