class Interest < ActiveRecord::Base
  has_and_belongs_to_many :users
end
# TODO: Валидации - чтобы интересы были уникальны и длина или еще что..