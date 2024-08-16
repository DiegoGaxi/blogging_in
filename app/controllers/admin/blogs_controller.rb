module Admin
  class BlogsController < ApplicationController
    layout 'admin'
    include Pundit::Authorization
    include Pagy::Backend
    before_action :authorize_user
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

    def index
      @pagy_blogs, @blogs = pagy(search_records, page_param: :pagy_blogs, items: 10)
    end

    def new
      @blog = Blog.new
    end

    def create
      begin
        @blog = Blog.new(blog_params)
        @blog.save!
        redirect_to admin_blogs_path, notice: 'Blog creado exitosamente.'
      rescue StandardError => e
        redirect_to new_admin_blog_path, alert: e.message
      end
    end

    def edit
      @blog = Blog.find(params[:id])
      render :new
    end

    def update
      begin
        @blog = Blog.find(params[:id])
        @blog.update(blog_params)
        redirect_to admin_blogs_path, notice: 'Blog actualizado exitosamente.'
      rescue StandardError => e
        redirect_to new_admin_blog_path, alert: e.message
      end
    end

    def destroy
      @blog = Blog.find(params[:id])
      @blog.destroy
      redirect_to admin_blogs_path, notice: 'Blog eliminado exitosamente.'
    end

    private

    def search_records
      policy_scope(find_records(params.permit(:q)))
    end

    def find_records(criteria)
      Admin::BlogQuery.new(criteria).call
    end

    def blog_params
      params.require(:blog).permit(:id, :title, :content, :likes_count, :image, :video_url, :user_id, category_ids: [])
    end

    def authorize_user
      authorize current_user, policy_class: BlogPolicy
    end

    def handle_record_not_found
      redirect_back fallback_location: :back, alert: 'No se encontraron registros'
    end
  end
end
