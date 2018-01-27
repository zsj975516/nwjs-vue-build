const path = require('path');

function resolve() {
  return path.resolve.apply(path, [__dirname, '..'].concat(...arguments))
}

// 项目 package.json
const proPackage = require(resolve('package.json'));

const buildPath = resolve('releases', proPackage.version);

const config = {
  buildPath: buildPath,
  proPackage: proPackage,
  template: resolve('app/renderer/index.ejs'),
  assetsRoot: resolve('dist'),
  vuePath: resolve('app/renderer'),
  manifest: ['name', 'appName', 'version', 'description', 'author', {main: './index.html'}, 'manifestUrl', 'window', 'nodejs', 'js-flags', 'node-remote'],

  nwBuilder: {
    files: [resolve('dist/**')],
    platforms: ['win32', 'win64'/*, 'osx64'*/],//会创建文件夹
    version: '0.14.7',
    flavor: 'normal',
    cacheDir: resolve('node_modules/_nw-builder-cache'),
    buildDir: resolve('releases'),
    winIco: resolve('static/logo.ico'),
    macIcns: resolve('static/logo.icns'),
    buildType: function () {
      return this.appVersion
    }
  },
  innosetup: {
    ISCC: resolve('deps/innosetup/bin/ISCC.exe'),
    issPath: resolve('build_/setup_resources/template.iss'),
    LicenseFile: resolve('build_/setup_resources/license.txt'),
    SetupIconFile: resolve('static/logo.ico'),
    expectDir: ['win32', 'win64'],//期望打包的文件夹
    outputFileName: function (platform) {
      return `${proPackage.appName}-${platform}-${proPackage.version}`;
    }
  },
  upgrade: {
    outputFile: resolve('releases/upgrade.json')
  }
};
module.exports = config;
