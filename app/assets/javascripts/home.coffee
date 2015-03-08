# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('body').on 'change keyup paste', '#data_users', (e)->
    area = $(e.currentTarget)
    text = area.val()
    users = text.split(' ')
    users_clean = $.grep users, (val)->
      val != ""
    count = users_clean.length
    counter = $('#counter')
    counter.text("Count: #{count}")

  $('body').on 'ajax:complete', '.parse', (e, xhr, result, data)->
    users = JSON.parse(xhr.responseText)
    newText = users.join(' ') + ' '
    oldText = $('#data_users').val()
    $('#data_users').val(oldText + newText)
    $('#data_users').trigger 'change'

  $('body').on 'ajax:complete', '.follow', (e, xhr, result, data)->
    alert 'Follow done'