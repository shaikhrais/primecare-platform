package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic891QualityassurancecomplaintsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 891;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_complaints-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_complaints-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_complaints-content')]")
	private WebElement primaryContent;

    public Clinic891QualityassurancecomplaintsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic891QualityassurancecomplaintsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic891QualityassurancecomplaintsscreenScreen", "/generated/quality-assurance-complaints");
    }
}

