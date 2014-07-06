template = [
  'intro'
  'you'
  'adjective'
  'compound_adjective'
  'expletive'
  'noun'
]

@phraseHistory = []

PRESET_CHANCE = 0.02
CUSTOM_CHANCE = 0.30

Array::compact = ->
  (elem for elem in this when elem?)

Array::choose = ->
  this[Math.floor(Math.random() * this.length)]

setupWords = ->
  for k, v of @words
    @words[k] = v.replace /(.+?)\[(\d+)\](\n|$)/g, (s, m1, m2) ->
      Array(parseInt(m2) + 1).join(m1 + '\n')
    .trim().replace(/#/g, '\n').split(/\n/)
  @words.intro = ((if !!w then "#{w}," else w) for w in @words.intro)

getCustom = ->
  @words.custom.choose().replace /\{(.+?)\}/g, (s, m1) ->
    if m1 == 'phrase' then getCombo() else @words[m1].choose()

getCombo = ->
  template.map (type) ->
    @words[type].choose()
  .compact().join(' ')

genPhrase = ->
  roll = Math.random()

  if roll < PRESET_CHANCE
    @words.preset.choose()
  else if roll < CUSTOM_CHANCE
    getCustom()
  else
    getCombo()

fixArticles = (s) ->
  s.replace(/\ {2,}/, ' ').trim().replace(/\ba\b ([aeiou])/g, 'an $1')

setNewPhrase = ->
  @index = 0
  @previous = @phrase
  @phrase = fixArticles(genPhrase()).toUpperCase()
  $('#sentence').text(@phrase)
  @phraseHistory.unshift(@phrase)

showPrevious = ->
  $('#sentence').text(@phraseHistory[++@index])


$ ->
  setupWords()
  setNewPhrase()
  $('#new').click -> setNewPhrase()
  $('#previous-link').click -> showPrevious()
  $('#time').text(lastUpdated)
