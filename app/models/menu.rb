class Menu
  include Mongoid::Document
  recursively_embeds_many
  
  field :url, :type => String
  field :nome, :type => String
  field :icon, :type => String
  
 # belongs_to :grupo
end
