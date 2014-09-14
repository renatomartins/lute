module.exports = (grunt) ->


  # path relative to requirejs baseUrl
  bower = '../../bower_components'

  requirejsConfig =
    baseUrl: 'build/src'
    # optimize: 'none'
    include: ['app']
    out: 'dist/app.js'
    paths:
      helper: '../spec/helper'
      riot: "#{bower}/riotjs/riot"
      jquery: "#{bower}/jquery/dist/jquery"
    shim:
      riot:
        exports: 'riot'
    onModuleBundleComplete: (data) ->
      fs = require('fs')
      amdclean = require('amdclean')
      outputFile = data.path
      cleaned = amdclean.clean({filePath: outputFile})
      fs.writeFileSync(outputFile, cleaned)


  grunt.initConfig

    pkg: grunt.file.readJSON('package.json')

    clean:
      dist: ['dist']
      build: ['build']

    coffeelint:
      src: 'src/coffee/**/*.coffee'
      spec: 'spec/**/*.coffee'

    coffee:
      options:
        bare: true
      src:
        expand: true
        cwd: 'src/coffee'
        src: ['**/*.coffee']
        dest: 'build/src'
        ext: '.js'
      spec:
        expand: true
        cwd: 'spec'
        src: ['**/*.coffee']
        dest: 'build/spec'
        ext: '.js'

    jst:
      options:
        namespace: false
        amd: true
        templateSettings:
          interpolate: /\{\{(.+?)\}\}/g
      compile:
        expand: true
        cwd: 'src/html/template'
        src: ['**/*.mustache']
        dest: 'build/src/template'
        ext: '.js'

    jasmine:
      test:
        options:
          helpers: 'build/spec/helper/*.js'
          specs: 'build/spec/**/*.js'
          template: require('grunt-template-jasmine-requirejs')
          templateOptions:
            requireConfig: requirejsConfig

    requirejs:
      dist:
        options: requirejsConfig


    copy:
      html:
        files:
          'dist/index.html': 'src/html/index.html'


  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-jst')
  grunt.loadNpmTasks('grunt-contrib-requirejs')
  grunt.loadNpmTasks('grunt-contrib-jasmine')
  grunt.loadNpmTasks('grunt-contrib-copy')

  grunt.registerTask('default', [
    'coffeelint'
    'clean:build'
    'coffee'
    'jst'
    'clean:dist'
    'requirejs'
    'copy:html'
  ])
  grunt.registerTask('test', [
    'default'
    'jasmine'
  ])
