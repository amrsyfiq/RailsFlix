class GenresController < ApplicationController
    # 🔹 GET /genres (Read All)
    def index
        genres = Genre.all
        render json: genres
    end

    # 🔹 GET /genres/:id (Read One)
    def show
        render json: @genre
    end

    # 🔹 POST /genres (Create)
    def create
        genre = Genre.new(genre_params)
        
        if genre.save
        render json: genre, status: :created
        else
        render json: { errors: genre.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # 🔹 PUT/PATCH /genres/:id (Update)
    def update
        genre = Genre.find(params[:id])

        if genre.update(genre_params)
        render json: genre, status: :ok
        else
        render json: { errors: genre.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # 🔹 DELETE /genres/:id (Delete)
    def destroy
        @genre.destroy
        head :no_content
    end

    private

    # Find genre before running show, update, delete
    def set_genre
      @genre = Genre.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Genre not found" }, status: :not_found
    end
  
    # Allowed parameters
    def genre_params
      params.require(:genre).permit(:name)
    end
end
