class LandingController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
    @pagy_blogs, @blogs = pagy(search_records, page_param: :pagy_blogs, items: 10)
  end

  def blog
    @pagy_blogs, @blogs = pagy(search_records, page_param: :pagy_blogs, items: 10)
    @categories = Category.all + [OpenStruct.new(id: 0, name: 'Todos')]
    @showing_blog = Blog.find_by(id: params[:id])
  end

  def blog_like
    @showing_blog = Blog.find(params[:id])
    @showing_blog.likes_count += 1
    @showing_blog.save!
    render :blog
  end

  private

  def search_records
    BlogQuery.new(blog_params).call
  end

  def blog_params
    params.permit(:q, :category, :alias)
  end
end