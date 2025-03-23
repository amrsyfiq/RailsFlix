import { createRouter, createWebHistory } from "vue-router";
import Home from "../views/Home.vue";
import About from "../views/About.vue";
import MovieList from "../views/Movie/MovieList.vue";
import MovieForm from "../views/Movie/MovieForm.vue";
import TvshowList from "../views/Tvshow/TvshowList.vue";
import TvshowForm from "../views/Tvshow/TvshowForm.vue";
import GenreList from "../views/Genre/GenreList.vue";
import GenreForm from "../views/Genre/GenreForm.vue";
import PersonList from "../views/Person/PersonList.vue";
import PersonForm from "../views/Person/PersonForm.vue";

const routes = [
  { path: "/", component: Home },
  { path: '/about', component: About },
  { path: "/movies", component: MovieList },
  { path: "/movies/new", component: MovieForm },
  { path: "/movies/:id/edit", component: MovieForm },
  { path: "/tvshows", component: TvshowList },
  { path: "/tvshows/new", component: TvshowForm },
  { path: "/tvshows/:id/edit", component: TvshowForm },
  { path: "/genres", component: GenreList },
  { path: "/genres/new", component: GenreForm },
  { path: "/genres/:id/edit", component: GenreForm },
  { path: "/persons", component: PersonList },
  { path: "/persons/new", component: PersonForm },
  { path: "/persons/:id/edit", component: PersonForm },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
