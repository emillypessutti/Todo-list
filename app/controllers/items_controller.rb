class ItemsController < ApplicationController
  before_action :set_list
  before_action :set_item, only: %i[edit update destroy] 

  def create
    @item = @list.items.build(item_params)
    if @item.save
      redirect_to @list, notice: "Item created successfully!"
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @list, notice: "Item updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.turbo_stream { render(turbo_stream: turbo_stream.remove(@item)) }
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_item
    @item = @list.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :content)
  end
end
