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

  $('.card .card-link-to').draggable({
    scope: 'cards',
    revert: 'invalid',
    snap: '.card',
    snapMode: "outer"
    helper: 'clone',
    stack: ".card .card-link-to"

  })

  $('.card').droppable({
    accept: '.card .card-link-to',
    scope: 'cards',
    tolerance: 'intersect',

    drop: (event, ui) ->
      from_card = get_card_id($(ui.draggable).parents('.card'))
      to_card = get_card_id($(this))
      relation = 0

      animate_card = (data, key) ->
        card_id = data[key]

        $card = $("#card-#{card_id}")
        $relatives = $card.find(".card-link-length")

        first = {
          backgroundColor: "#acdd4a",
        }
        second = {
          backgroundColor: $relatives.css('backgroundColor'),
        }

        $relatives.html(parseInt($relatives.html()) + 1);

        $card.animate(first, 1000, ->
          $card.animate(second, 500)
        );

      ajax_post({
          url:'/edges',
          data: {edge: {card_a_id: from_card, card_b_id: to_card, relation: relation}}
      }).success((data) ->
        animate_card(data, 'card_a_id')
        animate_card(data, 'card_b_id')
      )
  })

  $('#board').droppable(
    accept: '.group',
    scope: 'items',
    drop: (event, ui) ->
      alert('board')
  )

