# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('body').on 'ajax:complete', '.parse', (e, xhr, result, data)->
    users = JSON.parse(xhr.responseText)
    text = users.join(' ') + ' '
    $('#data_users').val($('#data_users').val() + text)
