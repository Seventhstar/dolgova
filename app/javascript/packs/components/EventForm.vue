<template>
  <div class="modal" id="myModal" v-show="$attrs.value">
    <div class="modal-content">
      <div class="modal-head">Редактирование: "{{eventName}}"</div>
      <div class="modal-body">
        <div class="grid_middle_label_name">Группа
          <v-select :options="event_names" :reduce="v=>v.value" v-model="type_id"></v-select>
          <br></div>
        <div class="actions"><span @click.once="onSaveTarget()" class="btn btn-min btn-success">Сохранить</span><span
          @click="$emit('input', $event.target.value)" class="btn btn_reset mr-2"> Отменить</span></div>
      </div>
    </div>
  </div>
</template>

<script>

  export default {
    name: "EventForm",
    // props: ['showModal'],
    data: function () {
      return {
        eventName: 'eventN1231ame',
        event_names: [{label: 'Доступное время', value: 1}, {label: 'Запись', value: 2}],
        type_id: 0,
      }
    }
  }
</script>

<style scoped>

</style>