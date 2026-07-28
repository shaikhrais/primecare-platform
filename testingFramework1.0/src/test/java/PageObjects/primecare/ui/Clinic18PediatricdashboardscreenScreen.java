package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic18PediatricdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 18;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatricdashboard-btn-1')]")
	private WebElement pediatricdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatricdashboard-btn-4')]")
	private WebElement pediatricdashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatricdashboard-btn-2')]")
	private WebElement pediatricdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatricdashboard-btn-3')]")
	private WebElement pediatricdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatricdashboard-screen')]")
	private WebElement pediatricdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatricdashboard-content')]")
	private WebElement pediatricdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatricdashboard-title')]")
	private WebElement pediatricdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatricdashboard-btn-5')]")
	private WebElement pediatricdashboardBtn5;

    public Clinic18PediatricdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic18PediatricdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic18PediatricdashboardscreenScreen", "/clinical/pediatric-dashboard");
    }
}

