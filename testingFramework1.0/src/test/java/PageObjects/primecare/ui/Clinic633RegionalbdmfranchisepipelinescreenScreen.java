package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic633RegionalbdmfranchisepipelinescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 633;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_franchise_pipeline-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_franchise_pipeline-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_franchise_pipeline-content')]")
	private WebElement primaryContent;

    public Clinic633RegionalbdmfranchisepipelinescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic633RegionalbdmfranchisepipelinescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic633RegionalbdmfranchisepipelinescreenScreen", "/offices/business_development/roles/regional_bdm/franchise-pipeline");
    }
}

