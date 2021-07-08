class Book < ApplicationRecord
    enum status: [:prestado, :estante]
end
