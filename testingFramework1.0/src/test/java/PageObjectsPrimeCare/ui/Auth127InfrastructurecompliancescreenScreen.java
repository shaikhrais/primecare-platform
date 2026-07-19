package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth127InfrastructurecompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 127;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructure_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructure_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructure_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructurecompliance-btn-2')]")
	private WebElement infrastructurecomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructurecompliance-btn-1')]")
	private WebElement infrastructurecomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructurecompliance-title')]")
	private WebElement infrastructurecomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructurecompliance-content')]")
	private WebElement infrastructurecomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructurecompliance-screen')]")
	private WebElement infrastructurecomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructurecompliance-btn-3')]")
	private WebElement infrastructurecomplianceBtn3;

    public Auth127InfrastructurecompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth127InfrastructurecompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth127InfrastructurecompliancescreenScreen", "/common/infrastructure-compliance");
    }
}
