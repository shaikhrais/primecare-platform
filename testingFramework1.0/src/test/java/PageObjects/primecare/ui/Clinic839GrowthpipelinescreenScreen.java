package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic839GrowthpipelinescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 839;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'growth_pipeline-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'growth_pipeline-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'growth_pipeline-content')]")
	private WebElement primaryContent;

    public Clinic839GrowthpipelinescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic839GrowthpipelinescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic839GrowthpipelinescreenScreen", "/generated/offices/corporate/roles/ceo/growth-pipeline");
    }
}

