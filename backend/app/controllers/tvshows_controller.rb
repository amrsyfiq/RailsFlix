class TvshowsController < ApplicationController
before_action :set_tvshow, only: [:show, :update, :destroy]

# 🔹 GET /tvshows (Read All)
def index
    tvshows = Tvshow.includes(:genres, :actors, :director, :image).all
    render json: tvshows, include: [:genres, :actors, :director, :image]
end

# 🔹 GET /tvshows/:id (Read One)
def show
    render json: @tvshow, include: [:genres, :director, :image]
end

# 🔹 POST /tvshows (Create)
def create
    tvshow = Tvshow.new(tvshow_params)
    
    if tvshow.save
    tvshow.genres << Genre.where(id: params[:genre_ids]) # Assign multiple genres
    tvshow.actors << Person.where(id: params[:actor_ids]) # Assign multiple actors
    render json: tvshow, status: :created
    else
    render json: { errors: tvshow.errors.full_messages }, status: :unprocessable_entity
    end
end

# 🔹 PUT/PATCH /tvshows/:id (Update)
def update
    tvshow = Tvshow.find(params[:id])

    if tvshow.update(tvshow_params)
    tvshow.genres = Genre.where(id: params[:genre_ids])
    tvshow.actors = Person.where(id: params[:actor_ids])
    render json: tvshow, status: :ok
    else
    render json: { errors: tvshow.errors.full_messages }, status: :unprocessable_entity
    end
end

# 🔹 DELETE /tvshows/:id (Delete)
def destroy
    @tvshow.destroy
    head :no_content
end

def statuses
    render json: Tvshow.statuses_list
end

def image
    tvshow = Tvshow.find(params[:id])

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

    # Update tvshow's image_id
    tvshow.update!(image_id: image.id)

    render json: { image_id: image.id, file_url: image.file_url }
rescue => e
    render json: { error: e.message }, status: :internal_server_error
end

private

# Find tvshow before running show, update, delete
def set_tvshow
    @tvshow = Tvshow.find(params[:id])
rescue ActiveRecord::RecordNotFound
    render json: { error: "Tvshow not found" }, status: :not_found
end

# Allowed parameters
def tvshow_params
    params.require(:tvshow).permit(:title, :score, :release_date, :status, :director_id, :image_id)
end
end
