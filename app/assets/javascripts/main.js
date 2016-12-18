$(document).on('turbolinks:load', function(){
    $("#encode").on("ajax:success", function(e, data, status, xhr) {
      var url = getUrlProtocolDomainAndPort() + '/' + data.key;
      $("#result").text(url);
      $("#result").attr("href", url);
      $("#result_container").show();
      $("#error_container").hide();
    }).on("ajax:error", function(e, xhr, status, error) {
      $("#error").text(error);
      $("#error_container").show();
      $("#result_container").hide();
    });

    $("#copy").click(function(){
      copyToClipboard( $("#result").get(0) );
    }
    )
});

function getUrlProtocolDomainAndPort(){
 var arr = window.location.href.split("/");
 return arr[0] + "//" + arr[2]
}
