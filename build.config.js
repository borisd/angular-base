'use strict';

//basic configuration object used by gulp tasks
module.exports = {
  port: 3001,
  tmp:  '.tmp',
  dist: 'build',
  base: 'app',
  html: 'app/views/**/*.html',
  consts: 'app/config',
  tpl:  [
    'app/views/**/*.html',
    '!app/index.html'
  ],
  mainScss: 'app/assets/stylesheets/main.scss',
  scss: 'app/assets/stylesheets/**/*.scss',
  coffee: [
    'app/**/*.coffee',
    '!app/config/env/*.coffee'
  ],
  js: [
    'app/lib/**/*.js',
    'app/config/**/*.js',
    'app/views/**/*.js',
    'app/services/**/*.js',
    '!app/vendor/**/*.js',
    '!app/config/env/*.js'
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
