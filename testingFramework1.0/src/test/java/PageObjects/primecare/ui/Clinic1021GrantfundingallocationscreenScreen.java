package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1021GrantfundingallocationscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1021;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'grant_funding_allocation-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'grant_funding_allocation-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'grant_funding_allocation-content')]")
	private WebElement primaryContent;

    public Clinic1021GrantfundingallocationscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1021GrantfundingallocationscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1021GrantfundingallocationscreenScreen", "/generated/grant-funding-allocation");
    }
}

