# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:change', ->

  $('.card').draggable({
    scope: 'items',
    revert: 'invalid',
    connectToSortable: ".cards",
  })

  $('.cards').droppable(
    accept: '.card',
    scope: 'items',
    tolerance: 'intersect',

    drop: ( event, ui ) ->
      id = (ui.draggable).attr('data-card-id')
      group_id = $(this).parents('.group').attr('data-group-id')
      url = "/cards/#{id}/move/?group_id=#{group_id}"

      $.ajax({
        url: url,
        error: ->
          # ToDo: handle error of drop card on group action
          alert('error')
      })
  )

  $('.cards').sortable(
    connectWith: 'ul',
    revert: true,
    placeholder: "ui-state-highlight list-group-item"
  )

  $('#board').droppable(
    accept: '.group',
    scope: 'items',
    drop: (event, ui) ->
      alert('board')
  )

