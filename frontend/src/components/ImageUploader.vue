
<script setup>
import { ref } from 'vue';

// Props definition
const props = defineProps({
    imageUrl: {
        type: String,
        default: null,
    }
});

const fileInput = ref(null);

// Trigger the file input click event
const triggerFileInput = () => {
    fileInput.value.click();
};
</script>

<template>
    <div class="cursor-pointer text-center">
        <input type="file" ref="fileInput" class="hidden" @change="handleFileChange" accept="image/*" />

        <div v-if="imageUrl" @click="triggerFileInput"
            class="flex justify-center items-center w-32 h-32 rounded-full ring-4 ring-sky-800 dark:ring-gray-300">
            <img :src="imageUrl" alt="Logo" class="object-cover w-full h-full rounded-full" />
        </div>

        <div v-else @click="triggerFileInput"
            class="inline-flex justify-center items-center w-32 h-32 bg-gray-100 text-gray-600 rounded-full dark:bg-gray-600 group-hover:bg-gray-500 group-hover:opacity-30 group-hover:text-white group-hover:shadow-lg">
            <i class="fa fa-upload fa-2xl" aria-hidden="true"></i>
        </div>
    </div>
</template>

<style scoped>
.uploader {
    display: inline-block;
    cursor: pointer;
    text-align: center;
}
</style>