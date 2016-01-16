// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap/dist/js/bootstrap
//= require moment/min/moment.min
//= require eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min

function ajax_put(url, data, success, error) {
    ajax_post(url, $.extend({_method: 'PUT'}, data), success, error);
}

function ajax_post(url, data, success, error) {
    $.ajax({
        url: url,
        type: 'POST',
        data:  data,
        dataType: 'JSON',

        error: function(jqXHR, textStatus, errorThrown) {
            // ToDo: handle error of drop card on group action
            if (error) {
                error(jqXHR, textStatus, errorThrown);
            } else {
                alert(textStatus);
                alert(errorThrown);
            }
        }


    }).success(success);
}



$.fn.set_ajax_submit = function(){
    $(this).find('form').submit(function(e) {
        var valuesToSubmit = $(this).serialize();

        ajax_post($(this).attr('action'), valuesToSubmit, function(data, status){
            alert(JSON.stringify(data))
            console.log("success", data);
        });
        return false; // prevents normal behaviour
    });
  return this;
};