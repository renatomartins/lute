module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean:
      dist: ['dist']
      build: ['build']

    coffeelint:
      source:
        src: 'src/coffee/**/*.coffee'

    coffee:
      options:
        bare: true
      compile:
        expand: true
        cwd: 'src/coffee'
        src: ['**/*.coffee']
        dest: 'build/js'
        ext: '.js'

    requirejs:
      concat:
        options:
          baseUrl: 'build/js'
          # optimize: 'none'
          include: ['lute']
          out: 'dist/lute.js'
          paths:
            riotjs: '../../bower_components/riotjs/riot'
          shim:
            riotjs:
              exports: 'riot'
          onModuleBundleComplete: (data) ->
            fs = require('fs')
            amdclean = require('amdclean')
            outputFile = data.path
            cleaned = amdclean.clean({filePath: outputFile})
            fs.writeFileSync(outputFile, cleaned)


  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-requirejs')

  grunt.registerTask('default', [
    'clean'
    'coffeelint'
    'coffee'
    'requirejs'
  ])
