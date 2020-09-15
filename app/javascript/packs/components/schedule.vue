<template>
  <div>
    <div class="schedule_head">
      <div class="h2">Расписание</div>
      <div class="add_task v-btn theme--dark v-size--default red ripple">Добавить</div>
    </div>
    <ScheduleTabs/>
  </div>
</template>

<script>
  import axios from "axios"
  import ScheduleTabs from "./scheduletabs.vue";

  export default {
    name: "schedule",
    data() {
      return {
        id: null,
        token: '',
        target: null,
        sets_names: [],
        parents: [],
        groups: [],
        count_names: []
      }
    },

    components: {
      ScheduleTabs: ScheduleTabs,
    }

  }
</script>