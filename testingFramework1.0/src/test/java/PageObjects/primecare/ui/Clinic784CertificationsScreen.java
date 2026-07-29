package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic784CertificationsScreen extends baseTest {
 
    public static final int SCREEN_ID = 784;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certifications-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certifications-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certifications-content')]")
	private WebElement primaryContent;

    public Clinic784CertificationsScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic784CertificationsScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic784CertificationsScreen", "/generated/certifications");
    }
}

