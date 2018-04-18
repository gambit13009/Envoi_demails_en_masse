
require "gmail"
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require "google_drive"
require 'dotenv'
require 'pry'
Dotenv.load

def send_email_to_line
#prendra l'email en colonne B, et lui enverra un message, qui pourra être alterné en fonction du nom de la mairie en colonne A
session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1eeNBGXLzNIHelfMn18-pnQBeLZNUt719Fu5Sa7B_1HU").worksheets[0]
#on lie la spreadsheet où figurent les adresses mail.
gmail = Gmail.connect!(ENV['GMAIL_USERNAME'], ENV['GMAIL_PASSWORD'])
#on se conecte à gmail
i = 2
array = []
city = []
while (ws[i, 2]).length != 0 do
  array << ws[i, 2]
  i+=1
end
i = 2
while (ws[i, 1]).length != 0 do
  city << ws[i, 1]
  i+=1
end
i = 0
  array.each do |adress|

    gmail.deliver do
      to adress
      subject "Bonjour "+ city[i] +" voici un projet du Hacking Project !"

      text_part do
        body ""
      end
      html_part do
        content_type 'text/html; charset=UTF-8'
        body "<p>Bonjour,</p>
        <p><em>Je m'appelle Juliette, je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de notre école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.

        Déjà 300 personnes sont passées par The Hacking Project. Est-ce que la mairie de " + city[i] + " veut changer le monde avec nous ?


        Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80.</p>
        <p> Très bonne journée à vous :) </p>
        <p> Jean Michel Lolle </p>"

      end
  add_file "logo_thp.png"

  end
  i+=1


end
gmail.logout
end


send_email_to_line
