package base;

import org.openqa.selenium.By;

public class ComponentDefinition {

    private final String componentName;
    private final String componentType;
    private final By locator;

    private final boolean required;
    private final boolean mustBeVisible;
    private final boolean mustBeEnabled;
    private final boolean mustBeClickable;

    public ComponentDefinition(
            String componentName,
            String componentType,
            By locator,
            boolean required,
            boolean mustBeVisible,
            boolean mustBeEnabled,
            boolean mustBeClickable
    ) {
        this.componentName = componentName;
        this.componentType = componentType;
        this.locator = locator;
        this.required = required;
        this.mustBeVisible = mustBeVisible;
        this.mustBeEnabled = mustBeEnabled;
        this.mustBeClickable = mustBeClickable;
    }

    public String getComponentName() {
        return componentName;
    }

    public String getComponentType() {
        return componentType;
    }

    public By getLocator() {
        return locator;
    }

    public boolean isRequired() {
        return required;
    }

    public boolean isMustBeVisible() {
        return mustBeVisible;
    }

    public boolean isMustBeEnabled() {
        return mustBeEnabled;
    }

    public boolean isMustBeClickable() {
        return mustBeClickable;
    }
}
