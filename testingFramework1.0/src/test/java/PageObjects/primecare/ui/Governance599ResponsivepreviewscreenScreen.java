package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance599ResponsivepreviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 599;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'responsive_preview-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'responsive_preview-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'responsive_preview-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'responsivepreview-btn-2')]")
	private WebElement responsivepreviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'responsivepreview-title')]")
	private WebElement responsivepreviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'responsivepreview-loading')]")
	private WebElement responsivepreviewLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'responsivepreview-screen')]")
	private WebElement responsivepreviewScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'responsivepreview-btn-3')]")
	private WebElement responsivepreviewBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'responsivepreview-btn-1')]")
	private WebElement responsivepreviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'responsivepreview-content')]")
	private WebElement responsivepreviewContent;

    public Governance599ResponsivepreviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance599ResponsivepreviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance599ResponsivepreviewscreenScreen", "/common/responsive-preview");
    }
}

