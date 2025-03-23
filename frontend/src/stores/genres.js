import { defineStore } from "pinia";
import axios from "axios";

export const useGenreStore = defineStore("genreStore", {
  state: () => ({
    genres: [],
  }),
  actions: {
    async fetchGenres() {
      const response = await axios.get("http://localhost:3000/genres");
      this.genres = response.data;
    },
    async addGenre(genre) {
      await axios.post("http://localhost:3000/genres", genre);
      this.fetchGenres();
    },
    async updateGenre(id, updatedGenre) {
      await axios.put(`http://localhost:3000/genres/${id}`, updatedGenre);
      this.fetchGenres();
    },
    async deleteGenre(id) {
      await axios.delete(`http://localhost:3000/genres/${id}`);
      this.fetchGenres();
    },
  },
});
