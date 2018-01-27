/**
 * 生成升级配置文件 upgrade.json
 */
const path = require('path');
const fs = require('fs');
const crypto = require('crypto');
const config = require('./config');
const cmd = require('./CMD');



const platforms = {
  'win32-setup': {name: 'win32', ext: '.exe'},
  'win64-setup': {name: 'win64', ext: '.exe'},
  'osx32': {name: 'osx32', ext: '.app'},
  'osx64': {name: 'osx64', ext: '.app'},
  'linux32': {name: 'linux32', ext: '.gz'},
  'linux64': {name: 'linux64', ext: '.gz'}
};

// `./output/pc.json`
module.exports.write = makeUpgrade;
async function makeUpgrade() {
  let upgradeJson = {
    name: config.proPackage.name ? config.proPackage.name : '',
    appName: config.proPackage.appName ? config.proPackage.appName : '',
    version: config.proPackage.version ? config.proPackage.version : '',
    updateInfo: config.proPackage.updateInfo ? config.proPackage.updateInfo : '',
    updateDate: new Date().toLocaleDateString(),
    packages: {}
  };
  /*
  packages: {
  win32:{setup: {}, md5: {}}
  }
   */

  let dirs = fs.readdirSync(config.buildPath);

  for (let dirName of dirs) {
    let platform = platforms[dirName];
    if (!platform) continue;

    if (!upgradeJson.packages[platform.name]) {
      upgradeJson.packages[platform.name] = {}
    }

    let readPath = path.join(config.buildPath, dirName);

    let files = fs.readdirSync(readPath);
    for (let fileName of files) {
      let filePath = path.join(readPath, fileName);
      let md5 = await getmd5(filePath);
      upgradeJson.packages[platform.name] = {
        name: fileName,
        path: path.join(config.proPackage.version, dirName, fileName),
        md5: md5,
        size: fs.statSync(filePath).size,
      };
    }
  }

  makeJson(upgradeJson)
}

function makeJson(upgradeJson) {
  let outputPath = path.dirname(config.upgrade.outputFile);
  if (!fs.existsSync(outputPath)) fs.mkdirSync(outputPath);

  fs.writeFileSync(config.upgrade.outputFile, JSON.stringify(upgradeJson, null, 2), 'utf-8');
  console.log('文件打包完成');
  cmd.open(outputPath);
}


function getmd5(filePath) {
  return new Promise(function (resolve, reject) {
    let md5sum = crypto.createHash('md5');
    let stream = fs.createReadStream(filePath);
    stream.on('data', function (chunk) {
      md5sum.update(chunk);
    });
    stream.on('end', function () {
      let md5 = md5sum.digest('hex').toUpperCase();
      resolve(md5);
    });
  })
}

