// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require bootstrap
//= require bootstrap-things
//= require jquery
//= require jquery_ujs
//= require data-confirm-modal
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap3
//= require dataTables/extras/TableTools
//= require dataTables/extras/ZeroClipboard.js

$(document).ready( function () {
    $('.searchable_datatable').dataTable( {
        "bRetrieve": true
    } );
} );

//enhance the bootstrap3 accordion
$(function () {
    $('#collapse-init').click(function () {
        $('.panel-collapse').collapse('show');
        $('.panel-title').attr('data-toggle', '');
        $(this).text('Enable accordion behavior');
    });
    $('#accordion').on('show.bs.collapse', function () {
        $('#accordion .in').collapse('hide');
    });
});