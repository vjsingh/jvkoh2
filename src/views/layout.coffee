doctype 5
html ->
  head ->
    # TODO
    #if !isDevelopment
        #script ->
          #window.console = {};
          #window.console.log = () ->

    meta charset:'utf-8'
    meta 'http-equiv':'X-UA-Compatible', content:'IE=edge,chrome=1'
    #meta(name='viewport', content='width=640, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no')
    meta name:'apple-mobile-web-app-capable', content:'yes'

    # TODO: Add description, keywords, robots, author, favicon
    #if isDevelopment
    link rel:"stylesheet", type:'text/css', href:"/css/styles.css"
    link rel:"stylesheet", type:'text/css', href:"/css/bootstrap/bootstrap.css"

    #Application source. 
    script type:"text/javascript", src:"/js/templates.js"
    script 'data-main':"/js/config", type:"text/javascript", src:"/js/libs/require.js"
    #else 
        #script(type='text/css', href="/release/styles.css")
        #script(type='text/javascript', src='/js/libs/require.js')

  body role: "application", ->
    img class: 'arrowKey', id: 'rightArrow', src:'/images/right.png'
    img id: 'leftArrow', class: 'arrowKey', src:'/images/left.png'
    #if browserIs "ie"
    #  javascriptTag "http://html5shiv.googlecode.com/svn/trunk/html5.js"

    #if hasContentFor "templates"
      #yields "templates"

    ###
    nav id: "navigation", class: "navbar", role: "navigation", ->
      div class: "navbar-inner", ->
        div class: "container", ->
          partial "shared/navigation"
    ###

    header id: "header", class: "header", role: "banner", ->
      div class: "container", ->
        h1 ->
          text "Jonathan"
          em "Koh"
        nav ->
          ul ->
            li -> a id: 'home', class: 'navButton', href: '#home', ->
              text 'Home'
              span "Music Highlights"
            li -> a id: 'music', class: 'navButton', href: '#music', ->
              text 'Music'
              span "Everything"
            li -> a id: 'about', class: 'navButton', href: '#about', ->
              text 'About'
              span "My Background"


    div id: 'jplayerBar', ->
      div class: 'container', ->
        div id: 'jquery_jplayer_1', class: 'jp-jplayer'
        text '''
          <div id="jp_container_1" class="jp-audio">
            <div class="jp-type-single">
              <div class="jp-gui jp-interface">
                <ul class="jp-controls">
                  <li><a href="javascript:;" class="jp-play" tabindex="1">play</a></li>
                  <li><a href="javascript:;" class="jp-pause" tabindex="1">pause</a></li>
                  <li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>
                  <li><a href="javascript:;" class="jp-mute" tabindex="1" title="mute">mute</a></li>
                  <li><a href="javascript:;" class="jp-unmute" tabindex="1" title="unmute">unmute</a></li>
                  <li><a href="javascript:;" class="jp-volume-max" tabindex="1" title="max volume">max volume</a></li>
                </ul>
                <div class="jp-progress">
                  <div class="jp-seek-bar">
                    <div class="jp-play-bar"></div>
                  </div>
                </div>
                <div class="jp-volume-bar">
                  <div class="jp-volume-bar-value"></div>
                </div>
                <div class="jp-time-holder">
                  <div class="jp-current-time"></div>
                  <div class="jp-duration"></div>

                  <ul class="jp-toggles">
                    <li><a href="javascript:;" class="jp-repeat" tabindex="1" title="repeat">repeat</a></li>
                    <li><a href="javascript:;" class="jp-repeat-off" tabindex="1" title="repeat off">repeat off</a></li>
                    <li><div id="soundCloudLink"/></li>
                  </ul>
                </div>
              </div>
              <div class="jp-title">
                <ul>
                  <li id="jp-title-text">Cro Magnon Man</li>
                </ul>
              </div>
              <div id="jp-no-solution-wrapper">
                <div class="jp-no-solution">
                  <span>Update Required</span>
                  To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
                </div>
              </div>
            </div>
          </div>
      '''
    section id: "content", role: "main", ->
      div class: "container", ->
        # TODO: Should probable be in a separate file
        div id: 'bodyWrapper', ->
          div id: 'homePage', class: "page container", ->
            div id: 'main', ->
              div class: 'row', ->
                aside class: 'sidebar span3', ->
                  h2 "About"
                  p "I am a 21 year old guitarist/multi-instrumentalist.  I have an affinity for computers and work as a recording engineer/producer.  This is a showcase of some of my work.  I hope you enjoy listening."
                section class: 'span9', ->
                  h2 ->
                    text "Music"
                    small "A selection of past works"
                  ul class: 'project-list', ->
                    for song in @homepageMusic
                      li -> a class: 'playableSong hovergallery', href: '', url: song.url, title: song.title, soundCloudUrl: song.soundCloudUrl, ->
                        img src: song.img, title: song.alt
                        div class: 'songTitle', ->
                          text song.title
          div id: 'musicPage', class: "page container", ->
            div id: 'main', ->
              div class: 'row', ->
                section class: 'span4', ->
                  h2 ->
                    text "2012"
                    small "Fresh off the grill"
                  ul class: 'music-list', ->
                    for song in @music2012
                      li -> a class: 'playableSong', href: '', url: song.url, title: song.title, soundCloudUrl: song.soundCloudUrl, ->
                        div class: 'songTitle', ->
                          text song.title
                section class: 'span4', ->
                  h2 ->
                    text "2011"
                    small "Tracks of Yesteryear"
                section class: 'span4', ->
                  h2 ->
                    text "2010 & Earlier"
                    small "Ye Olde Tracks"
          div id: 'aboutPage', class: "page container", ->
            div id: 'main', ->
              div class: 'page-header', ->
                h1 ->
                  text "About"
                  small "My Background"
              div class: 'row', ->
                aside class: 'sidebar span3', ->
                  figure ->
                    img src: '/images/profile.jpeg', alt:'Me', width: '200px', ->
                section class: 'span9', ->
                  h2 'Recording Engineer and Musician'
                  p 'Currently pursuing a Computer Music and Computer Science double major at Brown University, I spend my time away from classes primarily on my music.  While I am by no means striving to be a solo artist, I love playing music and understand the importance of being able to hold a groove in any sort of ensemble.'
                  p "I am primarily a guitarist, but also a very competent bassist and drummer having played each for 10, 8, and 6 years respectively.  While I don't get to consistently practice drums at school I find that as all the more incentive to practice at home.  At school that time void can be easily filled with work on electronic music composition."
                  p ->
                    text "My experience working in music thus far has been very well rounded.  Whether it's playing jazz guitar for a private party on new years eve, lending a hand around the studio at ", ->
                    a href: 'http://www.wellspringsound.com/', target: '_blank', 'Wellspring Sound'
                    text ", teaching guitar in the Greater Boston Area, or even playing bass for the rock band "
                    a href: 'http://www.myspace.com/whatsyourmoniker', target: '_blank', 'Moniker',
                    text ", I always seem to have a good time."

                  p ->
                    text "In addition to guitar lessons, this coming summer I will be offering my "
                    a href: 'http://jvkoh.tumblr.com/post/2808658080/mini-studio', target: '_blank', 'mini-studio'
                    text "for use recording low-budget demos, primarily aimed at high school students looking to make a portfolio for their college applications.  If you are interested in working in my mini-studio please take a minute to visit my tumblr page as I use it exclusively to post my music, most of which are samples created in said studio."
                  p "If you would like to collaborate with me musically please do not hesitate to send me an email, I'm always looking for more ways to make music."
