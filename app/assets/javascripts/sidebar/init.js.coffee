get_sidebar_state = ->
  window.localStorage.getItem('sidebar')

set_sidebar_state = (state) ->
  window.localStorage.setItem('sidebar', state)

$ ->
  sidebar = $('#sidebar-wrapper')
  toggle = $('.js-sidebar-toggle', sidebar)
  logo = $('.sidebar-brand', sidebar)
  page_wrapper = $('#page-content-wrapper')
  header = $('#header')
  project_logotype = $('.project-logotype', sidebar)
  project_settings = $('.project-settings', sidebar)
  titles = $('.js-toggle-title', sidebar)
  settings = $('.settings', sidebar)
  account = $('.account', sidebar)
  timer = $('.timer-wrapper')

  if get_sidebar_state() == 'closed'
    toggle.html('&#x203A;')

    titles.each (index, item) ->
      $(item).css('font-size', '0px')

    sidebar.removeClass('opened').addClass('closed')
    logo.removeClass('opened').addClass('closed')
    project_settings.removeClass('opened').addClass('closed')

    project_logotype.hide()

    settings.css({ bottom: '0', width: '65px' })
    account.hide()

    page_wrapper.css({ margin: '0 0 0 70px' })
    header.css({ left: '65px' })
    timer.css({ left: '65px' })

  else
    toggle.html('&#x2039;')
    sidebar.removeClass('closed').addClass('opened')
    logo.removeClass('closed').addClass('opened')
    project_settings.removeClass('closed').addClass('opened')

    titles.each (index, item) ->
      $(item).css('font-size', '14px')

    project_logotype.show()
    settings.css({ bottom: '65px', width: '250px' })
    account.css({ width: '250px' }).show()

    page_wrapper.css({ margin: '0 0 0 250px' })
    header.css({ left: '250px' })
    timer.css({ left: '250px' })

  $('body').on 'click', '.js-sidebar-toggle', ->
    if sidebar.hasClass('opened')
      toggle.html('&#x203A;')
      sidebar.animate({ width: '65px' })
      page_wrapper.animate({ margin: '0 0 0 70px' })
      header.animate({ left: '65px' })
      timer.animate({ left: '65px' })

      titles.each (index, item) ->
        $(item).animate({ 'font-size': '0px' })

      set_sidebar_state('closed')

      project_logotype.hide()

      settings.css({ bottom: '0', width: '65px' })
      account.hide()

    if sidebar.hasClass('closed')
      toggle.html('&#x2039;')
      sidebar.animate({ width: '250px' })
      page_wrapper.animate({ margin: '0 0 0 250px' })
      header.animate({ left: '250px' })
      timer.animate({ left: '250px' })

      titles.each (index, item) ->
        $(item).animate({ 'font-size': '14px' })

      set_sidebar_state('opened')

      project_logotype.show()

      settings.css({ bottom: '65px', width: '250px' })
      account.css({ width: '250px' }).show()

    sidebar.toggleClass('opened closed')
    logo.toggleClass('opened closed')
    project_settings.toggleClass('opened closed')
