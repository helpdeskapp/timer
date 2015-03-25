@init_input_autofocus = ->
  $('.js-focused-input').focus()

@init_timepicker = ->
  $(".js-timepicker").datepicker
    format: "dd-mm-yyyy"
    weekStart: 1
    language: 'ru'
    autoclose: true
    todayHighlight: true
