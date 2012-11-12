# encoding: utf-8

class Interest < ActiveRecord::Base
  has_and_belongs_to_many :users

  HUMANIZED_ATTRIBUTES = { :title => "Название интереса" }  ##
                                                            # Изменим начало для сообщений об ошибках
  def self.human_attribute_name(attr, options={})           # 
  HUMANIZED_ATTRIBUTES[attr.to_sym] || super                #
  end                                                       ##

  validates :title, presence: {message: "не может быть пустым."},
                   uniqueness: {message: "с таким написанием уже есть."},
                   length: { maximum: 30, message: "не должно превышать 30 символов." }
end
