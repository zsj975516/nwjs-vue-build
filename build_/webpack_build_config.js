const path = require('path');
const webpack = require('webpack');
const config = require('./config');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const OptimizeCSSPlugin = require('optimize-css-assets-webpack-plugin');
const ExtractTextWebpackPlugin = require('extract-text-webpack-plugin');

function resolve() {
  return path.resolve.apply(path, [__dirname, '..'].concat(...arguments));
}

const webpackConfig = {
  target: 'node-webkit',
  entry: {
    app: resolve('app/renderer/main.js')
  },
  module: {
    rules: [
      ...styleLoaders({
        sourceMap: false,
        extract: true
      }),
      {
        test: /\.js$/,
        loader: 'babel-loader',
        exclude: /node_modules/
      },
      {
        test: /\.vue$/,
        loader: 'vue-loader',
        options: {
          loaders: cssLoaders({
            sourceMap: !process.env.NODE_ENV === 'production',
            extract: process.env.NODE_ENV === 'production'
          }),
          transformToRequire: {
            video: 'src',
            source: 'src',
            img: 'src',
            image: 'xlink:href'
          }
        }
      },
      {
        test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
        loader: 'url-loader',
        query: {
          limit: 10000,
          name: 'static/img/[name].[hash:7].[ext]'
        }
      },
      {
        test: /\.(mp4|webm|ogg|mp3|wav|flac|aac)(\?.*)?$/,
        loader: 'url-loader',
        options: {
          limit: 10000,
          name: 'static/media/[name].[hash:7].[ext]'
        }
      },
      {
        test: /\.(woff2?|eot|ttf|otf)(\?.*)?$/,
        loader: 'url-loader',
        query: {
          limit: 10000,
          name: 'static/fonts/[name].[hash:7].[ext]'
        }
      }
    ]
  },
  devtool: false,
  output: {
    path: config.assetsRoot,
    filename: 'static/js/[name].[chunkhash].js',
    chunkFilename: 'static/js/[id].[chunkhash].js'
  },
  resolve: {
    extensions: ['.js', '.vue', '.json'],
    alias: {
      'vue$': 'vue/dist/vue.esm.js',
      '@': config.vuePath
    }
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {NODE_ENV: 'production'}
    }),
    new webpack.optimize.UglifyJsPlugin({
      compress: {warnings: false},
      sourceMap: true
    }),
    new ExtractTextPlugin({filename: 'static/css/[name].[contenthash].css'}),
    new OptimizeCSSPlugin(),
    new HtmlWebpackPlugin({
      filename: config.assetsRoot + '/index.html',//生成的主页文件
      template: config.template,//主页模板文件
      inject: true,
      minify: {
        removeComments: true,
        collapseWhitespace: true,
        removeAttributeQuotes: true
      },
      chunksSortMode: 'dependency'
    }),
    new webpack.optimize.CommonsChunkPlugin({
      name: 'vendor',
      minChunks: function (module, count) {
        return (
          module.resource &&
          /\.js$/.test(module.resource) &&
          module.resource.indexOf(resolve('node_modules')) === 0
        )
      }
    }),
    new webpack.optimize.CommonsChunkPlugin({name: 'manifest', chunks: ['vendor']}),
    // new CopyWebpackPlugin([
    //   {
    //     from: path.resolve(__dirname, '../static'),
    //     to: 'static',
    //     ignore: ['.*']
    //   }
    // ])
  ],
};

function styleLoaders(options) {
  let output = [];
  let loaders = cssLoaders(options);
  for (let extension in loaders) {
    let loader = loaders[extension];
    output.push({
      test: new RegExp('\\.' + extension + '$'),
      use: loader
    })
  }
  return output
}

function cssLoaders(options) {
  options = options || {};
  let cssLoader = {
    loader: 'css-loader',
    options: {
      minimize:  process.env.NODE_ENV === 'production',
      sourceMap: options.sourceMap
    }
  };

  function generateLoaders(loader, loaderOptions) {
    let loaders = [cssLoader];
    if (loader) {
      loaders.push({
        loader: loader + '-loader',
        options: Object.assign({}, loaderOptions, {
          sourceMap: options.sourceMap
        })
      });
    }

    if (options.extract) {
      return ExtractTextWebpackPlugin.extract({
        use: loaders,
        fallback: 'vue-style-loader'
      });
    } else {
      return ['vue-style-loader'].concat(loaders);
    }
  }

  return {
    css: generateLoaders(),
    postcss: generateLoaders(),
    less: generateLoaders('less'),
    sass: generateLoaders('sass', {indentedSyntax: true}),
    scss: generateLoaders('sass'),
    stylus: generateLoaders('stylus'),
    styl: generateLoaders('stylus')
  };
}

module.exports = webpackConfig;
