class ItemsController < ApplicationController
  before_action :set_list
  before_action :set_item, only: %i[edit update destroy]

  # Ação index para exibir os itens da lista
  def index
    @items = @list.items
  end

  def new
    @item = @list.items.build
  end  

  def create
    @item = @list.items.build(item_params)
    if @item.save
      redirect_to @list, notice: "Item criado com sucesso!"
    else
      render :new
    end
  end
  
  def edit
    # A lógica necessária já está no `set_item`
  end

  def update
    if @item.update(item_params)
      redirect_to @list, notice: "Item atualizado com sucesso!"
    else
      render :edit
    end
  end

  # Ação destroy para excluir o item
  def destroy
    @item.destroy
    respond_to do |format|
      format.turbo_stream { render(turbo_stream: turbo_stream.remove(@item)) }
    end
  #  redirect_to @list, notice: "Item excluído com sucesso!" 
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
