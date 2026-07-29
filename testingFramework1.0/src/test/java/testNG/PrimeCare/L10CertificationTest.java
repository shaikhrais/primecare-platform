package testNG.PrimeCare;

import primecare.testing.base.BaseTest;
import primecare.testing.framework.Models.CertificationRecord;
import primecare.testing.framework.Models.ScreenDefinition;
import primecare.testing.models.TestingLayerCode;
import primecare.testing.framework.Repositories.ScreenRepository;
import primecare.testing.framework.CertificationService;
import primecare.testing.validation.TestLayer;
import org.testng.Assert;
import org.testng.annotations.DataProvider;
import java.util.List;
import org.testng.annotations.Test;

@TestLayer(TestingLayerCode.L10)
public class L10CertificationTest extends BaseTest {

    @DataProvider(name = "screens")
    public Object[][] getScreens() {
        List<ScreenDefinition> list = ScreenRepository.getScreens();
        Object[][] data = new Object[list.size()][1];
        for (int i = 0; i < list.size(); i++) {
            data[i][0] = list.get(i);
        }
        return data;
    }

    @Test(dataProvider = "screens", groups = {"l10"})
    public void runL10CertificationAudit(ScreenDefinition screen) {
        System.out.println("[L10] Running governance certification audit for screen: " + screen.screenKey);
        
        CertificationRecord record = CertificationService.certifyScreen(1, screen.screenId, executionId);
        
        Assert.assertNotNull(record, "Certification record failed to compile.");
        Assert.assertNotNull(record.certificationStatus, "Certification status is null.");
        System.out.println("[L10] Certification Audit completed for screen: " + screen.screenKey + ". Status: " + record.certificationStatus);
    }
}

