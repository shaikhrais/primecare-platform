package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic953PopulationhealthanalyzerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 953;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'population_health_analyzer-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'population_health_analyzer-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'population_health_analyzer-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'population_health_analyzer_iconbutton_button_1')]")
	private WebElement populationHealthAnalyzerIconbuttonButton1;

    public Clinic953PopulationhealthanalyzerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic953PopulationhealthanalyzerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic953PopulationhealthanalyzerscreenScreen", "/generated/population-health-analyzer");
    }
}

