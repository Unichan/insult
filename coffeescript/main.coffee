template = [
  'intro'
  'you'
  'adjective'
  'compound_adjective'
  'noun'
]

randChoice = (array) ->
  array[Math.floor(Math.random() * array.length)]

setupWords = ->
  for k, v of @words
    @words[k] = v.trim().split(/\n/)
  @words.intro = ("#{w}," for w in @words.intro)

genPhrase = ->
  template.map (type) ->
    randChoice(@words[type])
  .join(' ')
  .toUpperCase()

setNewPhrase = ->
  $('#sentence').text(genPhrase())


$ ->
  setupWords()
  setNewPhrase(words)
  $('#new').click -> setNewPhrase()
