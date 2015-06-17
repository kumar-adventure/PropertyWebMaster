class UserSearch < ActiveRecord::Base
  belongs_to :user

  search_syntax do

    search_by :text do |scope, phrases|
      columns = [:query]
      scope.where_like(columns => phrases)
    end

  end
end
