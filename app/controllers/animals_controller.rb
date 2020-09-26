class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update, :destroy, :status]
  before_action :set_animal_kinds, only: [:new, :create, :edit, :update]

  def index
    @animals = Animal.animal_sort(sort_params).order(id: :desc)
  end

  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.new(animal_params)

    if @animal.save
      flash[:success] = 'Animal cadastrado com sucesso.'
      redirect_to animals_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @animal.update(animal_params)
      flash[:success] = 'Animal atualizado com sucesso.'
      redirect_to animals_path
    else
      render :edit
    end
  end

  def destroy
    if @animal.destroy
      flash[:success] = 'Animal excluído com sucesso.'
      redirect_to animals_path
    else
      render :index
    end
  end

  private

  def set_animal_kinds
    @animal_kinds = AnimalKind.select('id, kind').collect { |a| [ a.kind, a.id ] }
  end

  def animal_params
    params.require(:animal).permit(
      :name,
      :image,
      :image_cache,
      :date_of_birth,
      :adoption_status,
      :adopter_name,
      :animal_kind_id
    )
  end

  def set_animal
    @animal = Animal.friendly.find(params[:id])
  end

  def sort_params
    params[:sort].blank? ? nil : params[:sort].to_s
  end
end
