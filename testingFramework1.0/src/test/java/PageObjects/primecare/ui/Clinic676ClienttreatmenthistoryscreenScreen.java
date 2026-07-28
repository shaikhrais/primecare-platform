package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic676ClienttreatmenthistoryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 676;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_treatment_history-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_treatment_history-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_treatment_history-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clienttreatmenthistoryscreen-screen')]")
	private WebElement clienttreatmenthistoryscreenScreen;

    public Clinic676ClienttreatmenthistoryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic676ClienttreatmenthistoryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic676ClienttreatmenthistoryscreenScreen", "/generated/client-treatment-history");
    }
}

