# app/controllers/items_controller.rb
class V2::ItemsController < ApplicationController
    before_action :set_item, only: [:show, :update, :destroy]
    before_action :set_todo, only: [:index, :create]

    # GET /todos/:todo_id/items  ...?
    def index
      json_response(@todo.items)
    end

    # GET /items/:id
    def show
      json_response(@item)
    end

    # POST /todos/:todo_id/items
    def create
      @todo.items.create!(item_params)
      json_response(@todo, :created)
    end

    # PUT /items/:id
    def update
      @item.update(item_params)
      head :no_content
    end

    # DELETE /items/:id
    def destroy
      @item.destroy
      head :no_content
    end

    private

    def item_params
      params.permit(:name, :done)
    end

    def set_item
      @item = Item.find(params[:id])
    end

    def set_todo
      @todo = Todo.find(params[:todo_id])
    end

  end
