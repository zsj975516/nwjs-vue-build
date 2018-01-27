process.env.NODE_ENV = 'production';
const chalk = require('chalk');

const config = require('./config');
const fs = require('fs');
const path = require('path');

function resolve() {
  return path.resolve.apply(path, [__dirname, '..'].concat(...arguments))
}

const vue_build = require('./build-vue');
const nw_build = require('./build-nw');
const win_build = require('./build-win-setup');
const upgrade = require('./build-upgrade');

(async () => {
  try {
    let now = new Date().toLocaleTimeString().replace(/[:]/g, '');
    config.proPackage.fileVersion = `${config.proPackage.version}.${now.substr(1)}`;
    fs.writeFileSync(resolve('package.json'), JSON.stringify(config.proPackage, null, 2), 'utf-8');

    console.log(chalk.cyan('  开始构建VUE...\n'));
    await vue_build.build();
    console.log(chalk.cyan('  VUE构建完成.\n'));

    console.log(chalk.cyan('  开始构建NW...\n'));
    await nw_build.build();
    console.log(chalk.cyan('  NW构建完成.\n'));

    console.log(chalk.cyan('  开始构建Windows安装程序...\n'));
    await win_build.build();
    console.log(chalk.cyan('  Windows安装程序构建完成.\n'));
    upgrade.write();
  } catch (e) {
    console.error(e)
  }
})();
