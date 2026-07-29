package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic718CeogrowthpipelinescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 718;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_growth_pipeline-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_growth_pipeline-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_growth_pipeline-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceogrowthpipelinescreen-screen')]")
	private WebElement ceogrowthpipelinescreenScreen;

    public Clinic718CeogrowthpipelinescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic718CeogrowthpipelinescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic718CeogrowthpipelinescreenScreen", "/offices/corporate/roles/ceo/growth-pipeline");
    }
}

