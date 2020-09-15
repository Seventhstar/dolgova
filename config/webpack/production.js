process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const { VueLoaderPlugin } = require('vue-loader')
const environment = require('./environment')
const vue = require('./loaders/vue')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
module.exports = environment.toWebpackConfig()
