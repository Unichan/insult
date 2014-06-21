exec = require('child_process').exec

task 'build', 'Compile', ->
  exec 'coffee -o js/ -c coffeescript/', (err, stdout, stderr) ->
    console.log stdout

task 'watch', 'Watch and compile', ->
  exec 'coffee -o js/ -cw coffeescript/', (err, stdout, stderr) ->
    console.log stdout
