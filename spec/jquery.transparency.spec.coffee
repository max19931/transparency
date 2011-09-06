# fake browser window
global.jsdom  = require 'jsdom'
global.window = jsdom.jsdom().createWindow()
global.jQuery = require "jquery"

# jsdom.jQueryify window, "jquery.js", () ->
#   window.jQuery('body')

require "../jquery.transparency.coffee"

wrap = (html) ->
  jQuery("<div>#{html}</div>")

describe "Transparency", ->

  it "should assing data values to template", ->
    template = wrap(
     '<div class="container">
        <div class="greeting"></div>
        <div class="name"></div>
      </div>')
    template.appendTo('body')

    data =
      greeting: 'Hello '
      name:     'World!'

    result = wrap(
      '<div class="container">
        <div class="greeting">Hello </div>
        <div class="name">World!</div>
      </div>')

    expect(template.render(data).html()).toEqual(result.html())

  it "should handle nested templates", ->
    template = jQuery(
     '<div class="container">
        <div class="greeting">
          <span class="name"></span>
        </div>
      </div>')

    data =
      greeting: 'Hello '
      name:     'World!'

    result = jQuery(
      '<div class="container">
        <div class="greeting">Hello 
          <span class="name">World!</span>
        </div>
      </div>')

    expect(template.render(data).html()).toEqual(result.html())

  it "should handle attribute assignment", ->
    template = jQuery(
     '<div class="container">
        <a class="greeting" href="#"></a>
      </div>')

    data =
      greeting:         'Hello World'
      'greeting@href':  'http://world'

    result = jQuery(
      '<div class="container">
        <a class="greeting" href="http://world">Hello World</a>
      </div>')

    expect(template.render(data).html()).toEqual(result.html())

  it "should handle list of objects", ->
    template = jQuery(
     '<div>
       <div class="container">
          <div class="comment">
            <span class="name"></span>
            <span class="text"></span>
          </div>
        </div>
      </div>')

    data = [ { 
        name:    'John'
        text: 'That rules' }, { 
        name:    'Arnold'
        text: 'Great post!'}
      ]

    result = jQuery(
     '<div>
       <div class="container">
          <div class="comment">
            <span class="name">John</span>
            <span class="text">That rules</span>
          </div>
          <div class="comment">
            <span class="name">Arnold</span>
            <span class="text">Great post!</span>
          </div>
        </div>
      </div>')

    expect(result.html()).toEqual(template.find('.container').render(data).html())

  # it "should handle nested objects", ->
  #   template = jQuery(
  #    '<div class="container">
  #       <h1 class="title"></h>
  #       <p class="post"></p>
  #       <div class="comments">
  #         <div>
  #           <span class="name"></span>
  #           <span class="comment"></span>
  #         </div>
  #       </div>
  #     </div>')

  #   data =
  #     title:    'Hello World'
  #     post:     'Hi there it is me'
  #     comments: [ { 
  #         name:    'John'
  #         comment: 'That rules' }, { 
  #         name:    'Arnold'
  #         comment: 'Great post!'}
  #     ]

  #   result = jQuery(
  #    '<div class="container">
  #       <h1 class="title">Hello World</h>
  #       <p class="post">Hi there it is me</p>
  #       <div class="comments">
  #         <div>
  #           <span class="name">John</span>
  #           <span class="comment">That rules</span>
  #         </div>
  #         <div>
  #           <span class="name">Arnold</span>
  #           <span class="comment">Great post!</span>
  #         </div>
  #       </div>
  #     </div>')

  #   expect(template.render(data).html()).toEqual(result.html())