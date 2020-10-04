import Vue from 'vue'
import App from './components/schedule.vue'
import vSelect from "vue-select"
// import axios from "axios"

// import VueCtkDateTimePicker from 'vue-ctk-date-time-picker';
// import 'vue-ctk-date-time-picker/dist/vue-ctk-date-time-picker.min.css';
// Vue.component('vue-ctk-date-time-picker', VueCtkDateTimePicker);

import VueNoty from 'vuejs-noty'
Vue.use(VueNoty)

Vue.component("v-select", vSelect);

import { Datetime } from 'vue-datetime'
import 'vue-datetime/dist/vue-datetime.css'
Vue.use(Datetime)

const axios = require('axios').default;


Vue.component('datetime', Datetime);

function showSchedule() {
  const app = new Vue({
    el: '#schedule_app',
    render: h => h(App)
  }).$mount()
  console.log('schedule app', app)
}

console.log('js')

document.addEventListener('turbolinks:load',function() {
//Your code
  console.log('turbolinks:load 2')
});
//
// document.addEventListener('turbolinks:load', () => {
//   showSchedule();
//   console.log('turbolinks:load')
// });

document.addEventListener('DOMContentLoaded', () => {
  showSchedule();
  console.log('DOMContentLoaded')
})
