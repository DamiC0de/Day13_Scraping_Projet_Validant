require 'nokogiri'
require 'open-uri'
require 'uri'

# Méthode pour extraire l'adresse e-mail d'une page de mairie
def get_townhall_email(url)
    html_content = URI.open(url).read
    parsed_html = Nokogiri::HTML(html_content)
    email = nil
  
    parsed_html.css('tr.txt-primary.tr-last').each do |row|
      if row.css('td')[0].text.strip == 'Adresse Email'
        email = row.css('td')[1].text.strip
        break
      end
    end
  
    email
  end

# URL du site Web à extraire
url = "http://annuaire-des-mairies.com/val-d-oise.html"

# Ouvrir l'URL et lire le contenu HTML
html_content = URI.open(url).read

# Parser le contenu HTML avec Nokogiri
parsed_html = Nokogiri::HTML(html_content)

# Sélectionner les éléments HTML <a> avec la classe 'lientxt'
links = parsed_html.css('a.lientxt')

# Créer un tableau pour stocker les données extraites
data = []

# Itérer sur les éléments sélectionnés et extraire les liens et le texte
links.each do |link|
  href          = link['href']
  href          = href.sub(/^\./, '') # Supprimer le point (.) au début du lien
  mairie_url    = "http://annuaire-des-mairies.com#{href}"
  mairie        = link.text
  email         = get_townhall_email(mairie_url)
#   data << { mairie: mairie, email: email }
    data << { mairie => email }
end

# # Afficher le contenu du tableau
# data.each do |item|
#   puts "Mairies du Val-D'Oise: #{item[:text]}, Email: #{item[:email]}"
# end

puts data