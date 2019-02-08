class UserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :name,
    :email,
    :location,
    :trade_completion,
    :trade_slots,
    :status,
    :created_at,
    :updated_at
  )
end
