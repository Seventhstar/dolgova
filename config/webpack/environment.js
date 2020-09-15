const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const erb = require('./loaders/erb')
const vue = require('./loaders/vue')

environment.loaders.prepend('erb', erb)
environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
module.exports = environment
