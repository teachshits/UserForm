class User < ActiveRecord::Base
  has_and_belongs_to_many :interests
end
# TODO: Валидации - чтобы были уникальны имена