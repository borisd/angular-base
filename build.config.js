'use strict';

//basic configuration object used by gulp tasks
module.exports = {
  port: 3001,
  tmp:  '.tmp',
  dist: 'build',
  base: 'app',
  html: 'app/views/**/*.html',
  tpl:  [
    'app/views/**/*.html',
    '!app/index.html'
  ],
  mainScss: 'app/assets/stylesheets/main.scss',
  scss: 'app/assets/stylesheets/**/*.scss',
  coffee: 'app/**/*.coffee',
  js: [
    'app/lib/**/*.js',
    'app/config/**/*.js',
    'app/views/**/*.js',
    'app/services/**/*.js',
    '!app/vendor/**/*.js'
  ],
  index: 'app/index.html',
  assets: 'app/assets/**',
  images: 'app/assets/images/**/*',
  banner: ['/**',
    ' * <%= pkg.name %> - <%= pkg.description %>',
    ' * @version v<%= pkg.version %>',
    ' * @link <%= pkg.homepage %>',
    ' * @license <%= pkg.license %>',
    ' */',
    ''
  ].join('\n')
};
