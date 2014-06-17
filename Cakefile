exec = require('child_process').exec

task 'watch', 'Watch and compile', ->
    exec 'coffee -o js/ -cw coffeescript/', (err, stdout, stderr) ->
        console.log stdout
