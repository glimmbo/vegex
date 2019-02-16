class UserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :name,
    :email,
    :about,
    :address,
    :latitude,
    :longitude,
    :completion,
    :slots,
    :aasm_state,
    :created_at,
    :updated_at
  )
end
