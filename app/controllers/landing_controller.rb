class LandingController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
  end

  def blog
    @pagy_blogs, @blogs = pagy(search_records, page_param: :pagy_blogs, items: 10)
    @categories = Category.all + [OpenStruct.new(id: 0, name: 'Todos')]
    @showing_blog = Blog.find_by(id: params[:id])
  end

  private

  def search_records
    policy_scope(BlogQuery.new(blog_params).call)
  end

  def blog_params
    params.permit(:q, :category)
  end
end