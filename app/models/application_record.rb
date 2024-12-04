class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  REGEX_EMAIL = /\A[^@\s]+@id\.uff\.br\z/
  REGEX_PHONE = /\A(\d{2})\D?9(\d{4})\D?(\d{4})\z/
end
