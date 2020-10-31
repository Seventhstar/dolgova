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

  },

  dateToStr(date) {
    return date.toISOString().substring(0, 10)
  },

  fillMonth(monthArray, dates = null) {
    let date = new Date()
    let startOfMonth = new Date(date.getFullYear(), date.getMonth(), 1)
    let nextMonth = new Date(date.getFullYear(), date.getMonth() + 1, 1)
    let startOfWeek = new Date(date.setDate(startOfMonth.getDate() - startOfMonth.getDay() + (startOfMonth.getDay() === 0 ? -6 : 1)))

    monthArray.length = 0
    date = startOfWeek
    while (date < nextMonth) {
      for (let i = 0; i < 7; i++) {

        let d = {
          day: date.getDate(),
          month: date.getMonth()+1,
          year: date.getFullYear()
        }

        if (dates !== null) {
          let a = dates.filter(f => f.date === this.dateToStr(date))
          d['adates'] = a
        }

        monthArray.push(d)
        date.setDate(date.getDate() + 1)
      }
    }
  }
}

export default {
  install: function (Vue, opts) {
    const dt = DateTimeMixin.setOptions(opts)
    Vue.prototype.$dt = dt
    Vue.dt = dt
  }
}
