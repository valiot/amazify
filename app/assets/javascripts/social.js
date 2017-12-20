(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = 'https://connect.facebook.net/es_LA/sdk.js#xfbml=1&version=v2.11&appId=830165073831075';
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
window.twttr = (function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0],
    t = window.twttr || {};
  if (d.getElementById(id)) return t;
  js = d.createElement(s);
  js.id = id;
  js.src = "https://platform.twitter.com/widgets.js";
  fjs.parentNode.insertBefore(js, fjs);
  t._e = [];
  t.ready = function(f) {
    t._e.push(f);
  };
  return t;
}(document, "script", "twitter-wjs"));
(function($) {
  var fbRoot;
  function saveFacebookRoot() {
    if ($('#fb-root').length) {
      fbRoot = $('#fb-root').detach();
    }
  };
  function restoreFacebookRoot() {
    if (fbRoot != null) {
      if ($('#fb-root').length) {
        $('#fb-root').replaceWith(fbRoot);
      } else {
        $('body').append(fbRoot);
      }
    }
    if (typeof FB !== "undefined" && FB !== null) { // Instance of FacebookSDK
      FB.XFBML.parse();
      FB.AppEvents.logPageView();
      checkLoginState();
    }
    window.twttr = (function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0],
        t = window.twttr || {};
      if (d.getElementById(id)) return t;
      js = d.createElement(s);
      js.id = id;
      js.src = "https://platform.twitter.com/widgets.js";
      fjs.parentNode.insertBefore(js, fjs);
      t._e = [];
      t.ready = function(f) {
        t._e.push(f);
      };
      return t;
    }(document, "script", "twitter-wjs"));
  };
  document.addEventListener('turbolinks:request-start', saveFacebookRoot)
  document.addEventListener('turbolinks:load', restoreFacebookRoot)
}(jQuery));
window.fbAsyncInit = function() {
  FB.init({
    appId      : '830165073831075',
    cookie     : true,
    xfbml      : true,
    version    : 'v2.11'
  });
  FB.AppEvents.logPageView();
  checkLoginState();
};