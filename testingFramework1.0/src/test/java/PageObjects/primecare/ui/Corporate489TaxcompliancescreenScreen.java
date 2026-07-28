package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate489TaxcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 489;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'tax_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'tax_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'tax_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'taxcompliance-title')]")
	private WebElement taxcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'taxcompliance-btn-1')]")
	private WebElement taxcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'taxcompliance-screen')]")
	private WebElement taxcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'taxcompliance-btn-3')]")
	private WebElement taxcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'taxcompliance-loading')]")
	private WebElement taxcomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'taxcompliance-content')]")
	private WebElement taxcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'taxcompliance-btn-2')]")
	private WebElement taxcomplianceBtn2;

    public Corporate489TaxcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate489TaxcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate489TaxcompliancescreenScreen", "/executive/tax-compliance");
    }
}

