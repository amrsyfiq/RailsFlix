# 🎬 RailsFlix

RailsFlix is a **Ruby on Rails API** and **Vue 3 SPA** for managing movies and TV shows. It features **CRUD operations**, **genres & actors management**, **admin authentication**, and a **beautiful UI with Tailwind CSS**. Uses **PostgreSQL** for storage. 🚀

---

## 📌 Features
- Manage Movies & TV Shows
- Associate Genres & Actors
- Admin Authentication (using bcrypt & sessions)
- Beautiful UI with Tailwind CSS & Flowbite components
- Alerts using SweetAlert2

---

## 🛠️ Tech Stack
- **Backend:** Ruby on Rails (API mode), PostgreSQL
- **Frontend:** Vue 3, Vite, Tailwind CSS, Vue Router, Pinia

---

## 🚀 Getting Started
### Prerequisites
- Ruby 3.x & Rails 7.x
- PostgreSQL
- Node.js & npm/yarn

### Backend Setup
```sh
# Clone the repo
git clone https://github.com/yourusername/railsflix.git
cd railsflix/backend

# Install dependencies
bundle install

# Setup the database
rails db:setup

# Start the Rails server
rails s
```

### Frontend Setup
```sh
cd ../frontend

# Install dependencies
npm install  # or yarn install

# Start the development server
npm run dev  # or yarn dev
```

---

## 📌 API Endpoints
| Method | Endpoint            | Description           |
|--------|---------------------|-----------------------|
| GET    | /movies             | List all movies      |
| POST   | /movies             | Create a new movie   |
| GET    | /movies/:id         | Get a single movie   |
| PUT    | /movies/:id         | Update a movie       |
| DELETE | /movies/:id         | Delete a movie       |

More API endpoints available for TV Shows, Genres, Actors, and Admins.

---

## 🎨 UI Components
- **Flowbite for UI**: Pre-built components for better styling
- **SweetAlert2**: Beautiful popups for alerts & confirmations

---

## 📝 License
This project is **MIT Licensed**. Feel free to use and contribute! ✨

---

