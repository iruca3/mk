textarea = $('textarea[name=status]')
current_content = textarea.val()
if current_content.length > 0
  current_content = "\n\n" + current_content

textarea.val( '<%= raw escape_javascript( @article.title ) %>\n<%= raw escape_javascript( @article.link ) %>' + current_content )
$('.loading-rss').hide()
$('.btn-getrss').show()

