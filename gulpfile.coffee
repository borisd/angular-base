config      = require("./build.config.js")
gulp        = require("gulp")
$           = require("gulp-load-plugins")()
runSequence = require("run-sequence")
browserSync = require("browser-sync")
reload      = browserSync.reload
pkg         = require("./package")
del         = require("del")

# Generate angular templates using html2js
gulp.task "templates", ->
  gulp.src(config.tpl)
    .pipe($.changed(config.tmp))
    .pipe($.html2js(
      outputModuleName: "templates"
      base: config.base
      useStrict: true
    ))
    .pipe($.concat("templates.js"))
    .pipe(gulp.dest(config.tmp))
    .pipe $.size(title: "templates")

gulp.task "sass", ->
  gulp.src(config.mainScss)
    .pipe($.rubySass(
      loadPath: [process.cwd() + "/app/vendor/bootstrap-sass-official/assets/stylesheets"]
      lineNumbers: true
    ))
    .on("error", (err) ->
      console.log err.message
      return
    )
    .pipe(gulp.dest(config.tmp))
    .pipe $.size(title: "sass")

gulp.task "coffee", ->
  gulp.src(config.coffee)
  .pipe($.plumber())
  .pipe($.coffee())
  .pipe(gulp.dest(config.tmp))
  .pipe $.size(title: "coffee")

gulp.task "build", ["clean"], (cb) ->
  runSequence [
    "sass"
    "coffee"
    "templates"
  ], cb

gulp.task "clean", del.bind(null, [ config.dist, config.tmp ])

gulp.task "serve", ["build"], ->
  browserSync
    notify: false
    logPrefix: pkg.name
    server: [ config.base, config.tmp ]

  gulp.watch config.scss, [ "sass", reload ]
  gulp.watch config.coffee, [ "coffee", reload ]
  gulp.watch config.tpl, [ "templates", reload ]
  gulp.watch config.assets, reload
  gulp.watch config.index, reload

gulp.task "default", ["serve"]


# == Distribution ==


# Optimize images and put them in the dist folder
gulp.task "images", ->
  gulp.src(config.images).pipe($.imagemin(
    progressive: true
    interlaced: true
  ))
    .pipe(gulp.dest(config.dist + "/assets/images"))
    .pipe $.size(title: "images")

gulp.task "build:dist", ["clean"], (cb) ->
  runSequence [
    "build"
    "copy"
    "copy:assets"
    "images"
  ], "html", cb

# Generate a minified css files, 2 js file, change theirs name to be unique, and generate sourcemaps
gulp.task "html", ->
  assets = $.useref.assets(searchPath: "{#{config.base},#{config.tmp}}")
  gulp.src(config.index)
    .pipe(assets)
    .pipe($.sourcemaps.init())
    .pipe($.if("**/*main.js", $.ngAnnotate()))
    .pipe($.if("*.js", $.uglify(mangle: false)))
    .pipe($.if("*.css", $.csso()))
    .pipe($.if([
        "**/*main.js"
        "**/*main.css"
      ], $.header(config.banner, pkg: pkg )))
    .pipe($.rev())
    .pipe(assets.restore())
    .pipe($.useref())
    .pipe($.revReplace())
    .pipe($.if("*.html", $.minifyHtml(empty: true)))
    .pipe($.sourcemaps.write())
    .pipe(gulp.dest(config.dist))
    .pipe $.size(title: "html")

# Copy assets in dist folder
gulp.task "copy:assets", ->
  gulp.src(config.assets, dot: true)
    .pipe(gulp.dest(config.dist + "/assets"))
    .pipe $.size(title: "copy:assets")

gulp.task "copy", ->
  gulp.src([
    config.base + "/*"
    "!" + config.base + "/*.html"
    "!" + config.base + "/src"
  ])
    .pipe(gulp.dest(config.dist))
    .pipe $.size(title: "copy")

# Create distribution and run it
gulp.task "serve:dist", ["build:dist"], ->
  browserSync
    notify: false
    server: [config.dist]
