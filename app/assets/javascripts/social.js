(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = 'https://connect.facebook.net/es_LA/sdk.js#xfbml=1&version=v2.11&appId=830165073831075';
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
window.fbAsyncInit = function() {
  FB.init({
    appId      : '830165073831075',
    cookie     : true,
    xfbml      : true,
    version    : 'v2.11'
  });
  FB.api(
    "/620468924766512_1248263245320407",
    function (response) {
      console.log('NOPE');
      console.log(response);
      if (response && !response.error) {
        console.log('YAS');
        console.log(response);
      }
    }
  );
  FB.AppEvents.logPageView();
  checkLoginState();
};