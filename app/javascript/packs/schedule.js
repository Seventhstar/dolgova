import Vue from 'vue'
import App from './components/schedule.vue'
import vSelect from "vue-select"
//import VueNoty from 'vuejs-noty'

Vue.component("v-select", vSelect);
//Vue.use(VueNoty)

function showSchedule() {
  const app = new Vue({
    el: '#schedule_app',
    render: h => h(App)
  }).$mount()
  console.log('schedule app', app)
}

console.log('js')

// document.addEventListener('pageshow turbolinks:load',function() {
// //Your code
//   console.log('turbolinks:load 2')
// });
//
// document.addEventListener('turbolinks:load', () => {
//   showSchedule();
//   console.log('turbolinks:load')
// });

document.addEventListener('DOMContentLoaded', () => {
  showSchedule();
  console.log('DOMContentLoaded')
})

if (document.readyState === "interactive") {
  console.log('document.readyState')
  const event = document.createEvent("Event");
  event.initEvent("turbolinks:load", true, true);
  document.dispatchEvent(event);
}
