class CandidaturasController < ApplicationController
	# GET /candidaturas
	# GET /candidaturas.json
	def index
		if current_usuario.isAdminEmpresa?
			# TODO: Fazer query direto no banco.
			@candidaturas = Candidatura.all.select { |c| c.vaga.empresa.id == current_usuario.empresa_id }
		elsif current_usuario.isAluno?
			@candidaturas = current_usuario.candidaturas
		elsif current_usuario.isAdmin?
			@candidaturas = Candidatura.all
		else
			render_404
		end

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @candidaturas }
		end
	end

	def aceitar
		if current_usuario.isAluno?
			vaga = Vaga.find(params[:id])

			candidatura = Candidatura.new
			candidatura.aluno = current_usuario
			candidatura.vaga = vaga
			candidatura.aceita = false
			candidatura.validada = false
			candidatura.save

			redirect_to candidaturas_url
		elsif current_usuario.isAdminEmpresa?
			candidatura = Candidatura.find(params[:id])
			candidatura.aceita = true
			candidatura.save

			respond_to do |format|
				format.html { redirect_to candidaturas_url }
				format.json { head :no_content }
			end
		elsif current_usuario.isAdmin?
			candidatura = Candidatura.find(params[:id])
			candidatura.validada = true
			candidatura.save

			respond_to do |format|
				format.html { redirect_to candidaturas_url }
				format.json { head :no_content }
			end
		else
			render_404
		end
	end

	def desistir
		candidatura = Candidatura.find(params[:id])
		if current_usuario.isAluno?
			candidatura.destroy
		elsif current_usuario.isAdminEmpresa?
			candidatura.aceita = false
			candidatura.validada = false
			candidatura.save
		elsif current_usuario.isAdmin?
			candidatura.validada = false
			candidatura.save
		else
			render_404
		end

		respond_to do |format|
			format.html { redirect_to candidaturas_url }
			format.json { head :no_content }
		end
	end

end