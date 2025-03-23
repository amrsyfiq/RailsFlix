class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :update, :destroy]

  # 🔹 GET /movies (Read All)
  def index
    movies = Movie.includes(:genres, :actors, :director, :image).all
    render json: movies, include: [:genres, :actors, :director, :image]
  end

  # 🔹 GET /movies/:id (Read One)
  def show
    render json: @movie, include: [:genres, :director, :image]
  end

  # 🔹 POST /movies (Create)
  def create
    movie = Movie.new(movie_params)
    
    if movie.save
      movie.genres << Genre.where(id: params[:genre_ids]) # Assign multiple genres
      movie.actors << Person.where(id: params[:actor_ids]) # Assign multiple actors
      render json: movie, status: :created
    else
      render json: { errors: movie.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # 🔹 PUT/PATCH /movies/:id (Update)
  def update
    movie = Movie.find(params[:id])

    if movie.update(movie_params)
      movie.genres = Genre.where(id: params[:genre_ids])
      movie.actors = Person.where(id: params[:actor_ids])
      render json: movie, status: :ok
    else
      render json: { errors: movie.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # 🔹 DELETE /movies/:id (Delete)
  def destroy
    @movie.destroy
    head :no_content
  end

  def statuses
    render json: Movie.statuses_list
  end

  def image
    movie = Movie.find(params[:id])

    # Validate image upload
    if params[:file].blank?
      return render json: { error: 'File is required' }, status: :unprocessable_entity
    end

    Rails.logger.debug "Params: #{params.inspect}"
    Rails.logger.debug "File Param: #{params[:file].inspect}"
    # Save file
    if params[:file].is_a?(ActionDispatch::Http::UploadedFile)
      image_path = params[:file].tempfile.path
    else
      return render json: { error: "Invalid file upload" }, status: :unprocessable_entity
    end
    
    filename = "#{SecureRandom.uuid}-#{params[:file].original_filename}"
    file_url = "/uploads/#{filename}" # Adjust the path as needed

    # Move file to public/uploads
    FileUtils.mkdir_p(Rails.root.join("public/uploads"))
    FileUtils.mv(image_path, Rails.root.join("public/uploads/#{filename}"))

    # Save to images table
    image = Image.create!(file_url: file_url)

    # Update movie's image_id
    movie.update!(image_id: image.id)

    render json: { image_id: image.id, file_url: image.file_url }
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  # Find movie before running show, update, delete
  def set_movie
    @movie = Movie.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Movie not found" }, status: :not_found
  end

  # Allowed parameters
  def movie_params
    params.require(:movie).permit(:title, :score, :release_date, :status, :director_id, :image_id)
  end
end
  