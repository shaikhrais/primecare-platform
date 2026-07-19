package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1017VulnerablepopulationregistryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1017;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vulnerable_population_registry-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vulnerable_population_registry-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vulnerable_population_registry-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'registry-search')]")
	private WebElement registrySearch;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'registry-btn-report')]")
	private WebElement registryBtnReport;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'registry-btn-add')]")
	private WebElement registryBtnAdd;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'registry-age-field')]")
	private WebElement registryAgeField;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'registry-risk-field')]")
	private WebElement registryRiskField;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'registry-name-field')]")
	private WebElement registryNameField;

    public Clinic1017VulnerablepopulationregistryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1017VulnerablepopulationregistryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1017VulnerablepopulationregistryscreenScreen", "/generated/vulnerable-population-registry");
    }
}
