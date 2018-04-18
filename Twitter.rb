require 'twitter'
require 'rubygems'
require 'json'
require 'google_drive'
require 'dotenv'
require 'csv'
require 'pry'




#Méthode pour follower les utilisateurs concernés par les tweets sur la liste des communes
def follow_users
    #Lecture du fichier .csv
    file = File.read('test.csv')

    session = GoogleDrive::Session.from_config("config.json")

ws = session.spreadsheet_by_key("1eeNBGXLzNIHelfMn18-pnQBeLZNUt719Fu5Sa7B_1HU").worksheets[0]
    #Parser le fichier .csv
    data_hash = []

(2..ws.num_rows).each do |row|
  data_hash << ws[row, 1]
end
return data_hash
end


# quelques lignes qui enregistrent les clés d'APIs
CLIENT = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CONSUMER']
    config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token        = ENV['TWITTER_TOKEN']
config.access_token_secret     = ENV['TWITTER_TOKEN_SECRET']
end

    #Initialisation du hash my_hash
    tab_users = []

    #On parcours le tableau reçu dans data_hash | Faire des recherches des noms des communes sur twitter
    #Récupérer les utilisateurs concerné par le tweet
    i = 0
    data_hash.each do |handle|
        CLIENT.search("@#{handle['name']}").take(1).each do |tweet|
            tab_users << tweet.user.screen_name
            data_hash[i]['handle_twitter'] = '@' + tweet.user.screen_name
            puts "Mairie #{data_hash[i]['name']} => #{tweet.user.screen_name}\n.publication => #{tweet.text}"
        end
        i += 1
    end

    #Ecriture du fichir .csv
    File.open("test.csv","w") do |f|
        f.write(data_hash.to_csv)
    end

    #Ici, on follow les utilisateur concernés
    tab_users.each do |users|
        puts users
        CLIENT.follow(users)
    end


follow_users
