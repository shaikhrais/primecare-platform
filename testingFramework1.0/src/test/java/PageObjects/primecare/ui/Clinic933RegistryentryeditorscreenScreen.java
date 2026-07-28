package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic933RegistryentryeditorscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 933;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'registry_entry_editor-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'registry_entry_editor-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'registry_entry_editor-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'registry_entry_editor_textfield_input_1')]")
	private WebElement registryEntryEditorTextfieldInput1;

    public Clinic933RegistryentryeditorscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic933RegistryentryeditorscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic933RegistryentryeditorscreenScreen", "/generated/registry-entry-editor");
    }
}

