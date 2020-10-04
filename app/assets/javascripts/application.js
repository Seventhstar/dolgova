// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require underscore-min
//= require_self
//= require_tree .

console.log('app js')

document.addEventListener('readystatechange', () => console.log(document.readyState));

document.addEventListener("DOMContentLoaded", () => {
  // Handler when the DOM is fully loaded

  const letters = Array.from(document.querySelectorAll('.v-ripple'))
  letters.forEach((letter) => {
    let timerId;
    letter.addEventListener('mousedown', (e) => {
      clearTimeout(timerId);
      const ripple = e.target.querySelector('.ripple')
      const size = letter.offsetWidth;
      const pos = letter.getBoundingClientRect();
      const x = e.pageX - pos.left - size;
      const y = e.pageY - pos.top - size;
      ripple.style = 'top:' + y + 'px; left:' + x + 'px; width: ' + size * 2 + 'px; height: ' + size * 2 + 'px;';
      ripple.classList.remove('active');
      ripple.classList.remove('start');
      setTimeout(() => {
        ripple.classList.add('start')
        setTimeout(() => {
          ripple.classList.add('active')
        });
      });
    })
    letter.addEventListener('mouseup', (e) => {
      const ripple = e.target.querySelector('.ripple')
      clearTimeout(timerId);
      timerId = setTimeout(() => {
        ripple.classList.remove('active');
        ripple.classList.remove('start');
      }, 500);
    })
  })

});