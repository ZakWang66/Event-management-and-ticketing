$(document).on "turbolinks:load", ->
  $(window).on 'scroll', ->
    more_events_url = $('.pagination a').attr('href')
    if more_events_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
      $('.pagination').text("Loading more products...")
      $.getScript more_events_url
      return
    return