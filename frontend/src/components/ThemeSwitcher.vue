<script setup>
import { ref, onMounted, reactive } from 'vue';

const preferDark = window.matchMedia('(prefers-color-scheme: dark)').matches

const prefer = reactive({
    color: localStorage.getItem('color-theme') ?? (preferDark ? 'dark' : 'light')
})

const theme = reactive({
    dark: prefer.color === 'dark'
})

const colorThemeStorage = color => {
    if (localStorage.getItem('color-theme') === null && color === undefined) {
        color = prefer.color
    }

    if (color) {
        localStorage.setItem('color-theme', color)
        theme.dark = color === 'dark'
    }

    return localStorage.getItem('color-theme');
}

const themeDark = () => {
    const colorSelection = ['dark', 'light'];

    const colorChoose = colorSelection.filter(color => color !== colorThemeStorage()).shift()
    document.documentElement.classList.remove(colorThemeStorage());
    document.documentElement.classList.add(colorChoose);
    colorThemeStorage(colorChoose);
}

onMounted(() => {
    if (theme.dark) document.documentElement.classList.remove('light');
    document.documentElement.classList.add(colorThemeStorage());
})
</script>
<template>
    <div class="flex-initial sm:mt-2 sm:mr-2">
        <button id="theme-toggle" type="button" @click="themeDark"
            class="cursor-pointer w-8 h-8 flex items-center my-auto sm:hidden bg-gradient-to-r from-orange-500 to-yellow-400 hover:bg-gray-200 text-white dark:bg-gradient-to-r dark:from-gray-700 dark:to-gray-600 dark:hover:bg-gray-700 focus:outline-none rounded-full text-sm p-2">
            <svg v-if="theme.dark" id="theme-toggle-dark-icon" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg">
                <path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"></path>
            </svg>
            <svg v-else id="theme-toggle-light-icon" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg">
                <path
                    d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z"
                    fill-rule="evenodd" clip-rule="evenodd"></path>
            </svg>
        </button>
        <label class="cursor-pointer hidden sm:inline-flex items-center relative">
            <input class="peer hidden" id="toggle" type="checkbox" @click="themeDark" v-model="theme.dark" />
            <div
                class="relative w-[90px] h-[40px] bg-gray-100 peer-checked:bg-zinc-500 rounded-full 
                after:absolute after:content-[''] after:w-[30px] after:h-[30px] 
                after:bg-gradient-to-r after:from-orange-500 after:to-yellow-400 
                peer-checked:after:bg-gradient-to-r peer-checked:after:from-zinc-900 peer-checked:after:to-zinc-900 
                after:rounded-full after:top-[5px] after:left-[5px] 
                active:after:w-[50px] peer-checked:after:left-[85px] peer-checked:after:translate-x-[-100%] 
                shadow-inner duration-300 after:duration-300 after:shadow-inner">
            </div>
            <svg height="0" width="100" viewBox="0 0 24 24" data-name="Layer 1" id="Layer_1"
                xmlns="http://www.w3.org/2000/svg"
                class="fill-white peer-checked:opacity-60 absolute w-4 h-4 left-[13px]">
                <path
                    d="M12,17c-2.76,0-5-2.24-5-5s2.24-5,5-5,5,2.24,5,5-2.24,5-5,5ZM13,0h-2V5h2V0Zm0,19h-2v5h2v-5ZM5,11H0v2H5v-2Zm19,0h-5v2h5v-2Zm-2.81-6.78l-1.41-1.41-3.54,3.54,1.41,1.41,3.54-3.54ZM7.76,17.66l-1.41-1.41-3.54,3.54,1.41,1.41,3.54-3.54Zm0-11.31l-3.54-3.54-1.41,1.41,3.54,3.54,1.41-1.41Zm13.44,13.44l-3.54-3.54-1.41,1.41,3.54,3.54,1.41-1.41Z">
                </path>
            </svg>
            <svg height="512" width="512" viewBox="0 0 24 24" data-name="Layer 1" id="Layer_1"
                xmlns="http://www.w3.org/2000/svg"
                class="fill-black opacity-60 peer-checked:opacity-70 peer-checked:fill-white absolute w-4 h-4 right-[13px]">
                <path
                    d="M12.009,24A12.067,12.067,0,0,1,.075,10.725,12.121,12.121,0,0,1,10.1.152a13,13,0,0,1,5.03.206,2.5,2.5,0,0,1,1.8,1.8,2.47,2.47,0,0,1-.7,2.425c-4.559,4.168-4.165,10.645.807,14.412h0a2.5,2.5,0,0,1-.7,4.319A13.875,13.875,0,0,1,12.009,24Zm.074-22a10.776,10.776,0,0,0-1.675.127,10.1,10.1,0,0,0-8.344,8.8A9.928,9.928,0,0,0,4.581,18.7a10.473,10.473,0,0,0,11.093,2.734.5.5,0,0,0,.138-.856h0C9.883,16.1,9.417,8.087,14.865,3.124a.459.459,0,0,0,.127-.465.491.491,0,0,0-.356-.362A10.68,10.68,0,0,0,12.083,2ZM20.5,12a1,1,0,0,1-.97-.757l-.358-1.43L17.74,9.428a1,1,0,0,1,.035-1.94l1.4-.325.351-1.406a1,1,0,0,1,1.94,0l.355,1.418,1.418.355a1,1,0,0,1,0,1.94l-1.418.355-.355,1.418A1,1,0,0,1,20.5,12ZM16,14a1,1,0,0,0,2,0A1,1,0,0,0,16,14Zm6,4a1,1,0,0,0,2,0A1,1,0,0,0,22,18Z">
                </path>
            </svg>
        </label>

    </div>
</template>

<script>

export default {
    setup() {
        return {
        }
    },
}
</script>

<style></style>
