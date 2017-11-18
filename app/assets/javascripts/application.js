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
		$('article.login-request').removeClass('hidden');
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
				).done(function(data) {
					if (data === 'crd') {
						$('#btn_user').removeClass('hidden').html('¡Hola '+response.short_name+'!').trigger('click');
						$('.modal-body #name', '#user_data').val(response.name);
						$('.modal-body #email', '#user_data').val(response.email);
					} else if (data === 'crdE') {
						console.log('Error al intentar crear usuario');
					} else if (data.id_facebook) {
						$('#btn_user').removeClass('hidden').html('¡Hola '+response.short_name+'!')<
						$('.modal-body #name', '#user_data').val(data.name);
						$('.modal-body #email', '#user_data').val(data.email);
					}
					$('.modal-header h2 span', '#user_data').html(response.short_name);
				});
			}
		);
	}
}
$(document).ready(function(){
	//Modal
	var
	modal				= $('#user_data'),
	btn			 		= $("#btn_user"),
	span		 		= modal.find(".close");
	btn.click(function(){
		modal.css('display', 'block');
	});
	span.click(function(){
		modal.css('display', 'none');
	});
	modal.click(function(e){
		if (e.target.className === 'modal') {
			$(this).css('display', 'none');
		}
	});
	$('#update_data').click(function () {
		$('#lb_name', '.modal-body').add('#lb_email', '.modal-body').removeClass('active');
		var
		thVerif		= 0,
		thName 		= $('#name', '.modal-body').val(),
		thEmail		= $('#email', '.modal-body').val(),
		isEmail		=	/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		if (thName === '') {
			$('#lb_name', '.modal-body').addClass('active');
			thVerif++;
		}
		if (thEmail === '' || !isEmail.test(thEmail)) {
			$('#lb_email', '.modal-body').addClass('active');
			thVerif++;
		}
		if (thVerif === 0){
			$.post(
				'update_user',
				{
					name	:	thName,
					email	:	thEmail
				}
			).done(function (data){
				$('#update_data', '.modal-footer').html('Datos actualizados');
				$('#name', '.modal-body').val(data.name);
				$('#email', '.modal-body').val(data.email);
				setTimeout(function(){
					$('#update_data', '.modal-footer').html('Actualizar datos');
				}, 5000);
			});
		}
	});
});