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
//= require jquery_ujs
//= require amazify.min
//= require turbolinks

$.fn.scrollPosReaload = function(){
  if (localStorage) {
    var posReader = localStorage["posStorage"];
    if (posReader) {
      $(window).scrollTop(posReader);
      localStorage.removeItem("posStorage");
    }
    $(this).click(function(e) {
      localStorage["posStorage"] = $(window).scrollTop();
    });
    return true;
  }
  return false;
}

function checkLoginState() {
	FB.getLoginStatus(function(response) {
		statusChangeCallback(response);
	});
}
function statusChangeCallback (response) {
	console.log(response['status']);
	if (response['status'] === 'not_authorized') {
		FB.login();
	} else if (response['status'] !== 'connected') {
		$('article.login-request').toggle();
	} else if (response['status'] === 'connected') {
		$('article.login-request').addClass('hidden');
		FB.api(
			'/me',
			'GET',
			{"fields":"id,name,email,short_name"},
			function(response) {
				$.post(
					'/registra_face',
					{
						id_facebook	:	response.id,
						name				:	response.name,
						email				:	response.email
					}
				).always(function(data){
					console.log(data);
				});
			}
		);
	}
}
checkLoginState();
$(document).on('turbolinks:load',function(){
  //FB check status
	$('article.login-request').toggle();
});