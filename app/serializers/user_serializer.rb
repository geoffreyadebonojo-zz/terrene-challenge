class UserSerializer < ActiveModel::Serializer
    # attributes to be serialized
    attributes :name, :email, :id, :created_at, :updated_at
end
