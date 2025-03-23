/** @type {import('tailwindcss').Config} */
export default {
  darkMode: 'class', // Enables dark mode with class-based toggling
  content: [
    './index.html',
    './src/**/*.{vue,js,ts,jsx,tsx}', // Vue and JS/TS files
    './resources/views/**/*.blade.php', // Laravel Blade templates
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
