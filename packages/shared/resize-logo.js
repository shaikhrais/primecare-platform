#!/usr/bin/env node
/**
 * Logo Resize Script for PrimeCare
 * 
 * This script takes a high-resolution source logo and generates
 * all required sizes for Android, iOS, and Web platforms.
 * 
 * Usage: node resize-logo.js <source-image>
 * 
 * Requirements: npm install sharp
 */

const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

// Configuration for all output sizes
const OUTPUT_CONFIG = {
    // Android mipmap sizes
    android: {
        outputDir: '../apps/mobile-client/android/app/src/main/res',
        sizes: [
            { folder: 'mipmap-mdpi', size: 48 },
            { folder: 'mipmap-hdpi', size: 72 },
            { folder: 'mipmap-xhdpi', size: 96 },
            { folder: 'mipmap-xxhdpi', size: 144 },
            { folder: 'mipmap-xxxhdpi', size: 192 },
        ],
        filenames: ['ic_launcher.png', 'ic_launcher_round.png']
    },
    // iOS app icon sizes
    ios: {
        outputDir: '../apps/mobile-client/ios/mobileclient/Images.xcassets/AppIcon.appiconset',
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
        ]
    },
    // Web sizes
    web: {
        outputDir: '../apps/web-marketing/public',
        sizes: [
            { name: 'logo', size: 512 },
            { name: 'logo-192', size: 192 },
            { name: 'logo-32', size: 32 },
            { name: 'favicon', size: 32 },
        ]
    },
    // Shared package (source of truth)
    shared: {
        outputDir: './assets',
        sizes: [
            { name: 'logo', size: 1024 },
            { name: 'logo-512', size: 512 },
            { name: 'logo-256', size: 256 },
        ]
    }
};

async function resizeAndSave(sourceImage, outputPath, size, filename) {
    const fullPath = path.join(outputPath, filename);

    // Ensure directory exists
    fs.mkdirSync(outputPath, { recursive: true });

    await sharp(sourceImage)
        .resize(size, size, {
            fit: 'contain',
            background: { r: 0, g: 0, b: 0, alpha: 0 }
        })
        .png()
        .toFile(fullPath);

    console.log(`✓ Created: ${fullPath} (${size}x${size})`);
}

async function processAndroid(sourceImage, baseDir) {
    console.log('\n📱 Generating Android icons...');
    const config = OUTPUT_CONFIG.android;
    const outputBase = path.resolve(baseDir, config.outputDir);

    for (const sizeConfig of config.sizes) {
        const outputDir = path.join(outputBase, sizeConfig.folder);
        for (const filename of config.filenames) {
            await resizeAndSave(sourceImage, outputDir, sizeConfig.size, filename);
        }
    }
}

async function processIOS(sourceImage, baseDir) {
    console.log('\n🍎 Generating iOS icons...');
    const config = OUTPUT_CONFIG.ios;
    const outputDir = path.resolve(baseDir, config.outputDir);

    for (const sizeConfig of config.sizes) {
        await resizeAndSave(sourceImage, outputDir, sizeConfig.size, `${sizeConfig.name}.png`);
    }
}

async function processWeb(sourceImage, baseDir) {
    console.log('\n🌐 Generating Web icons...');
    const config = OUTPUT_CONFIG.web;
    const outputDir = path.resolve(baseDir, config.outputDir);

    for (const sizeConfig of config.sizes) {
        await resizeAndSave(sourceImage, outputDir, sizeConfig.size, `${sizeConfig.name}.png`);
    }
}

async function processShared(sourceImage, baseDir) {
    console.log('\n📦 Generating Shared package icons...');
    const config = OUTPUT_CONFIG.shared;
    const outputDir = path.resolve(baseDir, config.outputDir);

    for (const sizeConfig of config.sizes) {
        await resizeAndSave(sourceImage, outputDir, sizeConfig.size, `${sizeConfig.name}.png`);
    }
}

async function main() {
    const args = process.argv.slice(2);

    if (args.length === 0) {
        console.log('Usage: node resize-logo.js <source-image>');
        console.log('Example: node resize-logo.js ./assets/logo-source.png');
        process.exit(1);
    }

    const sourceImage = args[0];
    const baseDir = __dirname;

    if (!fs.existsSync(sourceImage)) {
        console.error(`Error: Source image not found: ${sourceImage}`);
        process.exit(1);
    }

    console.log(`\n🎨 PrimeCare Logo Resize Script`);
    console.log(`================================`);
    console.log(`Source: ${sourceImage}`);

    try {
        await processShared(sourceImage, baseDir);
        await processAndroid(sourceImage, baseDir);
        await processIOS(sourceImage, baseDir);
        await processWeb(sourceImage, baseDir);

        console.log('\n✅ All icons generated successfully!');
        console.log('\nNext steps:');
        console.log('1. Verify the generated icons look correct');
        console.log('2. Rebuild your apps to use the new icons');
        console.log('3. Redeploy web-marketing if needed');
    } catch (error) {
        console.error('Error processing images:', error);
        process.exit(1);
    }
}

main();
