class Product < ApplicationRecord
    validates :name, :price, :quantity, presence: true
    validates :quantity, comparison: {greater_than: -1}
    validates :price, comparison: {greater_than: 0}
    validates :name, uniqueness: true
end
