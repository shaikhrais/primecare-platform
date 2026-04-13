import js from "@eslint/js";

export default [
    js.configs.recommended,
    {
        ignores: ["**/*.d.ts", "**/dist/**", "**/node_modules/**", "**/build/**", "**/generated/**"]
    }
];
