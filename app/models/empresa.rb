class Empresa < Lugar
	include Mongoid::Paperclip

	field :cnpj, type: String	
	field :dump_id, type: Integer
	field :atividades, type: String
	has_one :admin_empresa
	has_many :gestor
	has_many :vagas
	has_many :estagios

	has_mongoid_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }

	validates_presence_of :cnpj, :message => "digite um CNPJ"

end
