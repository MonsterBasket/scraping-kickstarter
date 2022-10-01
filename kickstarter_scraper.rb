require 'nokogiri'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  # kickstarter.css(".project-card") # project
  # kickstarter.css(".project-card h2.bbcard_name strong a") # title
  # kickstarter.css("div.project-thumbnail a img").each do |item| p "#{item.attribute("src")}" end # image
  # kickstarter.css("p.bbcard_blurb").each {|item| p item.text} # blurb
  # kickstarter.css(".location-name").each {|item| p item.text} # location
  # kickstarter.css(".project-stats .first.funded strong") # percent funded

  projects = {}

  kickstarter.css(".project-card").each do |item|
    title = item.css(".bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => item.css(".project-thumbnail a img").attribute("src").value,
      :description => item.css("p.bbcard_blurb").text,
      :location => item.css(".location-name").text,
      :percent_funded => item.css(".project-stats .first.funded strong").text.gsub("%","").to_i
    }
  end
  projects
end

create_project_hash