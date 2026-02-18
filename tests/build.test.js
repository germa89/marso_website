const { test } = require('node:test');
const assert = require('node:assert');
const { execSync } = require('child_process');
const { readFileSync, existsSync } = require('fs');
const { resolve } = require('path');

// Get project root (one level up from tests directory)
const rootDir = resolve(__dirname, '..');

test('template.json is valid JSON', () => {
  const templatePath = resolve(rootDir, 'template.json');
  const templateContent = readFileSync(templatePath, 'utf-8');

  let template;
  assert.doesNotThrow(() => {
    template = JSON.parse(templateContent);
  }, 'template.json should be valid JSON');

  assert(template.title, 'template.json should have a title field');
  assert(template.subtitle, 'template.json should have a subtitle field');
  assert(template.sections, 'template.json should have a sections field');
});

test('build process successfully generates index.html', () => {
  try {
    const output = execSync('npm run build-mustache', {
      cwd: rootDir,
      encoding: 'utf-8'
    });
    // Command should succeed
    assert(true, 'build-mustache should complete without error');
  } catch (error) {
    assert.fail(`Build failed: ${error.message}`);
  }
});

test('generated index.html exists and is not empty', () => {
  const indexPath = resolve(rootDir, 'index.html');
  assert(existsSync(indexPath), 'index.html should exist after build');

  const content = readFileSync(indexPath, 'utf-8');
  assert(content.length > 0, 'index.html should not be empty');
});

test('index.html has valid HTML structure', () => {
  const indexPath = resolve(rootDir, 'index.html');
  const content = readFileSync(indexPath, 'utf-8');

  assert(content.includes('<!doctype html>') || content.includes('<!DOCTYPE html>'),
    'Should have DOCTYPE declaration');
  assert(content.includes('<html'), 'Should have html element');
  assert(content.includes('<head>'), 'Should have head element');
  assert(content.includes('<body>'), 'Should have body element');
  assert(content.includes('</html>'), 'Should close html element');
});

test('index.html has critical content sections', () => {
  const indexPath = resolve(rootDir, 'index.html');
  const content = readFileSync(indexPath, 'utf-8');

  assert(content.includes('Distribuciones Marso'), 'Should contain company name');
  assert(content.includes('id="contact"'), 'Should have contact section');
  assert(content.includes('marsodistribuciones@gmail.com'), 'Should have contact email');
  assert(content.includes('Sobre nosotros') || content.includes('about'), 'Should have about section');
});

test('index.html has no unrendered mustache variables', () => {
  const indexPath = resolve(rootDir, 'index.html');
  const content = readFileSync(indexPath, 'utf-8');

  // Check for unreplaced mustache variables (should not appear in final HTML)
  const hasUnrenderedVars = /\{\{[^}]+\}\}/g.test(content);
  assert(!hasUnrenderedVars, 'Should not have unrendered mustache variables ({{ }})');
});

test('index.html has proper title tag', () => {
  const indexPath = resolve(rootDir, 'index.html');
  const content = readFileSync(indexPath, 'utf-8');

  const titleMatch = content.match(/<title>([^<]+)<\/title>/);
  assert(titleMatch && titleMatch[1].length > 0, 'Should have a non-empty title tag');
  assert(titleMatch[1].includes('Distribuciones Marso'), 'Title should mention the company');
});
