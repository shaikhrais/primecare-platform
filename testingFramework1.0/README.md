# 📖 How to Use Master Java Test Runner (Eclipse / TestNG)

This Java TestNG framework enables automated end-to-end user journey verification across all **947 active screens** in the PrimeCare Platform.

---

## 🚀 Quick 1-Click Execution in Eclipse / IDE

1. **Open File**:
   - Navigate to [`testingFramework1.0/src/test/java/testNG/PrimeCare/MasterScreenTestRunner.java`](file:///c:/Users/Admin2/Documents/GitHub/primecare-platform/testingFramework1.0/src/test/java/testNG/PrimeCare/MasterScreenTestRunner.java).

2. **Run All 947 Screens (Default)**:
   - Click the green **▶️ Play Button** on `testRunMasterSuite()` or on the Class name in Eclipse.

---

## ⚙️ How to Change Default Filter Options

At the top of `MasterScreenTestRunner.java`:

```java
public static String DEFAULT_RUN_MODE    = "ALL";                // "ALL" | "SCREEN" | "ROLE" | "APP"
public static String DEFAULT_SCREEN_CODE = "rmt_dashboard";      // Target Screen Code
public static String DEFAULT_ROLE_CODE   = "cfo";                // Target Role Code
public static String DEFAULT_APP_CODE    = "primecare_clinic";   // Target App Code
```

### Modes Supported:
- **`DEFAULT_RUN_MODE = "ALL";`** ➔ Runs all 947 active screens across all apps and roles.
- **`DEFAULT_RUN_MODE = "SCREEN";`** ➔ Runs a single screen specified in `DEFAULT_SCREEN_CODE`.
- **`DEFAULT_RUN_MODE = "ROLE";`** ➔ Runs all screens belonging to the role specified in `DEFAULT_ROLE_CODE`.
- **`DEFAULT_RUN_MODE = "APP";`** ➔ Runs all screens belonging to the application specified in `DEFAULT_APP_CODE`.

---

## 🎯 Direct 1-Click Method Play Buttons

Inside `MasterScreenTestRunner.java`, you can click the **▶️ Play Button** directly next to any of these methods:

- `testRunMasterSuite()` ➔ Runs according to `DEFAULT_RUN_MODE`.
- `testRunSingleScreen()` ➔ Runs the screen in `DEFAULT_SCREEN_CODE`.
- `testRunSingleRole()` ➔ Runs the role in `DEFAULT_ROLE_CODE`.
- `testRunSingleApp()` ➔ Runs the app in `DEFAULT_APP_CODE`.
- `testRunAllScreens()` ➔ Runs all 947 screens across the platform.
