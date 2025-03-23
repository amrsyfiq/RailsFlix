<script setup>
import { ref, onMounted, computed, watch } from "vue";
import { useMovieStore } from "@/stores/movies";
import Select from "@/components/Select.vue";
import Swal from "sweetalert2";
import ImageUploader from "@/components/ImageUploader.vue";

const movieStore = useMovieStore();

const props = defineProps({
  data: Object,
  type: String,
});


const emit = defineEmits(["close-modal"]);

const movie = ref({
  id: null,
  title: null,
  release_date: null,
  score: null,
  status: null,
  genre_ids: [],
  director_id: null,
  actor_ids: [],
  image: null,
});

// Watch for changes in props.movie and update movie ref
watch(() => props.data, (newMovie) => {
  if (newMovie) {
    movie.value = {
      id: newMovie.id ?? null,
      title: newMovie.title ?? "",
      release_date: newMovie.release_date ?? "",
      score: newMovie.score ?? "",
      status: movieStore.statuses?.find(val => val.name == newMovie.status)?.id ?? null,
      genre_ids: newMovie.genres?.map((genre) => genre.id) ?? [],
      director_id: newMovie.director_id ?? null,
      image: newMovie.image?.file_url ?? null,
      actor_ids: newMovie.actors?.map((actor) => actor.id) ?? [],
    };
  }
}, { immediate: true });


// Fetch data on mount
onMounted(async () => {
  await movieStore.fetchGenres();
  await movieStore.fetchPersons();
  await movieStore.fetchStatuses();
});

// Filter persons into directors and actors
const directors = computed(() => movieStore.persons.filter((p) => p.role === "director"));
const actors = computed(() => movieStore.persons.filter((p) => p.role === "actor"));

const submitMovie = async () => {
  if (movie.value.id) {
    await movieStore.updateMovie(movie.value.id, movie.value);
    Swal.fire("Updated!", "Movie updated successfully.", "success");
  } else {
    await movieStore.addMovie(movie.value);
    Swal.fire("Success!", "Movie added successfully.", "success");
  }
  emit("close-modal");
};

const handleFileUpload = async (event) => {
  
  const selectedFile = event.target.files[0];
  if (selectedFile) {
    const formData = new FormData();
    formData.append('file', selectedFile);
    await movieStore.uploadImage(movie.value.id, formData);
  }
};
</script>
<template>
  <form @submit.prevent="submitMovie" class="space-y-4">
    <div class="grid gap-4 mb-4 sm:grid-cols-2">
      <div class="pb-3">
        <ImageUploader :imageUrl="movie.image" @change="handleFileUpload" />
      </div>     

      <div class="pb-3">
        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Movie Title</label>
        <input v-model="movie.title" type="text" :disabled="props.type == 'show'" class="bg-white border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required />
      </div>

      <div class="pb-3">
        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Status</label>
        <Select class="mt-1" v-model="movie.status" :disabled="props.type == 'show'" :options="movieStore.statuses" :get-option-label="option => option.name"
          :reduce="option => option.id" :is-required="movie.status"></Select>
      </div>

      <div class="pb-3">
        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Release Date</label>
        <input v-model="movie.release_date" :disabled="props.type == 'show'" type="date" class="bg-white border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required />
      </div>

      <!-- Genre Dropdown -->
      <div class="pb-3">
        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Genre</label>
        <Select class="mt-1" v-model="movie.genre_ids" :disabled="props.type == 'show'" :options="movieStore.genres" :get-option-label="option => option.name"
          :reduce="option => option.id" :is-required="movie.genre_ids" multiple></Select>
      </div>

      <!-- Director Dropdown -->
      <div class="pb-3">
        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Director</label>
        <Select class="mt-1" v-model="movie.director_id" :disabled="props.type == 'show'" :options="directors" :get-option-label="option => option.name"
          :reduce="option => option.id" :is-required="movie.director_id"></Select>
      </div>

      <!-- Actors Multi-Select -->
      <div class="pb-3">
        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Actors</label>
        <Select class="mt-1" v-model="movie.actor_ids" :disabled="props.type == 'show'" :options="actors" :get-option-label="option => option.name"
          :reduce="option => option.id" :is-required="movie.actor_ids" multiple></Select>
      </div>

      <!-- Score -->
      <div class="pb-3">
        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Score (%)</label>
        <input v-model="movie.score" type="number" :disabled="props.type == 'show'" class="bg-white border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required />
      </div>
    </div>

    <div v-if="props.type != 'show'" class="flex flex-row-reverse">
      <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-semibold text-xs uppercase tracking-widest py-2 px-4 rounded-lg">
        {{ movie.id ? "Update Movie" : "Add Movie" }}
      </button>
    </div>
  </form>
</template>
