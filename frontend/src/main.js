import './assets/main.css'
import '@fortawesome/fontawesome-free/css/all.min.css'
import 'vue-select/dist/vue-select.css';
import "flowbite"

import { createApp } from 'vue'
import { createPinia } from 'pinia'
import vSelect from "vue-select"

import App from './App.vue'
import router from './router'

const app = createApp(App)

app.use(createPinia())
app.use(router)
app.component("v-select", vSelect);

app.mount('#app')
