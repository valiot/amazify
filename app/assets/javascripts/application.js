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
//= require social

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
    //FB.login();
    ga('send', 'event', 'Usuarios', 'Visita', 'Sin cuenta', {
      nonInteraction: true
    });
  } else if (response['status'] !== 'connected') {
    $('article.login-request').removeClass('hidden');
    ga('send', 'event', 'Usuarios', 'Visita', 'Sin Facebook', {
      nonInteraction: true
    });
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
          if (!data) {
            $('#btn_user').removeClass('hidden').html('¡Hola '+response.short_name+'!');
            $('.modal-body #facebook', '#user_data').val(response.id);
            $('.modal-body #name', '#user_data').val(response.name);
            $('.modal-body #email', '#user_data').val(response.email);
            $('.modal-header h2 span', '#user_data').html(response.short_name);
            $('#btn_user').trigger('click');
            ga('send', 'event', 'Usuarios', 'Registra', 'Crea cuenta', {
              nonInteraction: true
            });
            hideSubscribe();
          } else if (data.id_facebook) {
            $('#btn_user').removeClass('hidden').html('¡Hola '+response.short_name+'!');
            $('.modal-body #facebook', '#user_data').val(data.id_facebook);
            $('.modal-body #name', '#user_data').val(data.name);
            $('.modal-body #email', '#user_data').val(data.email);
            $('.modal-header h2 span', '#user_data').html(response.short_name);
            $.post(
              '/check_newsletter',
              {
                email	:	$('#email', '.modal-body').val()
              }
            ).done(function(email) {
              if (email !== '') {
                hideSubscribe();
              }
            });
          } else {
            ga('send', 'event', 'Usuarios', 'Error', 'Error crea cuenta: '+data, {
              nonInteraction: true
            });
          }
        });
        $.post(
          '/user_assistance',
          {
            id_facebook : response.id,
            from        : window.location.pathname + window.location.search
          }
        );
      }
    );
  }
}
function hideSubscribe() {
  $('.modal-footer').remove();
  $('.modal').css('padding-top', '100px');
}
$(document).ready(function(){
  function checkEmails(user, mailchimp) {
    console.log(user+'_'+mailchimp);
  }
  function subscribe(name, email) {
    $.post(
      '/subscribe_newsletter',
      {
        name  : name,
        email : email
      }
    ).done(function(data){
      hideSubscribe();
    });
  }
  $('.modal-footer #user_subscribe', '#user_data').click(function(){
    var
    thName  = $('.modal-body #name', '#user_data').val(),
    thEmail = $('.modal-body #email', '#user_data').val();
    subscribe(thName, thEmail);
  });
  $('.to-newsletter').click(function(){
    window.scrollTo(0,document.body.scrollHeight);
  });
  //Modal
  var
  modal				= $('#user_data'),
  btn			 		= $("#btn_user"),
  span		 		= modal.find(".close");
  btn.click(function(){
    ga('send', 'event', 'Usuarios', 'Clic', 'Consulta cuenta');
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
    thFacebook= $('#facebook', '.modal-body').val(),
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
          id_facebook:thFacebook,
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
