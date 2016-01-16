# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:change', ->
  $('body').dtpicker()

$.fn.dtpicker = ->
  $(this).find('#datetimepicker-start-date,#datetimepicker-due-date').datetimepicker({
    format: 'YYYY-MM-DD HH:MM:SS'
  })
  this