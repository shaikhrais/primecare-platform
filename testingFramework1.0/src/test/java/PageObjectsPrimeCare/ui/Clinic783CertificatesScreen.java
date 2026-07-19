package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic783CertificatesScreen extends baseTest {
 
    public static final int SCREEN_ID = 783;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certificates-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certificates-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certificates-content')]")
	private WebElement primaryContent;

    public Clinic783CertificatesScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic783CertificatesScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic783CertificatesScreen", "/generated/certificates");
    }
}
