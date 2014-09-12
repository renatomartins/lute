module.exports = (grunt) ->


  requirejsConfig =
    baseUrl: 'build/src/js'
    # optimize: 'none'
    include: ['lute']
    out: 'dist/lute.js'
    paths:
      stubs: '../../specs/js/stubs'
      riotjs: '../../../bower_components/riotjs/riot'
    shim:
      riotjs:
        exports: 'riot'
    onModuleBundleComplete: (data) ->
      fs = require('fs')
      amdclean = require('amdclean')
      outputFile = data.path
      cleaned = amdclean.clean({filePath: outputFile})
      fs.writeFileSync(outputFile, cleaned)


  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    clean:
      dist: ['dist']
      build: ['build']

    coffeelint:
      src: 'src/coffee/**/*.coffee'
      specs: 'specs/**/*.coffee'

    coffee:
      options:
        bare: true
      src:
        expand: true
        cwd: 'src/coffee'
        src: ['**/*.coffee']
        dest: 'build/src/js'
        ext: '.js'
      specs:
        expand: true
        cwd: 'specs'
        src: ['**/*.coffee']
        dest: 'build/specs/js'
        ext: '.js'

    jasmine:
      test:
        options:
          specs: ['build/specs/js/**/*.js']
          template: require('grunt-template-jasmine-requirejs')
          templateOptions:
            requireConfig: requirejsConfig

    requirejs:
      dist:
        options: requirejsConfig

    htmlmin:
      dist:
        options:
          removeComments: true
          collapseWhitespace: true
          removeAttributeQuotes: true
        files:
          'dist/index.html': 'src/html/index.html'


  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-jasmine')
  grunt.loadNpmTasks('grunt-contrib-requirejs')
  grunt.loadNpmTasks('grunt-contrib-htmlmin')

  grunt.registerTask('default', [
    'coffeelint'
    'clean:build'
    'coffee'
    'jasmine'
    'clean:dist'
    'requirejs'
    'htmlmin'
  ])
