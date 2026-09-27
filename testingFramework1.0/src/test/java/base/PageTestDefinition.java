package base;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.openqa.selenium.By;

public class PageTestDefinition {

    private final int screenId;
    private final String pageName;
    private final String route;
    private final String expectedTitle;
    private final By pageMarker;
    private final By mainContentMarker;
    private final List<ComponentDefinition> components;

    public PageTestDefinition(
            int screenId,
            String pageName,
            String route,
            String expectedTitle,
            By pageMarker,
            By mainContentMarker,
            List<ComponentDefinition> components
    ) {
        this.screenId = screenId;
        this.pageName = pageName;
        this.route = route;
        this.expectedTitle = expectedTitle;
        this.pageMarker = pageMarker;
        this.mainContentMarker = mainContentMarker;

        this.components = components == null
                ? new ArrayList<>()
                : new ArrayList<>(components);
    }

    public int getScreenId() {
        return screenId;
    }

    public String getPageName() {
        return pageName;
    }

    public String getRoute() {
        return route;
    }

    public String getExpectedTitle() {
        return expectedTitle;
    }

    public By getPageMarker() {
        return pageMarker;
    }

    public By getMainContentMarker() {
        return mainContentMarker;
    }

    public List<ComponentDefinition> getComponents() {
        return Collections.unmodifiableList(components);
    }
}
