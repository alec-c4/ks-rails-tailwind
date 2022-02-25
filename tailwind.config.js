module.exports = {
  darkMode: 'media',
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/components/**/*',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('@tailwindcss/forms'),
    require('tailwindcss-font-inter')({
      importFontFace: true,
      disableUnusedFeatures: true
    }),
    require('@tailwindcss/typography')
  ]
}
