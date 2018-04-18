require 'rubygems'
require 'nokogiri'
require 'open-uri'






# On déclare une méthode qui permet de récupérer l'adresse mail de la mairie
def get_the_email_of_a_townhal_from_its_webpage(url)

	#Ouverture de l'url du site de la ville
	page = Nokogiri::HTML(open(url)) 
	#Scrapping du mail de la mairie
	page.xpath('//body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text

end
#On déclare une méthode qui récupère le département d'une ville
def get_the_district (url)
	#Ouverture de l'url du site de la ville
	page = Nokogiri::HTML(open(url)) 
	#Scrapping du département
	page.xpath("//body/div/main/section[4]/div/table/tbody/tr[1]/td[2]").text
end

# On déclare une méthode qui récupère toutes les url des mairies du val d'oise et les stoquent

def get_all_the_urls_of_val_doise_townhalls(adress, adress1, adress2)

	#Ouverture de l'url de l'annuaire des mairies du val d'oise
	page = Nokogiri::HTML(open(adress))
	page2 = Nokogiri::HTML(open(adress1))
	page3 = Nokogiri::HTML(open(adress2))

	pages =[page,page2,page3]
	# dans un Hash nom, mail, departement 
	array = []
	
	puts "Je scrappe, je scrappe, vous pouvez prendre un café en attendant.... voire 2 !! Souriez c'est Mercredi. Pendant ce temps les données sont inscrites dans google drive."
	pages.each do |pageee|
	pageee.css(".lientxt").each do |link|
		#Scrapping de l'url de chaque mairie
		url = "http://annuaire-des-mairies.com" + link["href"][1..-1].to_s
		#Scrapping du nom de la ville
		ville_name = link.text
		#Scrapping de l'adresse mail de la mairie
		ville_email = get_the_email_of_a_townhal_from_its_webpage(url)
		#Scrapping du département de la ville
		ville_département = get_the_district(url)
		#Le tout stoqué dans un hash
		ville = {:name => ville_name, :email => ville_email, :district => ville_département}
		 
		array << ville
		
	end
end
	array

end




def spreadsheet(hash_array)
	require "google_drive"

	session = GoogleDrive::Session.from_config("config.json")
# je joins mes donnees au document
	ws = session.spreadsheet_by_key("1eeNBGXLzNIHelfMn18-pnQBeLZNUt719Fu5Sa7B_1HU").worksheets[0]
	i = 2
	# je place mes en-têtes
	ws[1, 1] = "Nom de ville"
	ws[1, 2] = "Adresse mail mairie"
	ws[1, 3] = "Département"
	
	# j'écris dans les colonnes 
	hash_array.each do |hash|

		ws[i, 1] = hash[:name]
		ws[i, 2] = hash[:email]
		ws[i, 3] = hash[:district]
		ws.save
		i += 1
	end

end

spreadsheet(get_all_the_urls_of_val_doise_townhalls("http://annuaire-des-mairies.com/deux-sevres.html", "http://annuaire-des-mairies.com/haute-corse.html","http://annuaire-des-mairies.com/bouches-du-rhone.html"))

