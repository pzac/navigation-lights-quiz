class Quiz
  constructor: (json) ->
    console.log 'starting'
    @json = json
    @setup_callbacks()
    @start()

  start: =>
    @waiting = true
    $.getJSON @json, @play

  play: (data) =>
    @data = data
    $("#next").val("Next (#{@data.length} left)")
    rnd_idx = Math.floor(Math.random() * data.length)
    item = @data[rnd_idx]
    @data.splice(rnd_idx, 1)
    $("#image").attr 'src', "images/#{item.image}"
    $("#solution").html(item.desc).hide()

  setup_callbacks: =>
    $(document).on 'click', '#next', @next

  next: =>
    if @waiting
      @waiting = false
      $("#solution").show()
    else
      @waiting = true
      @play(@data)



$ ->
  quiz = new Quiz '/images.json'
