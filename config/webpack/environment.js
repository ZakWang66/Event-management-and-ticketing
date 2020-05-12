const { environment } = require('@rails/webpacker')
const coffee =  require('./loaders/coffee')

const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: ['popper.js', 'default']
  })
)

environment.loaders.prepend('coffee', coffee)
module.exports = environment