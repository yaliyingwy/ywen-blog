module.exports = (grunt)->
    grunt.initConfig {
        assets: grunt.file.readJSON 'source/config/assets.json'
        uglify: {
            target: {
                files: [{
                    expand: true
                    cwd: 'build/public/js'
                    src: ['**/*.js', '*.js']
                    dest: 'build/public/js'
                    ext: '.min.js'
                    }]
                }
        }
        less: {
            dev: {
                options: {
                    paths: ['source/less/']
                    yuicompress: true
                }
                files: [{
                    expand: true
                    cwd: 'source/less/'
                    src: ['*.less']
                    dest: 'build/public/css'
                    ext: '.css'
                    }]
            }
        }
        coffee: {
            dev: {
                options: {}
                files: [{
                        expand: true
                        cwd: 'source/coffee/public'
                        src: ['**/*.coffee', '*.coffee']
                        dest: 'build/public/js'
                        ext: '.js'
                    },
                    {
                        expand: true
                        cwd: 'source/coffee/cloud'
                        src: ['*.coffee']
                        dest: 'build/cloud'
                        ext: '.js'
                        }]
            }
        }
        shell: {
            avos: {
                command: 'avoscloud'
                options: {
                    execOptions: {
                        cwd: 'build'
                    }
                }
            }
        }
        copy: {
            views: {
                files: [{
                    expand: true
                    cwd: 'source/views/public'
                    src: ['*.html']
                    dest: 'build/public/views'
                },
                {
                    expand: true
                    cwd: 'source/views/cloud'
                    src: ['*.html']
                    dest: 'build/cloud/views'
                    }]
            }
            config: {
                files: [{
                    expand: true
                    cwd: 'source/config'
                    src: '*.*'
                    dest: 'build/config'
                    }]
            }
            bower: {
                files: [{
                    expand: true
                    cwd: 'bower_components'
                    src: '<%= assets.js %>'
                    dest: 'build/public/js/lib'
                    }]
            }
            css: {
                files: [{
                    expand: true
                    cwd: 'bower_components'
                    src: '<%= assets.css %>'
                    dest: 'build/public/css'
                    }]
            }
            map: {
                files: [{
                    expand: true
                    cwd: 'bower_components'
                    src: 'bootstrap/dist/css/bootstrap.css.map'
                    dest: 'build/public/css'
                    }]
            }
            font: {
                files: [{
                    expand: true
                    cwd: 'bower_components'
                    src: 'bootstrap/dist/fonts/*.*'
                    dest: 'build/public/css'
                    }]
            }
        }
        watch: {
            coffee: {
                files: ['source/coffee/**/*.coffee', 'source/coffee/*.coffee']
                tasks: ['coffee:dev']
            }
            less: {
                files: ['source/less/*.less']
                tasks: ['less:dev']
            }
            view: {
                files: ['source/views/**/*.*']
                tasks: ['copy:views']
            }
            config: {
                files: ['source/config/*.*']
                tasks: ['copy:config']
            }
        }
        concurrent: {
            tasks: ['shell', 'watch']
            options: {
                logConcurrentOutput: true
            }
        }
    }

    require('load-grunt-tasks')(grunt)

    grunt.registerTask 'default', ['less:dev', 'coffee:dev', 'copy:config', 'copy:views', 'concurrent']
    grunt.registerTask 'publish', ['less:dev', 'coffee:dev', 'uglify', 'copy']
    grunt.registerTask 'updatelib', ['copy:bower', 'copy:css', 'copy:map', 'copy:font']