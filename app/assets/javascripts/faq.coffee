class @Faq
  constructor:(@container) ->
    @questionList = @container.find("> li")
    @questions = ({q: $(el).find("> h4"), a: $(el).find("> p")} for el in @container.find("li"))

    @searchInput = $("<input type='text' id='faq-search' class='full-width' placeholder='digite o texto aqui...'/>")
    @searchInputFake = $("<input type='hidden' id='faq-search_fake' class='full-width' placeholder='digite o texto aqui...'/>")

    @container.before @searchInput
    @container.before @searchInputFake

    i = 0
    @toc = ($("<li><span class='faq-number'>#{++i}</span> <a href='#faq-question-#{i}'>#{el.q.text()}</a></li>") for el in @questions)

    i = 0
    el.q.attr("id", "faq-question-#{++i}") for el in @questions
    @tocLinksContainer = $("<ol class='faq-questions'></ol>")
    @tocLinksContainer.append(link) for link in @toc
    @searchInput.after(@tocLinksContainer)

    @tocLinksContainer.after "<hr/>"

    i = 0
    question.q.prepend("<span class='faq-number'>#{++i}</span>") for question in @questions

    @tocLinks = @tocLinksContainer.find("li")


    @searchInput.keyup =>
      val = @searchInput.val()
      if val.length > 0
        @questionList.each (index, li) =>
          el = $(li)
          pattern = new RegExp(val, 'i');
          if !pattern.test(el.text())
            el.hide()
            $(@tocLinks[index]).hide()
          else
            el.show()
            $(@tocLinks[index]).show()
      else
        @questionList.each -> $(@).show()
        @tocLinks.each -> $(@).show()

    @searchInputFake.keyup =>
      val = @searchInputFake.val()
      if val.length > 0
        @questionList.each (index, li) =>
          el = $(li)
          pattern = new RegExp(val, 'i');
          if !pattern.test(el.text())
            el.hide()
            $(@tocLinks[index]).hide()
          else
            el.show()
            $(@tocLinks[index]).show()
      else
        @questionList.each -> $(@).show()
        @tocLinks.each -> $(@).show()