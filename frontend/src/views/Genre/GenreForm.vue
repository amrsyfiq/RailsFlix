<script setup>
import { ref, onMounted, watch } from "vue";
import { useGenreStore } from "@/stores/genres";
import Swal from "sweetalert2";

const genreStore = useGenreStore();

const props = defineProps({
  data: Object,
  type: String,
});

const emit = defineEmits(["close-modal"]);

const genre = ref({
  id: null,
  name: null,
});

// Watch for changes in props.genre and update genre ref
watch(() => props.data, (newGenre) => {
  if (newGenre) {
    genre.value = {
      id: newGenre.id ?? null,
      name: newGenre.name ?? null,
    };
  }
}, { immediate: true });


// Fetch data on mount
onMounted(async () => {
  await genreStore.fetchGenres();
});

const submitGenre = async () => {
  if (genre.value.id) {
    await genreStore.updateGenre(genre.value.id, genre.value);
    Swal.fire("Updated!", "Genre updated successfully.", "success");
  } else {
    await genreStore.addGenre(genre.value);
    Swal.fire("Success!", "Genre added successfully.", "success");
  }
  emit("close-modal");
};
</script>
<template>
  <form @submit.prevent="submitGenre" class="space-y-4">
      <!-- Name -->
      <div class="pb-3">
        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Name</label>
        <input v-model="genre.name" type="text" :disabled="props.type == 'show'" class="bg-white border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required />
      </div>

    <div v-if="props.type != 'show'" class="flex flex-row-reverse">
      <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-semibold text-xs uppercase tracking-widest py-2 px-4 rounded-lg">
        {{ genre.id ? "Update Genre" : "Add Genre" }}
      </button>
    </div>
  </form>
</template>
