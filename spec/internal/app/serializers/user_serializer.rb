class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :password, :created_at, :updated_at
end
