template = [
  'intro'
  'you'
  'adjective'
  'compound_adjective'
  'expletive'
  'noun'
]

@phraseHistory = []
@isSpecial = false

SPECIAL_CHANCE = 0.10
CUSTOM_CHANCE = 0.30

Array::choose = ->
  this[Math.floor(Math.random() * this.length)]

setupWords = ->
  for k, v of @words
    @words[k] = v.replace /(.+?)\[(\d+)\](\n|$)/g, (s, m1, m2) ->
      Array(parseInt(m2) + 1).join(m1 + '\n')
    .trim().replace(/#/g, '\n').split(/\n/)
  @words.intro = ((if !!w then "#{w}," else w) for w in @words.intro)


getSpecial = ->
  [phrase, img] = @special.choose()
  $('#image').attr(src: img)
  @isSpecial = true
  phrase

getCustom = ->
  @words.custom.choose().replace /\{(.+?)\}/g, (s, m1) ->
    if m1 == 'phrase' then getCombo() else @words[m1].choose()

getCombo = ->
  template.map (type) ->
    @words[type].choose()
  .join(' ')

genPhrase = ->
  roll = Math.random()

  if roll < SPECIAL_CHANCE
    getSpecial()
  else if roll < CUSTOM_CHANCE
    getCustom()
  else
    getCombo()

fixArticles = (s) ->
  s.replace(/\ {2,}/, ' ').trim().replace(/\ba\b ([aeiou])/g, 'an $1')

reset = ->
  @isSpecial = false
  @index = 0
  $('#image-container').css(opacity: 0)

setNewPhrase = ->
  reset()
  @previous = @phrase
  @phrase = fixArticles(genPhrase()).toUpperCase()
  $('#sentence').text(@phrase)
  if isSpecial
    showSpecial()
  @phraseHistory.unshift(@phrase)


showPrevious = ->
  $('#sentence').text(@phraseHistory[++@index])

showSpecial = ->
  $('#new').prop('disabled', true)
  $('#image-container').fadeTo(1000, 1)
  $('#sentence').animate color: '#953255', 400, ->
    $('#sentence').animate color: '#F9ECD1', 400, ->
      setTimeout ->
        $('#new').prop('disabled', '')
      , 400



$ ->
  setupWords()
  setNewPhrase()
  $('#new').click -> setNewPhrase()
  $('#previous-link').click -> showPrevious()
  $('#time').text(lastUpdated)

