#encoding: UTF-8
xml.instruct! :xml, version: '1.0'
xml.rss :version => '2.0', 'xmlns:media' => 'http://search.yahoo.com/mrss/', 'xmlns:daNews' => 'http://inbox.disruptiveangels.com/issues/feed' do
  xml.channel do
    xml.title 'Amazify Newsletter'
    xml.description @issue.id
    xml.language 'en'

    @issue.articles.each do |article|
      xml.item do
        if article.title
          xml.title article.title
        else
          xml.title ''
        end
        xml.author article.reading_time
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link article.link
        xml.category article.category.name
        xml.media(:content, url: article.image, type: 'image/*', medium: 'image')
        xml.description article.description
      end
    end
  end
end
