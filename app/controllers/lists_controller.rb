class ListsController < ApplicationController
  before_action :set_list, only: %i[show edit update destroy]

  def index
    @lists = List.all
    @new_list = List.new
  end

  def show
    @items = @list.items  
  end  

  def edit
    @items = @list.items 
  end

  def create
    @new_list = List.new(list_params)

    respond_to do |format|
      if @new_list.save
        format.html { redirect_to @new_list, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @new_list }
      else
        format.html do
          @lists = List.all
          render :index, status: :unprocessable_entity
        end
        format.json { render json: @new_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_path, status: :see_other, notice: "Task was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

    def set_list
      @list = List.find(params[:id]) 
    end

    def list_params
      params.require(:list).permit(:name) 
    end
end
