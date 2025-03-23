import { defineStore } from "pinia";
import axios from "axios";

export const useTvshowStore = defineStore("tvshowStore", {
  state: () => ({
    tvshows: [],
    genres: [],
    persons: [],
  }),
  actions: {
    async fetchTvshows() {
      const response = await axios.get("http://localhost:3000/tvshows");
      this.tvshows = response.data;
    },
    async fetchStatuses() {
      const response = await axios.get("http://localhost:3000/tvshows/statuses");
      this.statuses = response.data;
    },
    async fetchGenres() {
      const response = await axios.get("http://localhost:3000/genres");
      this.genres = response.data;
    },
    async fetchPersons() {
      const response = await axios.get("http://localhost:3000/persons");
      this.persons = response.data;
    },
    async addTvshow(tvshow) {
      await axios.post("http://localhost:3000/tvshows", tvshow);
      this.fetchTvshows();
    },
    async updateTvshow(id, updatedTvshow) {
      await axios.put(`http://localhost:3000/tvshows/${id}`, updatedTvshow);
      this.fetchTvshows();
    },
    async deleteTvshow(id) {
      await axios.delete(`http://localhost:3000/tvshows/${id}`);
      this.fetchTvshows();
    },
    async uploadImage(id, file) {
      const response = await axios.post(`http://localhost:3000/tvshows/${id}/image`, file, {
        headers: { "Content-Type": "multipart/form-data" }
      });
      this.fetchTvshows();
    }
  },
});
