<script setup>
import {ref} from "vue";

defineProps({
    'options': {
        type: Array,
        default: []
    },

    'isRequired': {
        type: Boolean,
        default: true
    },
});

const select2 = ref(null);
const isSearchFocused = ref(false)

const onFocus = () => {
  isSearchFocused.value = true
}

const onBlur = () => {
  isSearchFocused.value = false
}
</script>

<template>
    <v-select ref="select2" :options="options" :class="['style-chooser', { 'has-focus': isSearchFocused }]" placeholder="Select an option">
        <template #search="{attributes, events}">
            <input
                class="vs__search"
                :required="!isRequired"
                v-bind="attributes"
                v-on="events"
                @focus="onFocus"
                @blur="onBlur"
            />
        </template>
    </v-select>
</template>

<script>
export default {
    name: "Select2",
    inheritAttrs: true,
}
</script>

<style>
/* Common Dropdown Styles */
.style-chooser .vs__dropdown-menu {
    margin-top: 5px;
    padding: 5px;
    border-radius: 0.5rem;
}

.style-chooser .vs__dropdown-option {
    background-color: #FFFFFF;
    color: #111827;
}

/* Hover and Focus Effects */
.style-chooser .vs__dropdown-option:hover,
.style-chooser .vs__dropdown-option:focus {
    border-radius: 0.3rem;
    background-color: #f1f5f9;
    color: #111827;
}

/* Selected Option Styles */
.style-chooser .vs__selected {
    border: none;
    font-size: 0.9rem;
}

/* Dropdown Toggle */
.style-chooser .vs__dropdown-toggle {
    border: 1px solid #D1D5DB;
    color: #111827;
    font-size: 0.875rem;
    border-radius: 0.5rem;
    outline: none;
    box-shadow: 0 0 0 0 transparent;
    width: 100%;
    padding: 0.4rem;
}

/* Focus Effects */
.style-chooser.has-focus .vs__dropdown-toggle {
    border: 2px solid #3B82F6;
}
.dark .style-chooser.has-focus .vs__dropdown-toggle {
    border: 2px solid #3B82F6;
}

/* Light Mode Specific Styles */
.style-chooser .vs__selected-options {
    color: #6b7280; /* gray-500 */
}

.dark .vs__search {
    background: #374151;
}
.dark .vs__clear {
    background: #374151;
}
.dark .vs__open-indicator {
    background: #374151;
}

/* Dark Mode Styles */
.dark .style-chooser {
    --vs-state-disabled-bg: #374151;
}

.dark .style-chooser .vs__dropdown-menu {
    background: #374151;
    border: none;
    color: white;
}

.dark .style-chooser .vs__dropdown-option {
    background-color: #374151;
    color: white;
}

.dark .style-chooser .vs__dropdown-option:hover,
.dark .style-chooser .vs__dropdown-option:focus {
    background-color: #4B5563;
}

.dark .style-chooser .vs__selected-options {
    color: #9ca3af; /* gray-400 */
}

.dark .style-chooser .vs__dropdown-toggle {
    background-color: #374151; /* dark:bg-gray-700 */
    border-color: #4B5563; /* dark:border-gray-600 */
    color: white; /* dark:text-white */
}

.dark .style-chooser .vs__dropdown-toggle::placeholder {
    color: #9CA3AF; /* dark:placeholder-gray-400 */
}

.dark .style-chooser .vs__selected {
    background-color: #49566c;
    color: white;
}

.dark .style-chooser .vs__selected .vs__deselect,
.dark .style-chooser .vs__selected .vs__clear {
    color: white;
    fill: white;
}

.dark .style-chooser .vs__open-indicator,
.dark .style-chooser .vs__clear {
    fill: white;
}
</style>

