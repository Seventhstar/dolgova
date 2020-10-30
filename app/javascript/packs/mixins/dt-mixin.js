const defaults = {}
const DateTimeMixin = {
  options: {},

  setOptions(opts) {
    this.options = Object.assign({}, defaults, opts)
    return this
  },

  formatTime(str) {
    if (str === null) return ''
    return new Date(str).toString().slice(16, 21)
  },

  formatDate() {

  }
}

export default {
  install: function (Vue, opts) {
    const dt = DateTimeMixin.setOptions(opts)
    Vue.prototype.$dt = dt
    Vue.dt = dt
  }
}
