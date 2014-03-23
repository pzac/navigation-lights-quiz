class Quiz
  constructor: (json) ->
    @json = json
    @setup_callbacks()
    @start()

  start: =>
    @waiting = true
    $.getJSON @json, @play

  play: (data) =>
    @data = data
    $("#next").val("Solution")
    rnd_idx = Math.floor(Math.random() * data.length)
    item = @data[rnd_idx]
    @data.splice(rnd_idx, 1)
    $("#image").attr 'src', "images/#{item.image}"
    $("#solution").html(item.desc).hide()

  setup_callbacks: =>
    $(document).on 'click', '#next', @next
    $(document).on 'keydown', @next

  next: =>
    if @waiting
      @waiting = false
      $("#next").val("Next (#{@data.length} left)")
      $("#solution").show()
    else
      @waiting = true
      @play(@data)



$ ->
  quiz = new Quiz '/images.json'
