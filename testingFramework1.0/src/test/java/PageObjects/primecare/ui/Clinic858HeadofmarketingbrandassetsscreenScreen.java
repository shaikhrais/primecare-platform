package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic858HeadofmarketingbrandassetsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 858;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_brand_assets-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_brand_assets-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_brand_assets-content')]")
	private WebElement primaryContent;

    public Clinic858HeadofmarketingbrandassetsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic858HeadofmarketingbrandassetsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic858HeadofmarketingbrandassetsscreenScreen", "/generated/head-of-marketing-brand-assets");
    }
}

