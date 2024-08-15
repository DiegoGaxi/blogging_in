# frozen_string_literal: true
module Admin
  class UserQuery
    FILTERS = {
      q: {
        operator: 'or',
        filters: [
          {
            column: 'CAST(users.id AS varchar)',
            operator: 'ILIKE'
          },
          {
            column: "unaccent(concat_ws(' ', trim(users.first_name), trim(nullif(users.middle_name, '')), trim(users.paternal_surname), trim(users.maternal_surname)))",
            operator: 'ILIKE'
          },
          {
            column: 'users.mobile_phone',
            operator: 'ILIKE'
          },
          {
            column: 'users.email',
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
      relation = User.order(created_at: :desc)
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