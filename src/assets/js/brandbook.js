/**
 * SumUp brandbook
 *
 * the JS! \o/
 */

var toggle = document.getElementById('toggle-menu'),
    mainNav = document.getElementById('main-nav');

toggle.addEventListener('click', function(event) {
  event.preventDefault();

  toggleClass(toggle, "is-active");
  toggleClass(mainNav, "showing");
});
