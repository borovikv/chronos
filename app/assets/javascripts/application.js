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

function ajax_put(url, data) {
    return ajax_post({
        url: url,
        data: $.extend({_method: 'PUT'}, data)
    });
}

function ajax_post(options) {

    var defaultOptions = {
        type: 'POST',
        dataType: 'JSON',

        error: function(jqXHR, textStatus, errorThrown) {
            alert(textStatus);
            alert(errorThrown);
        }
    };
    return $.ajax($.extend(defaultOptions, options))
}



$.fn.set_ajax_submit = function(success){
    $(this).find('form').submit(function(e) {
        var valuesToSubmit = $(this).serialize();
        ajax_post({
            url: $(this).attr('action'),
            data: valuesToSubmit,
            dataType: 'script'
        }).success(function(data){
            if (success) {
                success(data)
            }
        });
        return false;
    });
  return this;
};