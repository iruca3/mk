class UserStatusHistoryDecorator < Draper::Decorator
  delegate_all

  def status_with_link
    status_tag = object.status.gsub( /&/, '&amp;' ).gsub( /</, '&lt;' ).gsub( />/, '&gt;' ).gsub( /'/, '&quot;' )
    URI.extract( status_tag, %w{http https}).uniq.each do |uri|
      status_tag.gsub!(uri, %Q{<a href="#{uri}">#{uri}</a>})
    end
    status_tag
  end


end
