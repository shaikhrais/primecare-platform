package primecare.testing.validation;

import primecare.testing.models.TestingLayerCode;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface TestLayer {
    TestingLayerCode value();
}
