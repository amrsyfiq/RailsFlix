<script setup>
import { onMounted, ref, computed } from "vue";
import { useTvshowStore } from "@/stores/tvshows";
import Swal from "sweetalert2";
import { initFlowbite } from "flowbite";
import moment from "moment";
import TvshowForm from "./TvshowForm.vue";
import Modal from '@/components/Modal.vue';
import BreadCrumb from "@/components/BreadCrumb.vue";

const tvshowStore = useTvshowStore();
const selectedGenres = ref([]);
const selectAll = ref(true);

// Filter tvshows based on selected genres
const filteredTvshows = computed(() => {
  if (selectedGenres.value.length === 0 || selectAll.value) {
    return tvshowStore.tvshows;
  }
  return tvshowStore.tvshows.filter(tvshow =>
    tvshow.genres.some(g => selectedGenres.value.includes(g.id))
  );
});

// Toggle all genres selection
const toggleAllGenres = () => {
  if (selectAll.value) {
    selectedGenres.value = [];
  } else {
    selectedGenres.value = tvshowStore.genres.map(g => g.id);
  }
};

onMounted(() => {
  tvshowStore.fetchTvshows();
  tvshowStore.fetchGenres();
  initFlowbite();
});

const openDropdown = ref(null);

const toggleDropdown = (id) => {
  openDropdown.value = openDropdown.value === id ? null : id;
};

const modal = ref({
  show: false,
  data: null,
  type: null,
});

const initModal = (data, type) => {
  openDropdown.value = null;
  modal.value.show = true;
  modal.value.data = data;
  modal.value.type = type;
};

const deleteTvshow = async (id) => {
  openDropdown.value = null;
  const result = await Swal.fire({
    title: "Are you sure?",
    text: "You won't be able to revert this!",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#d33",
    cancelButtonColor: "#3085d6",
    confirmButtonText: "Yes, delete it!",
  });

  if (result.isConfirmed) {
    await tvshowStore.deleteTvshow(id);
    Swal.fire("Deleted!", "Tvshow has been deleted.", "success");
  }
};
</script>

<template>
  <BreadCrumb menu="Tv Show" hrefMenu="tvshows"/>
  <!-- Start block -->
  <section class="bg-gray-50 dark:bg-gray-900 antialiased">
    <div class="bg-white dark:bg-gray-800 relative shadow-md sm:rounded-lg">
      <div class="flex flex-col md:flex-row items-center justify-between space-y-3 md:space-y-0 md:space-x-4 p-4">
        <div class="w-full md:w-1/2">
          <form class="flex items-center">
            <label for="simple-search" class="sr-only">Search</label>
            <div class="relative w-full">
              <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                <svg aria-hidden="true" class="w-5 h-5 text-gray-500 dark:text-gray-400" fill="currentColor"
                  viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                  <path fill-rule="evenodd"
                    d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
                    clip-rule="evenodd" />
                </svg>
              </div>
              <input type="text" id="simple-search"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                placeholder="Search" required="">
            </div>
          </form>
        </div>
        <div
          class="w-full md:w-auto flex flex-col md:flex-row space-y-2 md:space-y-0 items-stretch md:items-center justify-end md:space-x-3 flex-shrink-0">
          <button @click="initModal([], 'create')"
            class="cursor-pointer flex items-center justify-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-4 py-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
            <i class="fas fa-plus mr-2"></i>
            Add Tvshow
          </button>
          <div class="flex items-center space-x-3 w-full md:w-auto">
            <button id="filterDropdownButton" data-dropdown-toggle="filterDropdown"
              class="cursor-pointer w-full md:w-auto flex items-center justify-center py-2 px-4 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700"
              type="button">
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="h-4 w-4 mr-2 text-gray-400"
                viewbox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd"
                  d="M3 3a1 1 0 011-1h12a1 1 0 011 1v3a1 1 0 01-.293.707L12 11.414V15a1 1 0 01-.293.707l-2 2A1 1 0 018 17v-5.586L3.293 6.707A1 1 0 013 6V3z"
                  clip-rule="evenodd" />
              </svg>
              Filter
              <svg class="-mr-1 ml-1.5 w-5 h-5" fill="currentColor" viewbox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                <path clip-rule="evenodd" fill-rule="evenodd"
                  d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" />
              </svg>
            </button>
            <div id="filterDropdown" class="z-10 hidden w-56 p-3 bg-white rounded-lg shadow dark:bg-gray-700">
              <h6 class="mb-3 text-sm font-medium text-gray-900 dark:text-white">Category</h6>
              <ul class="space-y-2 text-sm" aria-labelledby="filterDropdownButton">
                <li class="flex items-center">
                  <input id="all-genres" type="checkbox" v-model="selectAll" @change="toggleAllGenres"
                    class="w-4 h-4 bg-gray-100 border-gray-300 rounded text-blue-600 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-700 focus:ring-2 dark:bg-gray-600 dark:border-gray-500">
                  <label for="apple" class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-100">
                    All ({{ tvshowStore.tvshows.length }})
                  </label>
                </li>
                <li class="flex items-center" v-for="genre in tvshowStore.genres">
                  <input :id="'genre-' + genre.id" type="checkbox" v-model="selectedGenres" :value="genre.id"
                    class="w-4 h-4 bg-gray-100 border-gray-300 rounded text-blue-600 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-700 focus:ring-2 dark:bg-gray-600 dark:border-gray-500">
                  <label for="fitbit" class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-100">
                    {{ genre.name }} ({{ tvshowStore.tvshows.filter(tvshow => tvshow.genres.some(g => g.id === genre.id)).length }})
                  </label>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div class="overflow-x-auto">
        <table class="w-full text-left text-gray-500 dark:text-gray-400">
          <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
              <th scope="col" class="px-4 py-3">Title</th>
              <th scope="col" class="px-4 py-3">Director</th>
              <th scope="col" class="px-4 py-3">Genres</th>
              <th scope="col" class="px-4 py-3">Status</th>
              <th scope="col" class="px-4 py-3">Release Date</th>
              <th scope="col" class="px-4 py-3">Score</th>
              <th scope="col" class="px-4 py-3">
                <span class="sr-only">Actions</span>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(tvshow, index) in filteredTvshows" class="border-b border-gray-200 dark:border-gray-700">
              <td scope="row" class="px-4 py-3 text-gray-900 dark:text-white flex gap-3 items-center">
                <img :src="tvshow.image?.file_url ? `http://127.0.0.1:3000${tvshow.image.file_url}` : 'http://127.0.0.1:3000/default-placeholder.jpg'" alt="Logo" class="object-cover w-16 h-16" />
                <div class="flex flex-col">
                  <span class="font-medium line-clamp-2">{{ tvshow.title }}</span>
                  <span class="text-sm line-clamp-3">
                    {{ tvshow.actors.map(actor => actor.name).join(', ') }}
                  </span>
                </div>
              </td>
              <td class="px-4 py-3">{{ tvshow.director?.name }}</td>
              <td class="px-4 py-3">
                <span v-for="genre in tvshow.genres" class="rounded bg-red-400 text-white px-2 py-0.5 text-sm mr-1 whitespace-nowrap">{{ genre.name }}</span>
              </td>
              <td class="px-4 py-3"> 
                <span class="rounded bg-emerald-500 text-white px-2 py-0.5 text-sm mr-1">{{ tvshow.status }}</span>
              </td>
              <td class="px-4 py-3">{{ moment(tvshow.release_date).format('DD/MM/YYYY') }}</td>
              <td class="px-4 py-3">{{ tvshow.score }}%</td>
              <td class="px-4 py-3">
                <button @click="toggleDropdown(index)"
                  class="cursor-pointer inline-flex items-center text-sm font-medium hover:bg-gray-100 dark:hover:bg-gray-700 p-1.5 dark:hover-bg-gray-800 text-center text-gray-500 hover:text-gray-800 rounded-lg focus:outline-none dark:text-gray-400 dark:hover:text-gray-100"
                  type="button">
                  <svg class="w-5 h-5" aria-hidden="true" fill="currentColor" viewbox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg">
                    <path
                      d="M6 10a2 2 0 11-4 0 2 2 0 014 0zM12 10a2 2 0 11-4 0 2 2 0 014 0zM16 12a2 2 0 100-4 2 2 0 000 4z" />
                  </svg>
                </button>
                <div v-show="openDropdown === index"
                  class="absolute mt-38 z-10 w-44 bg-white rounded divide-y divide-gray-100 shadow dark:bg-gray-700 dark:divide-gray-600">
                  <ul class="py-1 text-sm">
                    <li>
                      <button type="button" @click="initModal(tvshow, 'edit')"
                        class="cursor-pointer flex w-full items-center py-2 px-4 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white text-gray-700 dark:text-gray-200">
                        <i class="fas fa-edit mr-2"></i>
                        Edit
                      </button>
                    </li>
                    <li>
                      <button type="button" @click="initModal(tvshow, 'show')"
                        class="cursor-pointer flex w-full items-center py-2 px-4 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white text-gray-700 dark:text-gray-200">
                        <i class="fas fa-magnifying-glass mr-2"></i>
                        Preview
                      </button>
                    </li>
                    <li>
                      <button type="button" @click="deleteTvshow(tvshow.id)"
                        class="cursor-pointer flex w-full items-center py-2 px-4 hover:bg-gray-100 dark:hover:bg-gray-600 text-red-500 dark:hover:text-red-400">
                        <i class="fas fa-trash mr-2"></i>
                        Delete
                      </button>
                    </li>
                  </ul>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <nav class="flex flex-col md:flex-row justify-between items-start md:items-center space-y-3 md:space-y-0 p-4"
        aria-label="Table navigation">
        <span class="text-sm font-normal text-gray-500 dark:text-gray-400">
          Showing
          <span class="font-semibold text-gray-900 dark:text-white">1-10</span>
          of
          <span class="font-semibold text-gray-900 dark:text-white">1000</span>
        </span>
        <ul class="inline-flex items-stretch -space-x-px">
          <li>
            <a href="#"
              class="flex items-center justify-center h-full py-1.5 px-3 ml-0 text-gray-500 bg-white rounded-l-lg border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
              <span class="sr-only">Previous</span>
              <svg class="w-5 h-5" aria-hidden="true" fill="currentColor" viewbox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd"
                  d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
                  clip-rule="evenodd" />
              </svg>
            </a>
          </li>
          <li>
            <a href="#"
              class="flex items-center justify-center text-sm py-2 px-3 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">1</a>
          </li>
          <li>
            <a href="#"
              class="flex items-center justify-center text-sm py-2 px-3 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">2</a>
          </li>
          <li>
            <a href="#" aria-current="page"
              class="flex items-center justify-center text-sm z-10 py-2 px-3 leading-tight text-blue-600 bg-blue-50 border border-blue-300 hover:bg-blue-100 hover:text-blue-700 dark:border-gray-700 dark:bg-gray-700 dark:text-white">3</a>
          </li>
          <li>
            <a href="#"
              class="flex items-center justify-center text-sm py-2 px-3 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">...</a>
          </li>
          <li>
            <a href="#"
              class="flex items-center justify-center text-sm py-2 px-3 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">100</a>
          </li>
          <li>
            <a href="#"
              class="flex items-center justify-center h-full py-1.5 px-3 leading-tight text-gray-500 bg-white rounded-r-lg border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
              <span class="sr-only">Next</span>
              <svg class="w-5 h-5" aria-hidden="true" fill="currentColor" viewbox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd"
                  d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                  clip-rule="evenodd" />
              </svg>
            </a>
          </li>
        </ul>
      </nav>
    </div>
  </section>
  <!-- End block -->

  <!-- Modal -->
  <Modal :show="modal.show" @close="modal.show=false">
      <template #title>
          Add Tvshow
      </template>

      <template #content>
        <TvshowForm :data="modal.data" :type="modal.type" @close-modal="modal.show=false"/>
      </template>
  </Modal>
</template>
