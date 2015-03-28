module.exports = (grunt)->
    grunt.initConfig {
        assets: grunt.file.readJSON 'source/config/assets.json'

        uglify: {
            options: {
                mangle: {
                    except: ['jQuery', 'angular']
                }
            }
            dist: {
                files: {
                    'build/public/js/libs.min.js': '<%= assets.js %>' 
                    'build/public/js/my.min.js': ['build/public/js/init.js', 'build/public/js/**/*.js', '!build/public/js/{my,libs,impress}*'] 
                }
            }
        }

        cssmin: {
            options: {
                shorthandCompacting: false
                roundingPrecision: -1
            }
            dist: {
                files: {
                    'build/public/css/libs.min.css': '<%= assets.css %>'
                    'build/public/css/my.min.css': ['build/public/css/*.css', '!build/public/css/{libs,my,aboutme}*']
                }
            }
        }

        # ngmin: {
        #     files: {
        #         src: ['build/public/js/all.js']
        #         dest: 'build/public/js/allmin.js'
        #     }
        # }

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

            impress: {
                files: [{
                    expand: true
                    cwd: 'bower_components/impress.js/js'
                    src: ['impress.js']
                    dest: 'build/public/js/'
                    }]
            }

            # map: {
            #     files: [{
            #         expand: true
            #         cwd: 'bower_components'
            #         src: 'bootstrap/dist/css/bootstrap.css.map'
            #         dest: 'build/public/css'
            #         }]
            # }
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
                tasks: ['coffee:dev', 'uglify']
            }
            less: {
                files: ['source/less/*.less']
                tasks: ['less:dev', 'cssmin']
            }
            view: {
                files: ['source/views/**/*.*']
                tasks: ['copy:views']
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

    grunt.registerTask 'default', ['less:dev', 'coffee:dev',  'copy', 'cssmin', 'uglify', 'concurrent']
    grunt.registerTask 'publish', ['less:dev', 'coffee:dev', 'copy', 'uglify', 'cssmin']