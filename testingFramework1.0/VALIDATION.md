# TestNG website setup validation

Validated with Temurin Java 21 on 2026-10-04.

- Maven test-compile passed (1,163 test-source files after adding regressions).
- Seven offline TestNG regression tests passed, with zero failures or skips.
- All suite XML files parse and all class/listener references resolve to source.
- Fixed unescaped ampersands in the master and smoke suite names.
- Fixed four suite references to PrimeCareLayerTestFactory's actual package.

## Repeat in Eclipse

Use JDK 21. Refresh the Maven project, then right-click
src/test/resources/testng/website-setup-offline.xml and choose Run As > TestNG Suite.
These tests use a mock WebDriver and temporary Excel files; they never open a
website, log in, or modify external records.

## Repeat with Maven

From testingFramework1.0:

```sh
mvn -DskipTests test-compile
mvn -DsuiteXmlFile=src/test/resources/testng/website-setup-offline.xml test
```

The validation session ran the offline tests through TestNG directly with Maven's
resolved project classpath. Maven Surefire execution was attempted but its plugin
download was blocked by a transient proxy connection refusal.

Shared base.baseTest creates/configures the browser without selecting a website.
Each test or page object opens its own entry URL. The PointClickCare HomePage
already selects its existing login URL. ProjectExcelFileData.url reads -Durl first,
then the url cell in MainData.xlsx/config, and fails if both are absent.

## Limits

Live website workflows were not executed. The existing shared static driver is
for sequential use; do not run legacy base.baseTest subclasses in parallel.
PrimeCare verification methods outside this patch still contain legacy auth
assumptions and checks that do not prove every component worked. Compilation and
offline setup tests do not validate those live workflows.
