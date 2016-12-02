/**
 * SumUp brandbook
 *
 * the JS! \o/
 */

var toggle = document.getElementById('toggle-menu'),
    burgers = toggle.querySelectorAll('.hamburger'),
    mainNav = document.getElementById('main-nav');

toggle.addEventListener('click', function(event) {
  event.preventDefault();

  toggleClass(burgers[0], "is-active");
  toggleClass(mainNav, "showing");
});
