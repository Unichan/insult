template = [
  'intro'
  'you'
  'adjective'
  'compound_adjective'
  'expletive'
  'noun'
]

PRESET_CHANCE = 0.04
CUSTOM_CHANCE = 0.12

Array::compact = ->
  (elem for elem in this when elem?)

randChoice = (array) ->
  array[Math.floor(Math.random() * array.length)]

setupWords = ->
  for k, v of @words
    @words[k] = v.replace(/#/g, '\n')
    .replace /(.+?)\[(\d+)\](\n|$)/g, (s, m1, m2) ->
      Array(parseInt(m2) + 1).join(m1 + '\n')
    .trim().split(/\n/)
  @words.intro = ((if !!w then "#{w}," else w) for w in @words.intro)

getCustom = ->
  randChoice(@words.custom).replace /\{(.+?)\}/g, (s, m1) ->
    if m1 == 'phrase' then getCombo() else randChoice(@words[m1])



getCombo = ->
  template.map (type) ->
    randChoice(@words[type])
  .compact().join(' ')

genPhrase = ->
  roll = Math.random()

  if roll < PRESET_CHANCE
    randChoice(@words.preset)
  else if roll < CUSTOM_CHANCE
    getCustom()
  else
    getCombo()

setNewPhrase = ->
  $('#sentence').text(genPhrase().toUpperCase())


$ ->
  setupWords()
  setNewPhrase()
  $('#new').click -> setNewPhrase()
  $('#time').text(lastUpdated)
