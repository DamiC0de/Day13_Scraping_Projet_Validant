require 'nokogiri'
require 'open-uri'

url = 'https://coinmarketcap.com/all/views/all/'

# Récupération de la page HTML avec open-uri
response = URI.open(url)

# Analyse de la page HTML avec Nokogiri
html_doc = Nokogiri::HTML(response.read)

# Sélection des lignes du tableau de cryptomonnaies
cryptos = html_doc.css('tbody tr')

# Création du tableau pour stocker les cryptomonnaies
cryptos_array = []

# Parcours des lignes pour extraire les informations
cryptos.each do |crypto|
  symbol = crypto.css('a.cmc-table__column-name--symbol').text.strip
  price = crypto.css('td.cmc-table__cell--sort-by__price a span').text.strip.gsub('$', '').gsub(',', '').to_f

  # Ajout de la cryptomonnaie au tableau si le symbole et le prix ne sont pas vides
  if !symbol.empty? && price != 0.0
    cryptos_array << { symbol => price }
  end
end

# Affichage du tableau
puts cryptos_array
