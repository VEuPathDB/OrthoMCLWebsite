var configure = require('../../EbrcWebsiteCommon/Site/site.webpack.config');

module.exports = configure({
  entry: {
    orthomcl: require.resolve('../../EbrcWebsiteCommon/Site/webapp/wdkCustomization/js/common.js'),
    'site-client': './webapp/wdkCustomization/js/client.js'
  },
  output: {
    path: __dirname + '/dist',
    filename: '[name].bundle.js'
  }
});
