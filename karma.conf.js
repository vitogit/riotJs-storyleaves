module.exports = function(config) {
  config.set({
    basePath: '',
    frameworks: ['mocha','chai','riot','jquery-1.9.1'],
    plugins: [
      'karma-mocha',
      'karma-mocha-reporter',
      'karma-phantomjs-launcher',
      'karma-chai',
      'karma-riot',
      'karma-jquery'
    ],
    files: [
      'node_modules/chai/chai',
      'src/**/*.tag',
      'test/**/*.js'
    ],
    preprocessors: {
      '**/*.tag': ['riot']
    },
    browsers: ['PhantomJS'],
    reporters: ['mocha'],
    failOnEmptyTestSuite: false,
    autoWatch: true  
  })
}
