class UserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :name,
    :email,
    :password,
    :password_confirmation,
    :location,
    :trade_completion,
    :trade_slots,
    :status,
    :created_at,
    :updated_at
  )
end
