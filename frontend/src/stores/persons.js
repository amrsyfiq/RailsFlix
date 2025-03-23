import { defineStore } from "pinia";
import axios from "axios";

export const usePersonStore = defineStore("personStore", {
  state: () => ({
    persons: [],
  }),
  actions: {
    async fetchPersons() {
      const response = await axios.get("http://localhost:3000/persons");
      this.persons = response.data;
    },
    async addPerson(person) {
      await axios.post("http://localhost:3000/persons", person);
      this.fetchPersons();
    },
    async updatePerson(id, updatedPerson) {
      await axios.put(`http://localhost:3000/persons/${id}`, updatedPerson);
      this.fetchPersons();
    },
    async deletePerson(id) {
      await axios.delete(`http://localhost:3000/persons/${id}`);
      this.fetchPersons();
    },
    async fetchRoles() {
      const response = await axios.get("http://localhost:3000/persons/roles");
      this.roles = response.data;
    },
  },
});
