<script>
  import axios from "axios";
  import log from "./../mixins/log.vue"

  export default {
    name: "rorHTTP",
    mixins: [log],

    urlFromModel(model, url) {
      return url == null ? `${model}s` : url
    },

    sendToServer(context, model, options = {}) {
      axios.defaults.headers.common['X-CSRF-TOKEN'] =
          document.querySelector("meta[name=csrf-token]").content

      let id = options['id']
      let path = this.urlFromModel(model, options['url'])
      let data = {format: 'json'}
      let source = options['data'] != undefined ? options['data'] : context[model]

      data[model] = source
      console.log('id', id)
      if (id !== null && id !== undefined) {
        data['id'] = id
        axios.patch(`/${path}/${id}`, data)
            .then(function (response) {
              context.$emit('input', {update: true, data: response.data})
            }).catch(function (error) {
          log.showError(context, error)
        })
      } else {
        console.log('data', data, 'path', path)
        axios.post(`/${path}`, data)
            .then(function (response) {
              context.$emit('input', {update: false, data: response.data})
            }).catch(function (error) {
          log.showError(context, error)
        })
      }

    },

    ajax(context, url, data) {
      axios.post(`/ajax/${url}`, {format: 'json', data: data})
          .then(function (response) {
            context.$root.$emit('written', {update: false, data: response.data})
            context.$noty.success('Успешно записано')
          }).catch(function (error) {
        log.showError(context, error)
      })
    },

    deleteObject(context, model, id, url = null) {
      let path = this.urlFromModel(model, url)
      axios.defaults.headers.common['X-CSRF-TOKEN'] =
          document.querySelector("meta[name=csrf-token]").content
      if (confirm("Действительно удалить?")) {
        axios.delete(`/${path}`, {params: {id: id, format: 'json'}})
            .then(() => {
              context.$emit('input', {delete: true, id: id})
            })
            .catch(function (error) {
              log.showError(context, error)
            })
      }
    }
  }
</script>

