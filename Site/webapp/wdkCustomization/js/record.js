/*
  JavaScript code used for all record pages/tabs

*/

jQuery(document).ready(function($) {

  function invokeDataTables(el) {
    // $.fn.wdkDataTable is defined in wdkCommon.js
    $(el).find(".wdk-data-table, .recordTable").wdkDataTable({
      "sScrollY": "600px"
    });
  }

  wdkEvent.subscribe("recordload", invokeDataTables);

});
