Spree::Role.class_eval do
  def self.affiliate
    find_or_create_by(name: :affiliate)
  end
end
