var configure = require('../../EuPathSiteCommon/Site/site.webpack.config');

module.exports = configure({
  entry: {
    orthomcl: require.resolve('../../EuPathSiteCommon/Site/webapp/wdkCustomization/js/common.js')
  },
  output: {
    path: __dirname + '/dist',
    filename: '[name].bundle.js'
  }
});
