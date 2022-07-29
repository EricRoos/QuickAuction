const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  darkMode: 'class',
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/models/app_form_builder.rb',
    './app/components/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/*.{erb,haml,html,slim}',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      'white': '#ffffff',
      accent: {
        primary: '#42765E',
        dark: '#42765E',
      },
      black: '#1b1d1f',
      brand: {
        primary: '#EEB53B',
        dark: '#42765E',
      },
      gray: {
        dark: '#4C4C4C',
        light: '#f3f4f6'
      },
      red: {
        default: '#f87171',
        light: '#F87171',
        dark: '#DC2626'
      },
      green: {
        dark: '#15803D',
        light: '#4ADE80' 
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/line-clamp'),
  ]
}
