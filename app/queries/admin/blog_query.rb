# frozen_string_literal: true
module Admin
   class BlogQuery
     FILTERS = {
       q: {
         operator: 'or',
         filters: [
           {
             column: 'CAST(blogs.id AS varchar)',
             operator: 'ILIKE'
           },
           {
             column: "unaccent(concat_ws(' ', trim(blogs.name)))",
             operator: 'ILIKE'
           },
           {
             column: 'blogs.email',
             operator: 'ILIKE'
           }
         ]
       }
     }.with_indifferent_access.freeze
   
     attr_reader :params
   
     def initialize(params)
       @params = params.to_h
     end
   
     def call
       relation = Blog.order(created_at: :desc)
       if params[:q].present?
         condition = FILTERS[:q][:filters].map do |f|
           ActiveRecord::Base.sanitize_sql_for_conditions(["#{f[:column]} #{f[:operator]} unaccent(?)", "%#{params[:q]}%"])
         end.join(" #{FILTERS[:q][:operator]} ")
         relation = relation.where(condition)
       end
       relation
     end
   end
 end