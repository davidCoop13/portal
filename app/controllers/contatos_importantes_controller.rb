class ContatosImportantesController < ApplicationController

  def index

    @faqs = []
    path = "http://143.107.102.37:3001/faqs.json"

    response = RestClient.get path, {:accept => :json}
    faqs_json = JSON.parse response

    faqs_json.each do |f_json|
    	faq = Faq.new
    	faq.pergunta = f_json["question"]
    	faq.resposta = f_json["answer"]
    	@faqs << faq
    end
  end
end
