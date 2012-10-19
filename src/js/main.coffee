# Entry point into the application (when the application 'starts')
# Initialize stuff, including Backbone history and hijacking links
require [ 'app', 'router', 'backbone'], (app, Router, Backbone) ->
    # Make app globally available for debugging
    window.app = app;

    # Define your master router on the application namespace and trigger all
    # navigation from this instance.
    app.router = new Router()

    # Trigger the initial route and enable HTML5 History API support, set the
    # root folder to '/' by default.  Change in app.js.
    Backbone.history.start
        #pushState: true
        root: app.root

    # All navigation that is relative should be passed through the navigate
    # method, to be processed by the router. If the link has a `data-bypass`
    # attribute, bypass the delegation completely.
    $(document).on "click", "a:not([data-bypass])", (evt) ->
        #Get the absolute anchor href.
        href = $(this).attr("href")

        # If the href exists and is a hash route, run it through Backbone.
        if href && href.indexOf("#") == 0
          # Stop the default event to ensure the link will not cause a page 
          # refresh.
          evt.preventDefault()

          # `Backbone.history.navigate` is sufficient for all Routers and will
          # trigger the correct events. The Router's internal `navigate` method
          # calls this anyways.  The fragment is sliced from the root.
          Backbone.history.navigate(href, {trigger: true})


    app.router.navigate('#home', {trigger: true})


    console.log("IN MAIN")

    # Everything for jvkoh for now
    $('#jp-no-solution-wrapper').hide()
    setTitle = (title) ->
      $('#jp-title-text').html(title)
    setSoundCloudLink = (url) ->
      if !url
        $('#soundCloudLink').hide()
      else
        $('#soundCloudLink').show()
        $('#soundCloudLink').html( '<a href="' + url + '"  target="_blank" id="asdf"> <img src="/images/soundcloud.png"/> </a>')
    jPlayerDiv = $("#jquery_jplayer_1")
    jPlayerDiv.jPlayer( {
      ready: () ->
      supplied: 'mp3'
      wmode: 'window'
    })

    playSong = (songUrl, songTitle, soundCloudUrl, dontStartPlaying) ->
      if dontStartPlaying #false  if not passed in
        jPlayerDiv.jPlayer("setMedia", {
          mp3: songUrl
        }).jPlayer()
      else
        jPlayerDiv.jPlayer("setMedia", {
          mp3: songUrl
        }).jPlayer('play')
      setTitle(songTitle)
      setSoundCloudLink(soundCloudUrl)

    $('.playableSong').click((e) ->
      songDiv = $(this)
      songUrl = songDiv.attr('url')
      songTitle = songDiv.attr('title')
      soundCloudUrl = songDiv.attr('soundCloudUrl')
      playSong(songUrl, songTitle, soundCloudUrl)
    )
    playSong('https://s3.amazonaws.com/jvkoh-music/floatintheocean.mp3', 'Float in the Ocean', '', true)

    $('#soundCloudLink').css({
      position: 'relative'
      left: 45
      top: 8
    }).show()

    # Parallax
    p = parallax
    #All the pages in order
    pages = ['home', 'music', 'about']
    pages.forEach((e) ->
      p.add(e, $('#' + e + 'Page'))
    )
    getCurrentPageIndex = () ->
      return pages.indexOf(p.current.key)

    p.home.show()
    # Before using .last either check to see if it's null

    # or set it before hand
    p.last = p.homepage

    numPages = pages.length
    hideArrowKeys = () ->
      $('.arrowKey').show()
      if getCurrentPageIndex() == 0
        $('#leftArrow').hide()
      else if getCurrentPageIndex() == (numPages - 1)
        $('#rightArrow').hide()
    hideArrowKeys()
    goRight = () ->
      # if not at the far right
      if getCurrentPageIndex() < (numPages - 1)
        nextPage = pages[getCurrentPageIndex() + 1]
        #p[nextPage].right()
        $('#' + nextPage).click()
    goLeft = () ->
      # if not at the far left
      if getCurrentPageIndex() > 0
        nextPage = pages[getCurrentPageIndex() - 1]
        $('#' + nextPage).click()

    # Arrow key navigation
    # 37 - left, 38 - top, 39 - right, 40 - bottom
    $(document).keydown((e) ->
      if (e.keyCode == 39)  #right
        goRight()
      else if (e.keyCode == 37)  #left
        goLeft()
    )
    $('#rightArrow').click((e) ->
      goRight()
    )
    $('#leftArrow').click((e) ->
      goLeft()
    )
    # Make tabs active when clicked
    navbarLinks = $(".navButton")
    inTransition = false
    transitionFinished = () ->
      hideArrowKeys()
      inTransition = false
      $('body').removeClass('hideOverflow')

    selectOnClick = (navLink) ->
      navLink.click((e) ->
        if (!inTransition)
          inTransition = true

          # There's some weird flickering going on b/c
          # of parallax, this fixes that
          $('body').addClass('hideOverflow')
          # deselect all others
          navLink.parent().parent().children().removeClass('active')
          # Select this one
          navLink.parent().toggleClass('active')
          # Scroll to the right page
          navTitle = navLink.attr('href').substring(1)
          if (pages.indexOf(navTitle) < getCurrentPageIndex())
            p[navTitle].left(transitionFinished)
          else if (pages.indexOf(navTitle) > getCurrentPageIndex())
            p[navTitle].right(transitionFinished)
          else
            transitionFinished()
          # if same do nothing, already on page
      )

    #for (i = 0, l = navbarLinks.length; i < l; i++) {
    for i in [0 .. navbarLinks.length - 1]
      navbarLink = $(navbarLinks[i])
      navbarLink.attr('id', navbarLink.attr('href').substring(1))
      selectOnClick($(navbarLink))

    # RESIZING STUFF FOR THE FOOTER
    # content is positioned absolutely, which messes with layout
    # Have to set height of contents parent div
    # dynamically to ensure footer is at bottom
    resizePage = () ->
      $('#bodyWrapper').height($($(p.current.page).children()[0]).outerHeight(true))

    $(window).resize(() ->
      resizePage()
    )
    resizePage()
    p.preload = (thisPage) ->
      setTimeout(
        () ->
          $('#bodyWrapper').height($($(thisPage.page).children()[0]).outerHeight(true))
        100
      )

    # Hide no solution warning because it flickers at first
    setTimeout(
      () ->
        $('#jp-no-solution-wrapper').show()
      5000
    )

