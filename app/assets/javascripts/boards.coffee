# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
get_card_id = (card) ->
  $(card).attr('data-card-id')

get_card_url = (card, tail) ->
  id = get_card_id(card)
  "/cards/#{id}/#{tail}/"

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
      url = get_card_url(ui.draggable, 'move')
      data = { group_id: $(this).parents('.group').attr('data-group-id')}
      ajax_put(url, data)
  )

  $('.cards').sortable(
    connectWith: 'ul',
    revert: true,
    placeholder: "ui-state-highlight list-group-item"
    update: (event, ui) ->
      data = {}
      $(this).children('.card').each(->
        $this = $(this)
        data[get_card_id($this)] = $this.index()
      )
      ajax_put(get_card_url(ui.item, 'order'), data:data)

  )

  $('#board').droppable(
    accept: '.group',
    scope: 'items',
    drop: (event, ui) ->
      alert('board')
  )

