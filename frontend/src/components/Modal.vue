<script setup>
import { computed, onMounted, onUnmounted, watch } from 'vue';

// Define props for the modal
const props = defineProps({
    show: {
        type: Boolean,
        default: false,
    },
    width: {
        type: String,
        default: 'md',
    },
    closeable: {
        type: Boolean,
        default: true,
    },
});

// Emit events for closing
const emit = defineEmits(['close', 'cancel']);

// Watch for changes to the 'show' prop to toggle overflow behavior
watch(
    () => props.show,
    () => {
        if (props.show) {
            document.body.style.overflow = 'hidden';
        } else {
            document.body.style.overflow = null;
        }
    }
);

// Handle closing the modal
const close = () => {
    if (props.closeable) {
        emit('close');
    }
};

// Close on Escape key press
const closeOnEscape = (e) => {
    if (e.key === 'Escape' && props.show) {
        close();
    }
};

// Event listeners for mounting and unmounting
onMounted(() => document.addEventListener('keydown', closeOnEscape));
onUnmounted(() => {
    document.removeEventListener('keydown', closeOnEscape);
    document.body.style.overflow = null;
});

// Define dynamic width classes based on the width prop
const widthClass = computed(() => {
    return {
        full: 'w-full',
        xl: 'w-full md:w-4/5',
        lg: 'w-full md:w-3/5',
        md: 'w-full md:w-2/5',
        sm: 'w-full md:w-1/5',
    }[props.width];
});
</script>

<template>
    <Teleport to="body">
        <Transition leave-active-class="duration-200">
            <div v-show="show" class="fixed inset-0 flex items-center justify-center overflow-y-auto px-4 py-6 sm:px-0 z-50" scroll-region>
                
                <!-- Background Overlay -->
                <Transition
                    enter-active-class="ease-out duration-300"
                    enter-from-class="opacity-0"
                    enter-to-class="opacity-100"
                    leave-active-class="ease-in duration-200"
                    leave-from-class="opacity-100"
                    leave-to-class="opacity-0"
                >
                    <div v-show="show" class="fixed inset-0 transform transition-all" @click="close">
                        <div class="absolute inset-0 bg-gray-500 dark:bg-gray-900 opacity-75" />
                    </div>
                </Transition>

                <!-- Modal Content -->
                <Transition
                    enter-active-class="ease-out duration-300"
                    enter-from-class="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
                    enter-to-class="opacity-100 translate-y-0 sm:scale-100"
                    leave-active-class="ease-in duration-200"
                    leave-from-class="opacity-100 translate-y-0 sm:scale-100"
                    leave-to-class="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
                >
                    <div
                        v-show="show"
                        class="bg-white dark:bg-gray-800 rounded-lg overflow-hidden shadow-xl transform transition-all mx-6"
                        :class="widthClass"
                    >
                        <!-- Modal Header with Title and Close Button -->
                        <div class="flex items-start justify-between p-4 border-b rounded-t dark:border-gray-600 text-xl font-semibold dark:text-gray-300">
                            <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
                                <slot name="title" />
                            </h3>
                            <button type="button" @click="close" class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ml-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white">
                                <i class="fa-solid fa-xmark fa-2xl"></i>
                            </button>
                        </div>

                        <!-- Modal Body Content -->
                        <div class="p-4 sm:p-6 text-sm text-gray-600 dark:text-gray-400 overflow-auto">
                            <slot name="content" />
                        </div>

                        <!-- Modal Footer -->
                        <div class="flex items-center justify-end p-4 sm:pr-6 border-t border-gray-200 rounded-b dark:border-gray-600 gap-2">
                            <slot name="footer" />
                        </div>
                    </div>
                </Transition>
            </div>
        </Transition>
    </Teleport>
</template>
