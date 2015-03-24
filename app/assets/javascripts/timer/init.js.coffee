get_timer = (secs) ->
  hours = Math.floor(secs / (60 * 60))
  hours = "0" + hours  if hours < 10

  divisor_for_minutes = secs % (60 * 60)
  minutes = Math.floor(divisor_for_minutes / 60)
  minutes = "0" + minutes  if minutes < 10

  divisor_for_seconds = divisor_for_minutes % 60
  seconds = Math.ceil(divisor_for_seconds)
  seconds = "0" + seconds  if seconds < 10

  return "#{hours}:#{minutes}:#{seconds}"

@init_js_clock = ->
  $('.js-clock:not(.armed)').addClass('armed').each ->
    clck = $(this)

    amount = clck.data('clock')

    setInterval (->
      clck.text(get_timer(amount += 1))

      return
    ), 1000

$ ->
  init_js_clock()

  $('.js-timers').on 'ajax:success', (evt, response, status, jqXHR) ->
    target = $(evt.target)

    if target.hasClass('js-start') || target.hasClass('js-stop')
      $('.js-timers').html(response)

      init_js_clock()
