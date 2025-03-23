import { defineStore } from "pinia";
import axios from "axios";

export const useMovieStore = defineStore("movieStore", {
  state: () => ({
    movies: [],
    genres: [],
    persons: [],
  }),
  actions: {
    async fetchMovies() {
      const response = await axios.get("http://localhost:3000/movies");
      this.movies = response.data;
    },
    async fetchStatuses() {
      const response = await axios.get("http://localhost:3000/movies/statuses");
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
    async addMovie(movie) {
      await axios.post("http://localhost:3000/movies", movie);
      this.fetchMovies();
    },
    async updateMovie(id, updatedMovie) {
      await axios.put(`http://localhost:3000/movies/${id}`, updatedMovie);
      this.fetchMovies();
    },
    async deleteMovie(id) {
      await axios.delete(`http://localhost:3000/movies/${id}`);
      this.fetchMovies();
    },
    async uploadImage(id, file) {
      const response = await axios.post(`http://localhost:3000/movies/${id}/image`, file, {
        headers: { "Content-Type": "multipart/form-data" }
      });
      this.fetchMovies();
    }
  },
});
