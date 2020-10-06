<template>
  <div class="event-list">
    <div :class="'event-row'+[type=='week' ? '-week': '']" v-for="event in events" @dblclick="editEvent(event)">
      <div class="event-list-item">
        <span>{{formatTime(event.time_from)}}</span>
        <span :style="{ 'background-color': '#'+event.color }" class="color-column"></span>
        <span>{{name(event)}}</span>
        <span v-if="type==undefined">{{event.meeting_name}}</span>
        <span>баланс</span>
        <span class="event_icon" v-if="type!=undefined">
          <template v-if="event.online">
            <span class="online"></span>
          </template>
          <template v-else>
            <span class="sofa"></span>
          </template>
        </span>
        <span class="second_row">{{formatTime(event.time_to)}}</span>
        <span :style="{ 'background-color': '#'+event.color }" class="color-column"></span>
        <span class="second_row">{{event.linked_user_phone}}</span>
        <span class="second_row" v-if="type==undefined">{{event.comment}}</span>
        <span class="second_row">{{event.tarif_info}}</span>
      </div>
      <span class="event_icon" v-if="type==undefined">
        <template v-if="event.online">
          <span class="online"></span>
        </template>
        <template v-else>
          <span class="sofa"></span>
        </template>
      </span>
    </div>
  </div>
</template>

<script>
  import EventForm from "./EventForm.vue";

  export default {
    name: "DayEventsList",
    props: ["events", "type"],
    data() {
      return {
        id: null,
        currentEvent: 0,
        showModal: false,
        // events: [],
      }
    },

    created() {
      // console.log('events inside day', this.events)
    },

    methods: {
      name(event) {
        return event.event_type_id != 2 ? 'Доступно для консультаций' : event.linked_user_name
      },

      editEvent(event) {
        this.currentEvent = event
        this.showModal = true
        this.$emit('showModal', {showModal: true, currentEvent: event})
      },

      formatTime(str) {
        return formatTime(str)
      },
    },

    components:
        {EventForm: EventForm}
  }
</script>

<style scoped>

</style>