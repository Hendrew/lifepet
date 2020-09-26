class AnimalKindsController < ApplicationController
  before_action :set_animal_kind, only: [:edit, :update, :destroy, :status]

  def index
    @animal_kinds = AnimalKind.order(id: :desc)
  end

  def new
    @animal_kind = AnimalKind.new
  end

  def create
    @animal_kind = AnimalKind.new(animal_kind_params)

    if @animal_kind.save
      flash[:success] = 'Tipo de animal cadastrado com sucesso.'
      redirect_to animal_kinds_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @animal_kind.update(animal_kind_params)
      flash[:success] = 'Tipo de animal atualizado com sucesso.'
      redirect_to animal_kinds_path
    else
      render :edit
    end
  end

  def destroy
    if @animal_kind.destroy
      flash[:success] = 'Tipo de animal excluído com sucesso.'
      redirect_to animal_kinds_path
    else
      render :index
    end
  end

  private

  def animal_kind_params
    params.require(:animal_kind).permit(:kind)
  end

  def set_animal_kind
    @animal_kind = AnimalKind.friendly.find(params[:id])
  end
end
