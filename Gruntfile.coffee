path = require "path"

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    uglify:
      options:
        banner: '/*! <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("yyyy-mm-dd") %> */\n'
        report: 'min'
        # preserveComments: (node, comment) ->
        #   comment.type is "comment2" and comment.value.indexOf("license") isnt -1

      dist:
        files:
          'public/assets/application.js': [
            'public/javascripts/**/*.js',
            "!public/javascripts/vendor/*.js"
            "!public/javascripts/vendor.js"
          ]
          'public/assets/vendor.js': ['public/javascripts/vendor.js']

    bgShell:
      runNode:
        cmd: [".", "node_modules", ".bin", "supervisor --extensions \"node|js|coffee\" --ignore public --watch \"app/controllers/server,app/config/server,app/models/server,node_modules\" app server.js"].join(path.sep)
        bg: true

    stylus:
      compile:
        options:
          paths: ["app/stylesheets"]
        files:
          "public/stylesheets/application.css": "app/stylesheets/application.styl"

    handlebars:
      compile:
        options:
          namespace: "JST"
          partialsUseNamespace: true
          processPartialName: (name) ->
            name = name.replace(/app\/templates\/(shared|client)\//, "")
              .replace(".hbs", "")

            name

          processName: (name) ->
            name = name.replace(/app\/templates\/(shared|client)\//, "")
              .replace(".hbs", "")

            name

        files:
          "public/javascripts/templates.js": ["app/templates/{client,shared}/**/*.hbs"]

    concat:
      dist:
        options:
          separator: ";"
          stripBanners:
            line: true
            block: false
          # process: true

        files:
          "public/javascripts/vendor.js": ["public/javascripts/vendor/jquery.js", "public/javascripts/vendor/**/*.js"]
          "public/assets/application.css": "public/stylesheets/*.css"
          "public/assets/vendor.css": "public/stylesheets/vendor/*.css"

    watch:
      options:
        livereload: true

      coffee:
        files: ['app/{config,controllers,models,views}/client/**/*.coffee']
        tasks: ['coffee']

      handlebar:
        files: ['app/templates/{client,shared}/**/*.hbs']
        tasks: ['handlebars']

      css:
        files: ['app/stylesheets/*.styl']
        tasks: ['stylus']

    clean:
      controllers: ["tmp/controllers"]

    coffee:
      client:
        options:
          sourceMap: false
        files: [
          expand: true
          cwd: "app"
          src: "*/client/**/*.coffee"
          dest: "public/javascripts"
          rename: (folder, name) ->
            name = name.replace(/\/(client|shared)/, "")

            [folder, name].join path.sep
          ext: ".js"
        ]

    copy:
      client:
        files:
          # bootstrap
          "public/javascripts/vendor/bootstrap.js": "bower_components/bootstrap/dist/js/bootstrap.js"
          "public/stylesheets/vendor/bootstrap.css": "bower_components/bootstrap/dist/css/bootstrap.css"
          # jquery
          "public/javascripts/vendor/jquery.js": "bower_components/jquery/jquery.js"

          # underscore
          "public/javascripts/vendor/underscore.js": "bower_components/underscore/underscore.js"
          # underscore.string
          "public/javascripts/vendor/underscore.string.js": "bower_components/underscore.string/lib/underscore.string.js"

          # handlebars
          "public/javascripts/vendor/handlebars.js": "bower_components/handlebars/handlebars.js"

          # backbone
          "public/javascripts/vendor/backbone.js": "bower_components/backbone/backbone.js"

          # backbone.marionette
          "public/javascripts/vendor/backbone.marionette.js": "bower_components/backbone.marionette/lib/backbone.marionette.js"

          # backbone.babysitter
          "public/javascripts/vendor/backbone.babysitter.js": "bower_components/backbone.babysitter/lib/backbone.babysitter.js"


  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-stylus"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-handlebars"
  grunt.loadNpmTasks "grunt-bg-shell"
  grunt.loadNpmTasks "grunt-apidoc"

  grunt.registerTask "compile", ["coffee:client", "stylus"]
  grunt.registerTask "server", ["bgShell:runNode", "watch"]

  grunt.registerTask "bower", ["copy:client"]

  grunt.registerTask "build", ["compile", "handlebars", "concat", "uglify"]

  grunt.registerTask "default", ["compile"]