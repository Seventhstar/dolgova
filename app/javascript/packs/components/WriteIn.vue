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
                  <div class="h3 mt-3">1. Представьтесь, пожалуйста:</div>
                  <div class="grid_middle_label_name ml-3">
                    <label for="name">ФИО:</label>
                    <input type="text" v-model="name" id="name"/>
                    <label for="phone">Номер телефона:</label>
                    <input type="text" v-model="phone" id="phone"/>
                    <label for="email">Е-mail:</label>
                    <input type="text" v-model="email" id="email"/>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col">
                  <div class="h3 mt-6">2. Какая консультация Вам нужна?</div>
                  <div class="row">
                    <div class="col">
                      <div class="grid_row">
                        <Switcher v-model="event.online" :labels="['Очно', 'Онлайн']" width="150"/>
                        <Switcher v-model="event.individual" :labels="['Семейная', 'Индивидуальная']" width="150"/>
                      </div>
                    </div>
                    <div class="col">
                      <div class="grid_short_label_name">
                        <label for="phone" :disabled="!event.online">Связаться по:</label>
                        <v-select v-model="format" :options="formats" :disabled="!event.online"/>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col">
                  <div class="h3 mt-6">3. Выберите дату и время:</div>
                  <div class="grid_middle_label_name  ml-3">
                    <label for="name">Дата и время:</label>
                    <input type="text" id="date_time" readonly="readonly" :value="date_time"
                           @click="showCalendar = true"/>
                    <label>Комментарий:</label>
                    <textarea v-model="event.comment"/>
                  </div>
                </div>
              </div>
              <div class="row flex-end mt-4">
                <span @click="onCancel()" class="btn btn_reset mr-2">Отменить</span>
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
        format: 0,
        formats: [],
        event: {
          individual: true,
          online: false,
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
      let valid = true
      if (this.name.length < 3) valid = false
      if (this.phone.length < 3) valid = false
      if (this.email.length < 3) valid = false

      this.formValid = valid
    },

    created() {
      this.$root.$on('written', this.written)

      let element = document.getElementById('write-data')
      if (element !== null) {
        this.availableDates = JSON.parse(element.dataset.adates)
        this.formats = JSON.parse(element.dataset.formats)
      }
      this.$dt.fillMonth(this.month, this.availableDates)

      let that = this;
      document.addEventListener('keyup', function (event) {
        if (event.key === 'Escape') {
          if (that.showCalendar)
            that.showCalendar = false
          else
            that.showWriteInDialog = false
        }
      });
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


</style>