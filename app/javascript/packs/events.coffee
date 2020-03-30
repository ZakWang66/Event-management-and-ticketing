$ ->
    if $('.pagination').length && $('#events').length
        $(window).scroll ->
            url = $('.pagination .next_page').attr('href')
            if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
                $('.pagination').text("loading more events...")
                $.getScript(url)
        $(window).scroll()