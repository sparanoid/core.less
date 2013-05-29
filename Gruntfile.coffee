module.exports = (grunt) ->

  # Load all grunt tasks
  matchdep = require("matchdep")
  matchdep.filterDev("grunt-*").forEach grunt.loadNpmTasks

  # Configurable paths
  coreConfig =
    app: "core.less"
    assets: "."
    dist: "core.less"
    pkg: grunt.file.readJSON("package.json")
    banner: do ->
      banner = "/*\n"
      banner += " * (c) <%= core.pkg.author %>.\n *\n"
      banner += " * <%= core.pkg.name %> - v<%= core.pkg.version %> (<%= grunt.template.today('mm-dd-yyyy') %>)\n"
      banner += " * <%= core.pkg.homepage %>\n"
      banner += " * <%= core.pkg.license.type %> - <%= core.pkg.license.url %>\n"
      banner += " */"
      banner

  # Project configurations
  grunt.initConfig
    core: coreConfig

    coffeelint:
      options:
        indentation: 2
        no_stand_alone_at:
          level: "error"
        no_empty_param_list:
          level: "error"
        max_line_length:
          level: "ignore"

      test:
        files:
          src: ["Gruntfile.coffee"]

    recess:
      test:
        files:
          src: ["<%= core.app %>/{,*/}*.less"]

    watch:
      coffee:
        files: ["<%= coffeelint.test.files.src %>"]
        tasks: ["coffeelint"]

      less:
        files: ["<%= recess.test.files.src %>"]
        tasks: ["less:server", "recess"]

    less:
      server:
        options:
          paths: ["<%= core.app %>"]
          # dumpLineNumbers: "all"

        files:
          ".tmp/core.css": ["<%= recess.test.files.src %>"]

      dist:
        options:
          paths: ["<%= core.app %>"]
          # yuicompress: true

        files:
          "<%= core.app %>/core.css": ["<%= recess.test.files.src %>"]

    cssmin:
      dist:
        options:
          banner: "<%= core.banner %>"
          report: "gzip"

        files:
          "<%= core.dist %>/core.css": ["<%= core.dist %>/*.css"]

    clean: [".tmp"]

  grunt.registerTask "server", ["watch"]
  grunt.registerTask "test", ["coffeelint", "recess"]
  grunt.registerTask "build", ["clean", "test", "less:dist", "cssmin"]
  grunt.registerTask "default", ["build"]