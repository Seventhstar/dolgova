<template>
  <div>
    <div class="schedule_head">
      <div class="h2">Расписание</div>
      <div class="add_task v-btn theme--dark v-size--default red ripple" @click="showModal=true">Добавить</div>
    </div>
    <ScheduleTabs/>
    <EventForm v-model="showModal" @update:value="val => showModal = val"/>
  </div>
</template>

<script>

  import axios from "axios"
  import ScheduleTabs from "./scheduletabs.vue";
  import EventForm from "./EventForm.vue";

  export default {
    name: "schedule",
    data() {
      return {
        id: null,
        token: '',
        target: null,
        showModal: false,
        sets_names: [],
        parents: [],
        groups: [],
        count_names: []
      }
    },

    components: {
      ScheduleTabs: ScheduleTabs,
      EventForm: EventForm,
    }

  }
</script>