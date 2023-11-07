module.exports = (grunt) ->
  #load all grunt tasks
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  srcDirPath = "./src/"
  distDirPath = "./htdocs/"

  grunt.initConfig
    clean:
      files: [distDirPath]
      options:
        force: true
    coffee:
      files:
        expand: true
        cwd: srcDirPath + "src/"
        src: "**/*.coffee"
        dest: distDirPath + "js/"
        ext: ".js"
    copy:
      assets:
        expand: true
        cwd: srcDirPath + "assets/"
        src: [
          "**/*.*"
          "!**/*.sass"
        ]
        dest: distDirPath+ "assets/"
#      vendor:
#        expand: true
#        cwd: srcDirPath + "vendor/"
#        src: [
#          "**/*.*"
#        ]
#        dest: distDirPath+ "vendor/"
      index:
        expand: true
        cwd: srcDirPath
        src: [
          "index.html"
        ]
        dest: distDirPath
      images:
        expand: true
        cwd: srcDirPath + "assets/images/"
        src: [
          "**/*.{jpg,png}"
        ]
        dest: distDirPath + "assets/images/"
#      js:
#        expand: true
#        cwd: srcDirPath + "src/"
#        src: [
#          "**/*.js"
#        ]
#        dest: distDirPath + "js/"
      prod:
        src: "build/requirejs/bootstrap_prod.js"
        dest: distDirPath + "assets/js/boot.js"
      dev:
        src: "build/requirejs/bootstrap_dev.js"
        dest: distDirPath + "assets/js/boot.js"
    compass:
      options:
        relativeAssets: true
        sassDir: srcDirPath + 'assets/styles'
        cssDir: distDirPath + 'assets/css'
        imagesDir: distDirPath + 'assets/images'
        fontsDir: distDirPath + 'assets/fonts'
#        config: 'config.rb'
      dev:
        options:
          outputStyle: 'expanded'
          environment: 'development'
      dist:
        options:
          outputStyle: 'compressed'
          environment: 'production'
    autoprefixer:
      dist:
        options:
          browsers: [
            'last 2 versions'
            '> 5%'
            'ie 9'
          ]
          cascade: true
        files: [
          expand: true
          cwd: distDirPath + "assets/css/"
          src: "**.css"
          dest: distDirPath + "assets/css/"
          filter: 'isFile'
        ]
    processhtml:
      dist:
        files: [
          expand: true
          cwd: srcDirPath + 'assets/views'
          src: ['**']
          dest: distDirPath + "assets/views"
          filter: 'isFile'
        ]
    watch:
      compass:
        files: [srcDirPath + 'assets/styles/**/**']
        tasks: ['compass:dist', 'autoprefixer']
        options:
          livereload: true
      coffee:
        files: [srcDirPath + 'src/**.coffee']
        tasks: ['coffee']
        options:
          livereload: true
#      fonts:
#        files: ['src/fonts/*']
#        tasks: ['copy:font']
#        options:
#          livereload: true
      index:
        files: [srcDirPath + 'index.html']
        tasks: ['copy:index']
        options:
          livereload: true
       images:
        files: [srcDirPath + 'assets/images/**']
        tasks: ['copy:images']
        options:
          livereload: true
      html:
        files: [srcDirPath + 'assets/views/**']
        tasks: ['processhtml:dist']
        options:
          livereload: true
    requirejs:
      compile:
        options:
          baseUrl: "./src/src"
          out: distDirPath + '/assets/js/radiotape.js'
          name: 'main'
        preserveLicenseComments : false
        optimize: "uglify"
    bowercopy:
      options:
        srcPrefix: srcDirPath +  '/vendor/'
        destPrefix: distDirPath +  '/vendor/'
        runBower: true
      dist:
        files:
          './': './'


  grunt.registerTask "dist", [
    "clean"
    "copy:assets"
#    "copy:vendor"
    "copy:index"
#    "copy:js"
    "copy:prod"
    "coffee"
    "processhtml:dist"
    "compass:dist"
    "autoprefixer"
    "requirejs"
    "bowercopy:dist"
  ]

  grunt.registerTask "dev", [
    "dist"
    "watch"
  ]

  grunt.registerTask "cleanup", [
    "clean"
  ]