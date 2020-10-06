<template>
  <div>
    <div class="schedule_head">
      <div class="h2">Расписание</div>
      <div class="add_task v-btn theme--dark v-size--default btn-active ripple" @click="onAdd()">Добавить</div>
    </div>
    <ScheduleTabs v-model="currentTab" @switchTab="onSwitchTab($event)"/>
    <EventForm v-model="currentEvent" @input="onInput($event)" v-show="showModal"/>

    <div class="event-list-container" v-show="currentTab === 0">
      <DayEventsList :events="grouped[today]" @showModal="onShowModal($event)"/>
    </div>
    <div class="event-list-container" v-show="currentTab === 1">
      <DayEventsList :events="grouped[tomorrow]" @showModal="onShowModal($event)"/>
    </div>
    <div class="event-list-container" v-show="currentTab === 2">
      <div class="week-days-grid">
        <div class="week-day" v-for="day, index in week">
          <div :class="{ 'today': day===today, 'schedule-date': true }">
            {{parseInt(day.substring(8, 10))}}, {{weekDays[index]}}
          </div>
          <DayEventsList :events="grouped[day]" @showModal="onShowModal($event)" type="week"/>
        </div>
      </div>
    </div>
    <div class="event-list-container" v-show="currentTab === 3">
      <div class="week-days-grid">
        <div class="week-day" v-for="day, index in week">
          <div :class="{ 'today': day===today, 'schedule-date': true }">
            {{weekDays[index]}}
          </div>
        </div>
      </div>
    </div>


  </div>
</template>

<script>

  // import axios from "axios"
  import ScheduleTabs from "./ScheduleTabs.vue";
  import DayEventsList from "./DayEventsList.vue";
  import EventForm from "./EventForm.vue";

  export default {
    name: "Schedule",
    data() {
      return {
        id: null,

        today: '',
        tomorrow: '',
        week: [],
        weekDays: ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс'],

        token: '',
        target: null,
        showModal: false,
        currentEvent: {},
        currentTab: 0,
        sets_names: [],
        parents: [],
        groups: [],
        events: [],
        count_names: [],
        tabsValues: [],
        grouped: [],
        groupNames: []
      }
    },

    created() {
      let element = document.getElementById('event-data')
      if (element !== null) {
        this.events = JSON.parse(element.dataset.events)
      }
      this.updateGroups()

      let date = new Date()
      this.today = this.dateToStr(date)
      date.setDate(date.getDate() + 1)
      this.tomorrow = this.dateToStr(date)
      date = new Date()
      let startOfWeek = new Date(date.setDate(date.getDate() - date.getDay() + (date.getDay() === 0 ? -6 : 1)))

      this.tabsValues.push(this.today)
      this.tabsValues.push(this.tomorrow)
      this.week.length = 0

      this.week.push(this.dateToStr(startOfWeek))
      date = startOfWeek
      for (let i = 0; i < 6; i++) {
        date.setDate(date.getDate() + 1)
        this.week.push(this.dateToStr(date))
      }

      //console.log('week', startOfWeek, this.week, 'today', this.today)
      this.tabsValues.push(this.dateToStr(date))
      this.tabsValues.push(this.dateToStr(date))
    },

    methods: {
      onInput(e) {
        this.showModal = false
        if (e === undefined) return
        if (!e.update) {
          this.events.push(e.data)
        } else {
          let id = e.data.id
          let forUpdate = this.events.filter(e => e.id === id)
          if (forUpdate.length > 0) {
            let i = this.events.indexOf(forUpdate[0])
            this.$set(this.events, i, e.data)
          }

        }
        this.updateGroups()
        console.log('onInput', e)
      },

      onAdd() {
        this.showModal = true
        this.currentEvent = null
      },

      onShowModal(event) {
        this.showModal = event.showModal
        this.currentEvent = event.currentEvent
      },


      updateGroups(groupName = 'date') {
        // this.checkGroupName(groupName)
        this.grouped = _.groupBy(this.events, 'date')
        this.groupHeaders = Object.keys(this.grouped)

        for (let i = 0; i < this.groupHeaders.length; ++i) {
          let arr = this.grouped[this.groupHeaders[i]]
          if (arr !== undefined)
            this.$set(this.grouped, this.groupHeaders[i], this.sort(arr))
        }
        console.log('this.grouped', this.grouped)
      },

      sort(arr) {
        return arr.sort((a, b) =>
           (a['time_from'] > b['time_from']) ? 1 : ((b['time_from'] > a['time_from']) ? -1 : 0)
        )
      },

      onSwitchTab(tab) {
        this.currentTab = tab
      },

      dateToStr(date) {
        return date.toISOString().substring(0, 10)
      }

    },

    components: {
      DayEventsList: DayEventsList,
      ScheduleTabs: ScheduleTabs,
      EventForm: EventForm,
    }

  }
</script>