$(document).ready(function () {
  $(window).scroll(function () {
    var $sidebar = $('.articleNav-sidebar')
    var $sidebarTop = $(window).scrollTop()
    var $sidebarHeight = $(window).height()

    if ($sidebarTop > $sidebarHeight + 230 ){
      $sidebar.addClass('scrolled')
    } else {
      $sidebar.removeClass('scrolled')
    }
  });
});
