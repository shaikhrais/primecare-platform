#!/usr/bin/env node
/**
 * Logo Resize Script for PrimeCare
 * 
 * This script takes a high-resolution source logo and generates
 * all required sizes for Android, iOS, and Web platforms.
 * 
 * Usage: node resize-logo.cjs <source-image>
 */

const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

// Configuration for all output sizes
const TARGET_APPS = [
    'mobile-client',
    'mobile-psw',
    'PrimeCareClient',
    'PrimeCarePsw'
];

const OUTPUT_CONFIG = {
    // Android mipmap sizes (Must be square)
    android: {
        sizes: [
            { folder: 'mipmap-mdpi', size: 48 },
            { folder: 'mipmap-hdpi', size: 72 },
            { folder: 'mipmap-xhdpi', size: 96 },
            { folder: 'mipmap-xxhdpi', size: 144 },
            { folder: 'mipmap-xxxhdpi', size: 192 },
        ],
        filenames: ['ic_launcher.png', 'ic_launcher_round.png'],
        square: true
    },
    // iOS app icon sizes (Must be square)
    ios: {
        sizes: [
            { name: 'Icon-20', size: 20 },
            { name: 'Icon-20@2x', size: 40 },
            { name: 'Icon-20@3x', size: 60 },
            { name: 'Icon-29', size: 29 },
            { name: 'Icon-29@2x', size: 58 },
            { name: 'Icon-29@3x', size: 87 },
            { name: 'Icon-40', size: 40 },
            { name: 'Icon-40@2x', size: 80 },
            { name: 'Icon-40@3x', size: 120 },
            { name: 'Icon-60@2x', size: 120 },
            { name: 'Icon-60@3x', size: 180 },
            { name: 'Icon-76', size: 76 },
            { name: 'Icon-76@2x', size: 152 },
            { name: 'Icon-83.5@2x', size: 167 },
            { name: 'Icon-1024', size: 1024 },
        ],
        square: true
    },
    // Web sizes (Preserve aspect ratio for main logo)
    web: {
        outputDir: '../../apps/web-marketing/public',
        sizes: [
            { name: 'logo', height: 512 },
            { name: 'logo-192', height: 192 },
            { name: 'logo-32', height: 32 },
            { name: 'favicon', size: 32, square: true },
        ]
    },
    // Shared package (source of truth)
    shared: {
        outputDir: './assets',
        sizes: [
            { name: 'logo', height: 1024 },
            { name: 'logo-512', height: 512 },
            { name: 'logo-256', height: 256 },
        ]
    }
};

async function resizeAndSave(sourceImage, outputPath, sizeConfig, filename) {
    const fullPath = path.join(outputPath, filename);

    // Ensure directory exists
    if (!fs.existsSync(outputPath)) {
        fs.mkdirSync(outputPath, { recursive: true });
    }

    let pipeline = sharp(sourceImage).trim(); // Always trim extra transparent space

    if (sizeConfig.square) {
        pipeline = pipeline.resize(sizeConfig.size, sizeConfig.size, {
            fit: 'contain',
            background: { r: 0, g: 0, b: 0, alpha: 0 }
        });
    } else {
        // Just resize to target height, keeping aspect ratio
        pipeline = pipeline.resize({ height: sizeConfig.height || sizeConfig.size });
    }

    await pipeline.png().toFile(fullPath);
    console.log(`✓ Created: ${fullPath}`);
}

async function processAndroid(sourceImage, baseDir, appName) {
    const config = OUTPUT_CONFIG.android;
    const outputBase = path.resolve(baseDir, `../../apps/${appName}/android/app/src/main/res`);

    if (!fs.existsSync(path.resolve(baseDir, `../../apps/${appName}/android`))) return;

    console.log(`\n📱 Generating Android icons for ${appName}...`);
    for (const sizeConfig of config.sizes) {
        const outputDir = path.join(outputBase, sizeConfig.folder);
        for (const filename of config.filenames) {
            await resizeAndSave(sourceImage, outputDir, { ...sizeConfig, square: true }, filename);
        }
    }
}

async function processIOS(sourceImage, baseDir, appName) {
    const config = OUTPUT_CONFIG.ios;
    const iosDir = path.resolve(baseDir, `../../apps/${appName}/ios`);
    if (!fs.existsSync(iosDir)) return;

    let projectFolder = appName.replace(/-/g, '');
    let outputDir = path.join(iosDir, projectFolder, 'Images.xcassets/AppIcon.appiconset');

    if (!fs.existsSync(outputDir)) {
        const findAppIconSet = (dir) => {
            const files = fs.readdirSync(dir);
            for (const file of files) {
                const fullPath = path.join(dir, file);
                if (fs.statSync(fullPath).isDirectory()) {
                    if (file === 'AppIcon.appiconset') return fullPath;
                    const result = findAppIconSet(fullPath);
                    if (result) return result;
                }
            }
            return null;
        };
        try {
            outputDir = findAppIconSet(iosDir);
        } catch (e) { }
    }

    if (!outputDir || !fs.existsSync(outputDir)) {
        console.log(`⚠️ Could not find iOS AppIcon.appiconset for ${appName}`);
        return;
    }

    console.log(`\n🍎 Generating iOS icons for ${appName}...`);
    for (const sizeConfig of config.sizes) {
        await resizeAndSave(sourceImage, outputDir, { ...sizeConfig, square: true }, `${sizeConfig.name}.png`);
    }
}

async function processWeb(sourceImage, baseDir) {
    console.log('\n🌐 Generating Web icons...');
    const config = OUTPUT_CONFIG.web;
    const outputDir = path.resolve(baseDir, config.outputDir);

    for (const sizeConfig of config.sizes) {
        await resizeAndSave(sourceImage, outputDir, sizeConfig, `${sizeConfig.name}.png`);
    }
}

async function processShared(sourceImage, baseDir) {
    console.log('\n📦 Generating Shared package icons...');
    const config = OUTPUT_CONFIG.shared;
    const outputDir = path.resolve(baseDir, config.outputDir);

    for (const sizeConfig of config.sizes) {
        await resizeAndSave(sourceImage, outputDir, sizeConfig, `${sizeConfig.name}.png`);
    }
}

async function main() {
    const args = process.argv.slice(2);

    if (args.length === 0) {
        console.log('Usage: node resize-logo.cjs <source-image>');
        process.exit(1);
    }

    const sourceImage = args[0];
    const baseDir = __dirname;

    if (!fs.existsSync(sourceImage)) {
        console.error(`Error: Source image not found: ${sourceImage}`);
        process.exit(1);
    }

    console.log(`\n🎨 PrimeCare Logo Resize Script (Aspect Ratio Preservation)`);
    console.log(`==========================================================`);
    console.log(`Source: ${sourceImage}`);

    try {
        await processShared(sourceImage, baseDir);

        for (const app of TARGET_APPS) {
            await processAndroid(sourceImage, baseDir, app);
            await processIOS(sourceImage, baseDir, app);
        }

        await processWeb(sourceImage, baseDir);

        console.log('\n✅ All icons generated and synchronized successfully!');
    } catch (error) {
        console.error('Error processing images:', error);
        process.exit(1);
    }
}

main();
