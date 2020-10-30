<template>
  <div>
    <div class="write-in">
      <button class="v-btn v-btn--contained v-btn--rounded theme--dark v-size--default red ripple"
              @click="switchShow()">
        <span class="v-btn__content"></span>
        <i class="v-icon notranslate mr-2 material-icons theme--dark" aria-hidden="true">edit </i>
        Записаться
      </button>
    </div>

    <div class="v-overlay" v-show="showWriteInDialog">
      <div class="overlay-container"></div>
    </div>

    <transition name="slide-fade">
      <div id="write-in-modal" v-show="showWriteInDialog">

        <div class="ma-10 write-in-modal-content">
          <div class="write-in-header">
            <div class="write-in-header-content">
              <div class="write-in-title">Записаться на консультацию</div>
            </div>
          </div>

          <div class="start-write-in" v-show="showStart">
            <div class="table-wrap px-8 py-3">
              <div class="row">
                <div class="col">
                  <h3>1. Представьтесь, пожалуйста:</h3>
                  <div class="grid_short_label_name">
                    <label for="name">ФИО:</label>
                    <input type="text" v-model="name" id="name"/>
                    <label for="phone">Номер телефона:</label>
                    <input type="text" v-model="phone" id="phone"/>
                    <label for="email">Е-mail:</label>
                    <input type="text" v-model="email" id="email"/>
                  </div>
                </div>
                <div class="col ml-8">
                  <h3>2. Какая консультация Вам нужна?:</h3>
                  <div class="grid_row">
                    <Switcher v-model="event.individual" :labels="['Индивидуальная', 'Семейная']" width="120"/>
                    <Switcher v-model="event.online" :labels="['Онлайн','Очно']" width="120"/>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col">
                  <h3>3. Выберите дату и время: </h3>
                  <div class="grid_short_label_name">
                    <label for="name">Дата и время:</label>
                    <input type="text" id="date_time" readonly="readonly" :value="date_time"
                           @click="showCalendar = true"/>
                    <label >Комментарий:</label>
                    <textarea v-model="event.comment"/>
                  </div>
                </div>
                <div class="col ml-8">
                </div>
              </div>
              <div class="row flex-end mt-4">
                <div class="add_task v-btn theme--dark v-size--default btn-active ripple" @click.prevent="doWrite()"
                     :disabled="!formValid">Записаться
                </div>
              </div>
            </div>
          </div>

          <div class="end-write-in" v-show="showEnd">
            <div class="row flex-end mt-4">
              <h3>Вы успешно записались</h3>
              <h3>Хотите, чтобы Вам напомнили о сеансе?</h3>

              <div class="add_task v-btn theme--dark v-size--default btn-active ripple" @click.prevent="doClose()">
                Закрыть
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>

    <div class="calendar-popup" v-show="showCalendar">

      <div class="write-in-header">
        <div class="write-in-header-content">
          <div class="write-in-title">Нажмите на время в интересующий день</div>
        </div>
      </div>

      <div class="week-days-grid ma-10">
        <div class="week-day" v-for="(day, index) in weekDays">
          {{day}}
        </div>
        <div class="month-day" v-for="(day, index) in month">
          <span class="day">{{day.day}}</span>
          <span class="atime" v-for="time in day.adates" @click="setTime(time)">{{formatTime(time.time_from)}}</span>
        </div>
      </div>

      <div class="row flex-end ma-10">
        <div class="add_task v-btn theme--dark v-size--default btn-active ripple" @click="showCalendar=false">Выбрать
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import http from "../mixins/rorHTTP";
  import Switcher from "./Switcher";

  export default {
    name: 'WriteIn',
    components: {Switcher},
    mixins: [http],
    data: function () {
      return {
        weekDays: ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс'],
        week: [],
        month: [],
        availableDates: [],
        showWriteInDialog: false,
        showStart: true,
        showEnd: false,
        showCalendar: false,
        isGroup: false,
        isOnline: false,

        formValid: false,

        name: '',
        phone: '',
        email: '',
        event: {
          individual: true,
          online: true,
          date: '',
          time: ''
        }
      }
    },

    computed: {
      date_time() {
        if (this.event.date === '') return 'Нажмите здесь для выбора'
        let date = new Date(this.event.date).toLocaleDateString('ru-RU', {day: 'numeric', month: 'long'})
        let time = this.formatTime(new Date(this.event.time))
        return `${date} в ${time}`
      }
    },

    updated() {
      // console.log('updated')
      let valid = true
      if (this.name.length < 3) valid = false
      if (this.phone.length < 3) valid = false
      if (this.email.length < 3) valid = false

      this.formValid = valid
      // console.log('this.formValid', this.formValid)
    },

    created() {
      this.$root.$on('written', this.written)

      let element = document.getElementById('write-data')
      if (element !== null) {
        this.availableDates = JSON.parse(element.dataset.adates)
      }
      // console.log('this.availableDates', this.availableDates)

      let date = new Date()
      let startOfMonth = new Date(date.getFullYear(), date.getMonth(), 1)
      let nextMonth = new Date(date.getFullYear(), date.getMonth() + 1, 1)
      let startOfWeek = new Date(date.setDate(startOfMonth.getDate() - startOfMonth.getDay() + (startOfMonth.getDay() === 0 ? -6 : 1)))

      this.month.length = 0
      date = startOfWeek
      while (date < nextMonth) {
        for (let i = 0; i < 7; i++) {
          let a = this.availableDates.filter(f => f.date === this.dateToStr(date))
          this.month.push({
            day: date.getDate(),
            month: date.getMonth(),
            year: date.getFullYear(),
            adates: a
          })

          date.setDate(date.getDate() + 1)
          // if (a.length > 0)
          //   console.log('dateToStr(date)', this.dateToStr(date), a)
        }

        let that = this;
        document.addEventListener('keyup', function (event) {
          if (event.key === 'Escape') {
            if (that.showCalendar)
              that.showCalendar = false
            else
              that.showWriteInDialog = false
          }
        });
      }
    },

    mounted() {

    },

    methods: {
      switchShow() {
        this.showWriteInDialog = !this.showWriteInDialog
        if (this.showWriteInDialog) {
          this.showStart = true
          this.showEnd = false
        }
      },

      formatTime(str) {
        return this.$dt.formatTime(str)
      },

      dateToStr(date) {
        return date.toISOString().substring(0, 10)
      },

      setTime(hash) {
        this.event.date = hash.date
        this.event.time = hash.time_from
        this.showCalendar = false
      },

      doClose() {
        this.showWriteInDialog = false
      },

      written(params) {
        console.log('written params', params)
        if (!params.success) {

        }
        this.showStart = false
        this.showEnd = true
      },

      doWrite() {
        http.ajax(this, 'write_in', {
          name: this.name,
          phone: this.phone,
          email: this.email,
          event: this.event

        })
      }
    }
  }
</script>

<style>
  label {
    font-size: 14px;
  }

  .write-in-header {
    background-color: #b8999f;
    padding: 10px;
    border-radius: 4px 4px 0 0;
  }

  .write-in-title {
    text-align: center;
    align-items: center;
    color: white;
    font-size: 24px;
    font-family: roboto, serif;
  }

  .calendar-popup .week-day, .calendar-popup .month-day {
    border: 1px solid #aaa;
    text-align: center;
  }

  .calendar-popup .week-day {
    font-size: 18px;
    padding-bottom: 3px;
  }

  .calendar-popup .week-days-grid {
    align-items: center;
    grid-gap: 0;
  }

  .calendar-popup .month-day {
    height: 70px;
  }

  .atime {
    color: #b8999f;
    margin: 1px;
    padding: 1px 3px;
    background-color: #f0eaee;
    border: 1px solid #cfc0c5;
    border-radius: 3px;
    cursor: pointer;
    float: left;
  }

  .day {
    width: 100%;
    margin-bottom: 2px;
    display: block;
    border-bottom: 1px solid #bbb;
  }
</style>