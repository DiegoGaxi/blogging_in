class BloggerController < ApplicationController
    layout "application"
    skip_before_action :authenticate_user!, only: [:show, :blog]
    before_action :set_user
  
    def show
      @landing = {
        title: "Ingeniero Diego Gaxiola",
        subtitle: "Especialista en Desarrollo web",
        description: "Apasionado por el desarrollo de sistemas y especializado en automatizaciones de procesos empresariales, estoy aquí para ayudarte a resolver tus problemas de la mejor forma posible.",
        call_to_action_text: nil,
      }
      @pagy_blogs, @blogs = pagy(search_records, page_param: :pagy_blogs, items: 10)
    end
  
    def blog
      @pagy_blogs, @blogs = pagy(search_records, page_param: :pagy_blogs, items: 10)
      @categories = Category.all + [OpenStruct.new(id: 0, name: 'Todos')]
      @showing_blog = @blogs.find_by(id: params[:id]) || nil
    end

    private
  
    def set_user
      @user = User.find_by(alias: params[:alias])
    end
  
    def search_records
      policy_scope(find_records(params.permit(:q, :category, :alias)))
    end
  
    def find_records(criteria)
      BlogQuery.new(criteria).call
    end
  end