class PersonsController < ApplicationController
    # 🔹 GET /persons (Read All)
    def index
        persons = Person.all
        render json: persons
    end

    # 🔹 GET /persons/:id (Read One)
    def show
        render json: @person
    end

    # 🔹 POST /persons (Create)
    def create
        person = Person.new(person_params)
        
        if person.save
        render json: person, status: :created
        else
        render json: { errors: person.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # 🔹 PUT/PATCH /persons/:id (Update)
    def update
        person = Person.find(params[:id])

        if person.update(person_params)
        render json: person, status: :ok
        else
        render json: { errors: person.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # 🔹 DELETE /persons/:id (Delete)
    def destroy
        @person.destroy
        head :no_content
    end

    def roles
        render json: Person.roles_list
    end

    private

    # Find person before running show, update, delete
    def set_person
      @person = Person.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Person not found" }, status: :not_found
    end
  
    # Allowed parameters
    def person_params
      params.require(:person).permit(:name, :role)
    end
end
