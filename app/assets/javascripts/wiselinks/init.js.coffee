@handle_reload_wiselinks = (data) ->
  $('.overlay').remove()

  # call
  init_main()

$(document).ready ->
  window.wiselinks = new Wiselinks($('.js-wiselinks-content'))

  $(document).off('page:loading').on(
    'page:loading'
    (event, $target, render, url) ->
      overlay_block = $('<div class="overlay"><div class="spinner"></div></div>').appendTo('body')
  )

  $(document).off('page:done').on(
    'page:done'
    (event, $target, status, url, data) ->
      handle_reload_wiselinks(data)
  )
