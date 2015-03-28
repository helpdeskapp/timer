@init_filter = ->
  toolbar = $('.js-filter a')

  toolbar.on 'click', ->
    $this = $(this)
    toolbar.removeClass('selected')
    $this.toggleClass('selected')
