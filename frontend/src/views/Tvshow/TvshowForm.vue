<script setup>
import { ref, onMounted, computed, watch } from "vue";
import { useTvshowStore } from "@/stores/tvshows";
import Select from "@/components/Select.vue";
import Swal from "sweetalert2";
import ImageUploader from "@/components/ImageUploader.vue";

const tvshowStore = useTvshowStore();

const props = defineProps({
  data: Object,
  type: String,
});


const emit = defineEmits(["close-modal"]);

const tvshow = ref({
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

// Watch for changes in props.tvshow and update tvshow ref
watch(() => props.data, (newTvshow) => {
  if (newTvshow) {
    tvshow.value = {
      id: newTvshow.id ?? null,
      title: newTvshow.title ?? "",
      release_date: newTvshow.release_date ?? "",
      score: newTvshow.score ?? "",
      status: tvshowStore.statuses?.find(val => val.name == newTvshow.status)?.id ?? null,
      genre_ids: newTvshow.genres?.map((genre) => genre.id) ?? [],
      director_id: newTvshow.director_id ?? null,
      image: newTvshow.image?.file_url ?? null,
      actor_ids: newTvshow.actors?.map((actor) => actor.id) ?? [],
    };
  }
}, { immediate: true });


// Fetch data on mount
onMounted(async () => {
  await tvshowStore.fetchGenres();
  await tvshowStore.fetchPersons();
  await tvshowStore.fetchStatuses();
});

// Filter persons into directors and actors
const directors = computed(() => tvshowStore.persons.filter((p) => p.role === "director"));
const actors = computed(() => tvshowStore.persons.filter((p) => p.role === "actor"));

const submitTvshow = async () => {
  if (tvshow.value.id) {
    await tvshowStore.updateTvshow(tvshow.value.id, tvshow.value);
    Swal.fire("Updated!", "Tvshow updated successfully.", "success");
  } else {
    await tvshowStore.addTvshow(tvshow.value);
    Swal.fire("Success!", "Tvshow added successfully.", "success");
  }
  emit("close-modal");
};

const handleFileUpload = async (event) => {
  
  const selectedFile = event.target.files[0];
  if (selectedFile) {
    const formData = new FormData();
    formData.append('file', selectedFile);
    await tvshowStore.uploadImage(tvshow.value.id, formData);
  }
};
</script>
<template>
  <form @submit.prevent="submitTvshow" class="space-y-4">
    <div class="grid gap-4 mb-4 sm:grid-cols-2">
      <div class="pb-3">
        <ImageUploader :imageUrl="tvshow.image" @change="handleFileUpload" />
      </div>     

      <div class="pb-3">
        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tvshow Title</label>
        <input v-model="tvshow.title" type="text" :disabled="props.type == 'show'" class="bg-white border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required />
      </div>

      <div class="pb-3">
        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Status</label>
        <Select class="mt-1" v-model="tvshow.status" :disabled="props.type == 'show'" :options="tvshowStore.statuses" :get-option-label="option => option.name"
          :reduce="option => option.id" :is-required="tvshow.status"></Select>
      </div>

      <div class="pb-3">
        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Release Date</label>
        <input v-model="tvshow.release_date" :disabled="props.type == 'show'" type="date" class="bg-white border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required />
      </div>

      <!-- Genre Dropdown -->
      <div class="pb-3">
        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Genre</label>
        <Select class="mt-1" v-model="tvshow.genre_ids" :disabled="props.type == 'show'" :options="tvshowStore.genres" :get-option-label="option => option.name"
          :reduce="option => option.id" :is-required="tvshow.genre_ids" multiple></Select>
      </div>

      <!-- Director Dropdown -->
      <div class="pb-3">
        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Director</label>
        <Select class="mt-1" v-model="tvshow.director_id" :disabled="props.type == 'show'" :options="directors" :get-option-label="option => option.name"
          :reduce="option => option.id" :is-required="tvshow.director_id"></Select>
      </div>

      <!-- Actors Multi-Select -->
      <div class="pb-3">
        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Actors</label>
        <Select class="mt-1" v-model="tvshow.actor_ids" :disabled="props.type == 'show'" :options="actors" :get-option-label="option => option.name"
          :reduce="option => option.id" :is-required="tvshow.actor_ids" multiple></Select>
      </div>

      <!-- Score -->
      <div class="pb-3">
        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Score (%)</label>
        <input v-model="tvshow.score" type="number" :disabled="props.type == 'show'" class="bg-white border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required />
      </div>
    </div>

    <div v-if="props.type != 'show'" class="flex flex-row-reverse">
      <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-semibold text-xs uppercase tracking-widest py-2 px-4 rounded-lg">
        {{ tvshow.id ? "Update Tvshow" : "Add Tvshow" }}
      </button>
    </div>
  </form>
</template>
