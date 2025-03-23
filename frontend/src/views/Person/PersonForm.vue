<script setup>
import { ref, onMounted, watch } from "vue";
import { usePersonStore } from "@/stores/persons";
import Select from "@/components/Select.vue";
import Swal from "sweetalert2";

const personStore = usePersonStore();

const props = defineProps({
  data: Object,
  type: String,
});

const emit = defineEmits(["close-modal"]);

const person = ref({
  id: null,
  name: null,
  role: null,
});

// Watch for changes in props.person and update person ref
watch(() => props.data, (newPerson) => {
  if (newPerson) {
    person.value = {
      id: newPerson.id ?? null,
      name: newPerson.name ?? null,
      role: personStore.roles?.find(val => val.name == newPerson.role)?.id ?? null,
    };
  }
}, { immediate: true });


// Fetch data on mount
onMounted(async () => {
  await personStore.fetchPersons();
  await personStore.fetchRoles();
});

const submitPerson = async () => {
  if (person.value.id) {
    await personStore.updatePerson(person.value.id, person.value);
    Swal.fire("Updated!", "Person updated successfully.", "success");
  } else {
    await personStore.addPerson(person.value);
    Swal.fire("Success!", "Person added successfully.", "success");
  }
  emit("close-modal");
};
</script>
<template>
  <form @submit.prevent="submitPerson" class="space-y-4">
    <div class="grid gap-4 mb-4 sm:grid-cols-2">
        <!-- Name -->
        <div class="pb-3">
          <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Name</label>
          <input v-model="person.name" type="text" :disabled="props.type == 'show'" class="bg-white border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required />
        </div>

        <!-- Role -->
        <div class="pb-3">
          <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Role</label>
          <Select class="mt-1" v-model="person.role" :disabled="props.type == 'show'" :options="personStore.roles" :get-option-label="option => option.name"
            :reduce="option => option.id" :is-required="person.status"></Select>
        </div>
      </div>

    <div v-if="props.type != 'show'" class="flex flex-row-reverse">
      <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-semibold text-xs uppercase tracking-widest py-2 px-4 rounded-lg">
        {{ person.id ? "Update Person" : "Add Person" }}
      </button>
    </div>
  </form>
</template>
