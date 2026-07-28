package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic847ClinicalreferencescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 847;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_reference-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_reference-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_reference-content')]")
	private WebElement primaryContent;

    public Clinic847ClinicalreferencescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic847ClinicalreferencescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic847ClinicalreferencescreenScreen", "/governance/clinical-reference");
    }
}

