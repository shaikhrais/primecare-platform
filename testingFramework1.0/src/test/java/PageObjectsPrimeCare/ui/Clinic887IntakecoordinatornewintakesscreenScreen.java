package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic887IntakecoordinatornewintakesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 887;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_new_intakes-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_new_intakes-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_new_intakes-content')]")
	private WebElement primaryContent;

    public Clinic887IntakecoordinatornewintakesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic887IntakecoordinatornewintakesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic887IntakecoordinatornewintakesscreenScreen", "/generated/intake-coordinator-new-intakes");
    }
}
