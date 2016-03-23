module.exports = function(config) {
  config.set({
    basePath: '',
    frameworks: ['mocha','sinon-chai','riot','jquery-1.9.1'],
    plugins: [
      'karma-mocha',
      'karma-mocha-reporter',
      'karma-phantomjs-launcher',
      'karma-chai',
      'karma-riot',
      'karma-sinon-chai',
      'karma-jquery'
    ],
    files: [
      'src/**/*.tag',
      'src/**/*.js',
      'test/**/*.js',
      'vendor/**/*.js'
    ],
    preprocessors: {
      '**/*.tag': ['riot']
    },
    browsers: ['PhantomJS'],
    reporters: ['mocha'],
    client: {
      mocha: {
        ui: 'bdd',
        grep: '',
      },
      chai: {
        includeStack: true
      }
    },
    failOnEmptyTestSuite: false,
    autoWatch: true
  })
}
