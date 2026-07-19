package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate319CoobranchcomparisonscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 319;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_branch_comparison-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_branch_comparison-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_branch_comparison-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coobranchcomparison-screen')]")
	private WebElement coobranchcomparisonScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coobranchcomparison-btn-3')]")
	private WebElement coobranchcomparisonBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coobranchcomparison-content')]")
	private WebElement coobranchcomparisonContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coobranchcomparison-btn-2')]")
	private WebElement coobranchcomparisonBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coobranchcomparison-title')]")
	private WebElement coobranchcomparisonTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coobranchcomparison-btn-1')]")
	private WebElement coobranchcomparisonBtn1;

    public Corporate319CoobranchcomparisonscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate319CoobranchcomparisonscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate319CoobranchcomparisonscreenScreen", "/offices/corporate/roles/coo/branch-comparison");
    }
}
