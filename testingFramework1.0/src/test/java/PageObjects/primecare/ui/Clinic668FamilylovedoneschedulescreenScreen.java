package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic668FamilylovedoneschedulescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 668;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_loved_one_schedule-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_loved_one_schedule-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_loved_one_schedule-content')]")
	private WebElement primaryContent;

    public Clinic668FamilylovedoneschedulescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic668FamilylovedoneschedulescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic668FamilylovedoneschedulescreenScreen", "/offices/client/roles/family_member/loved-one-schedule");
    }
}

